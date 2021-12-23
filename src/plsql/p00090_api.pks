create or replace package p00090_api
as

  procedure delete_template (
    pi_tpl_id          in  r_templates.tpl_id%type
  );

end p00090_api;
/