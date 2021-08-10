create or replace package file_import
as

  function remove_empty_spaces(
    pi_string in varchar2
  ) return varchar2
  ;

  procedure upload_file (
    pi_collection_name in  apex_collections.collection_name%type default 'DROPZONE_UPLOAD'
  , pi_tpl_id          in  r_templates.tpl_id%type
  , po_error_occurred  out nocopy number
  );

end file_import;
/