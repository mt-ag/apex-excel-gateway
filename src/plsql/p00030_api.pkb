create or replace package body p00030_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure generate_excel_file ( 
    pi_tpl_id in r_templates.tpl_id%type
  , pi_per_id in r_person.per_id%type    
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_excel_file';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_per_id', pi_per_id);
    logger.log('START', l_scope, null, l_params);

    -- remove old files
      update template_import_status
         set tis_fil_id = null
       where tis_fil_id in (      
        select tis_fil_id
          from template_import_status
         where tis_fil_id is not null
           and tis_tpl_id = pi_tpl_id
           and tis_per_id = pi_per_id 
      );

      logger.log_info('update => ' || sql%rowcount);

      delete from files where fil_id not in (
        select distinct tis_fil_id
          from template_import_status
      );

      logger.log_info('delete => ' || sql%rowcount);

    for rec in (
      select tis_id
           , tpl_id
           , tpl_name
           , per_id
           , per_firstname
           , per_lastname
        from template_import_status
        join r_templates
          on tis_tpl_id = tpl_id
        join r_person
          on tis_per_id = per_id
       where tis_tpl_id = pi_tpl_id
         and per_id = pi_per_id
    )
    loop    
      excel_gen.generate_single_file (
        pi_tis_id        => rec.tis_id
      , pi_tpl_id        => rec.tpl_id
      , pi_tpl_name      => rec.tpl_name
      , pi_per_id        => rec.per_id
      , pi_per_firstname => rec.per_firstname
      , pi_per_lastname  => rec.per_lastname
      );

    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_excel_file;

  procedure send_mail(
    pi_choice       in pls_integer,
    pi_app_id       in pls_integer,
    pi_app_page_id  in pls_integer,
    pi_static_id    in varchar2
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'send_mail';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_choice', pi_choice);
    logger.log('START', l_scope, null, l_params);

    if pi_choice = 1 then

      email_pkg.new_template(
        p_App_ID    => pi_app_id, 
        p_Page_ID   => pi_app_page_id, 
        p_static_id => pi_static_id
      );

    elsif pi_choice = 2 then

      email_pkg.corrected_template(
        p_App_ID    => pi_app_id, 
        p_Page_ID   => pi_app_page_id, 
        p_static_id => pi_static_id
      );

    elsif pi_choice = 3 then

      email_pkg.reminder(
        p_App_ID    => pi_app_id, 
        p_Page_ID   => pi_app_page_id, 
        p_static_id => pi_static_id
      );

    end if;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end send_mail;

end p00030_api;
/