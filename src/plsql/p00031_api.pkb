create or replace package body p00031_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure add_person(
    pi_tpl_id in r_templates.tpl_id%type
  , pi_per_id in r_person.per_id%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'add_person';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_per_id', pi_per_id);
    logger.log('START', l_scope, null, l_params);

    insert into template_import_status
      (tis_tpl_id, tis_per_id, tis_sts_id, tis_shipping_status)
    values
      (pi_tpl_id, pi_per_id, 1, 1);

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end add_person;

end p00031_api;
/