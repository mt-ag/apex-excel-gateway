create or replace package p00085_api as 

  procedure edit_template(
    pi_tpl_id in r_templates.tpl_id%type  
  );

  procedure create_preview(
    pi_collection_name in  apex_collections.collection_name%type default 'EDIT_TEMPLATE'  
  );

end p00085_api;
/