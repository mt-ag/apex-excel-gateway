create or replace package body p00090_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure delete_template (
    pi_tpl_id          in  r_templates.tpl_id%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'delete_template';
    l_params logger.tab_param;

  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.log('START', l_scope, null, l_params);

    -- delete template data
    delete template_import_data where tid_tis_id in (select tis_id from template_import_status where tis_tpl_id = pi_tpl_id);
    delete template_import_status where tis_tpl_id = pi_tpl_id;
    delete template_automations where tpa_tpl_id = pi_tpl_id;
    delete template_header_validations where thv_tph_id in (select tph_id from template_header where tph_tpl_id = pi_tpl_id);
    delete template_header where tph_tpl_id = pi_tpl_id;
    delete r_templates where tpl_id = pi_tpl_id;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end;

end p00090_api;
/