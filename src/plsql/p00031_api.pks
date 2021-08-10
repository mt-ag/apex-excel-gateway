create or replace package p00031_api
as

  procedure add_person(
    pi_tpl_id in r_templates.tpl_id%type
  , pi_per_id in r_person.per_id%type
  );

end p00031_api;
/