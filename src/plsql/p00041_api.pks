create or replace package p00041_api
as

  procedure upload_file (
    pi_collection_name in  apex_collections.collection_name%type default 'DROPZONE_UPLOAD'
  , pi_tpl_id          in  r_templates.tpl_id%type   
  , po_error_occurred  out nocopy number
  );

end p00041_api;
/