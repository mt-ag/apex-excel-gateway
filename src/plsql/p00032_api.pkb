create or replace package body p00032_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure save_automation(
    pi_tpa_tpl_id      in template_automations.tpa_tpl_id%type,
    pi_tpa_enabled in template_automations.tpa_enabled%type,
    pi_tpa_days    in template_automations.tpa_days%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'save_automation';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_tpa_tpl_id', pi_tpa_tpl_id);
    logger.append_param(l_params, 'pi_tpa_enabled', pi_tpa_enabled);
    logger.append_param(l_params, 'pi_tpa_days', pi_tpa_days);
    logger.log('START', l_scope, null, l_params);

    update template_automations
       set tpa_enabled = pi_tpa_enabled,
           tpa_days = pi_tpa_days
     where tpa_tpl_id = pi_tpa_tpl_id;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end save_automation;

end p00032_api;
/