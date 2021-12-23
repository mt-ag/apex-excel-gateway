create or replace package body p00085_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure edit_template (
    pi_tpl_id in r_templates.tpl_id%type       
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'edit_template';
    l_params logger.tab_param;
    l_tpl_id r_templates.tpl_id%type;
    l_tph_id template_header.tph_id%type;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.log('START', l_scope, null, l_params);

    for rec in ( 
        select distinct
               c001 as tpl_id, 
               c006 as tpl_deadline, 
               c007 as tpl_number_of_rows, 
               c011 as tpl_ssp_id
          from apex_collections 
         where collection_name = 'EDIT_TEMPLATE' 
           and c001 is not null
    ) 
    loop
        update r_templates 
          set tpl_deadline = rec.tpl_deadline,
              tpl_number_of_rows = rec.tpl_number_of_rows,
              tpl_ssp_id = rec.tpl_ssp_id
        where tpl_id = rec.tpl_id
        returning tpl_id INTO l_tpl_id;
        
        if l_tpl_id is not null then
            delete template_header
            where tph_tpl_id = l_tpl_id;

            delete template_header_validations
            where thv_tph_id in (select tph_id from template_header where tph_tpl_id = l_tpl_id); 
        end if;
    end loop;

    if l_tpl_id is not null then
        for rec in ( 
            select seq_id as tph_sort_order, c001 as tpl_id, c002 as tph_hea_id, 
                  c003 as hea_text, replace(c004,'#','ff') as tph_xlsx_font_color, replace(c005,'#','ff') as tph_xlsx_background_color,
                  c006 as tpl_deadline, c007 as tpl_number_of_rows, c008 as tph_thg_id, c009 as thv_formula1, c010 as thv_formula2,
                  c011 as tpl_ssp_id
              from apex_collections 
            where collection_name = 'EDIT_TEMPLATE' 
          order by seq_id
        ) 
        loop 
            insert into template_header 
            (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order, tph_thg_id)
            VALUES (l_tpl_id, rec.tph_hea_id, rec.tph_xlsx_background_color, rec.tph_xlsx_font_color, rec.tph_sort_order, rec.tph_thg_id)
            RETURNING tph_id into l_tph_id;
            
            if rec.thv_formula1 is not null or rec.thv_formula2 is not null then
                insert into template_header_validations
                (thv_tph_id, thv_formula1, thv_formula2)
                VALUES (l_tph_id, rec.thv_formula1, rec.thv_formula2);
            end if;
        end loop;
    end if;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end edit_template;

  procedure create_preview (
    pi_collection_name in  apex_collections.collection_name%type default 'EDIT_TEMPLATE'       
  )
  as
    l_scope     logger_logs.scope%type := gc_scope_prefix || 'create_preview';
    l_params    logger.tab_param;
    l_tpl_id    r_templates.tpl_id%type;
    l_tpl_name  r_templates.tpl_name%type;
    l_tph_id    template_header.tph_id%type;
  begin
    logger.append_param(l_params, 'pi_collection_name', pi_collection_name);
    logger.log('START', l_scope, null, l_params);
    
    select tpl_name 
      into l_tpl_name
      from r_templates
     where tpl_id = (select distinct c001 as tpl_id 
                       from apex_collections 
                      where collection_name = 'EDIT_TEMPLATE' 
                        and c001 is not null);    
    
    for rec in ( 
        select seq_id as tph_sort_order, c001 as tpl_id, c002 as tph_hea_id, 
               c003 as hea_text, replace(c004,'#','ff') as tph_xlsx_font_color, replace(c005,'#','ff') as tph_xlsx_background_color,
               c006 as tpl_deadline, c007 as tpl_number_of_rows, c008 as tph_thg_id, c009 as thv_formula1, c010 as thv_formula2,
               c011 as ssp_id
          from apex_collections 
         where collection_name = 'EDIT_TEMPLATE' 
      order by seq_id
    ) 
    loop   
    
        if l_tpl_id is null then
            insert into r_templates 
            (tpl_id, tpl_name, tpl_deadline, tpl_number_of_rows, tpl_ssp_id) 
            VALUES (0, 'preview', nvl(rec.tpl_deadline,7), nvl(rec.tpl_number_of_rows,100), rec.ssp_id)
            RETURNING tpl_id into l_tpl_id;
        end if;

        insert into template_header 
        (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order, tph_thg_id)
        VALUES (l_tpl_id, rec.tph_hea_id, rec.tph_xlsx_background_color, rec.tph_xlsx_font_color, rec.tph_sort_order, rec.tph_thg_id)
        RETURNING tph_id into l_tph_id;
        
        if rec.thv_formula1 is not null or rec.thv_formula2 is not null then
            insert into template_header_validations
            (thv_tph_id, thv_formula1, thv_formula2)
            VALUES (l_tph_id, rec.thv_formula1, rec.thv_formula2);
        end if;  

        end loop;

        excel_gen.generate_single_file (
          pi_tis_id         => 0
        , pi_tpl_id         => l_tpl_id
        , pi_tpl_name       => l_tpl_name
        , pi_per_id         => 123456789
        , pi_per_firstname  => 'sample'
        , pi_per_lastname   => 'file'
        );

        -- delete preview data
        delete template_header_validations where thv_tph_id in (select tph_id from template_header where tph_tpl_id = l_tpl_id);
        delete template_header where tph_tpl_id = l_tpl_id;
        delete r_templates where tpl_id = l_tpl_id;
   
    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end create_preview;    

end p00085_api;
/