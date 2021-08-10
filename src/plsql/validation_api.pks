create or replace package validation_api as 

  function validate_data(
    p_tid_text      template_import_data.tid_text%type
  , p_val_text      r_validation.val_text%type
  ) return boolean;
  
  procedure validation (
    p_tis_id in template_import_status.tis_id%type
  );

end validation_api;
/