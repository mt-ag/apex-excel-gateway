create or replace package p00032_api
as

  procedure save_automation(
    pi_tpa_tpl_id  in template_automations.tpa_tpl_id%type,
    pi_tpa_enabled in template_automations.tpa_enabled%type,
    pi_tpa_days    in template_automations.tpa_days%type
  );

end p00032_api;
/