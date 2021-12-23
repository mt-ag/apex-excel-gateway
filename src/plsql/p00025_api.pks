create or replace package p00025_api as 

  procedure create_new_template(
    pi_collection_name in  apex_collections.collection_name%type default 'CREATE_TEMPLATE'  
  );

  procedure create_preview(
    pi_collection_name in  apex_collections.collection_name%type default 'CREATE_TEMPLATE'  
  );

end p00025_api;
/