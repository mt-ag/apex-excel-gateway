create or replace package p00030_api
as

  procedure generate_excel_file ( 
    pi_tpl_id in r_templates.tpl_id%type,
    pi_per_id in r_person.per_id%type    
);

  procedure send_mail(
    pi_choice       in pls_integer,
    pi_app_id       in pls_integer,
    pi_app_page_id  in pls_integer,
    pi_static_id    in varchar2
  ); 

end p00030_api;
/