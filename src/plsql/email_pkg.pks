create or replace package email_pkg as 

  procedure new_template(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  );
  
  procedure new_template_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type
  );

  procedure corrected_template(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  );
  
  procedure corrected_template_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type
  );

  procedure reminder(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  );
  
  procedure reminder_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type
  );

end email_pkg;
/