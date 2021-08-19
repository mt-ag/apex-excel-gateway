create or replace package master_api as  
  
  function get_faulty_id
    return r_header.hea_id%type deterministic result_cache
  ;

  function get_annotation_id
    return r_header.hea_id%type deterministic result_cache
  ;

  function get_feedback_id
    return r_header.hea_id%type deterministic result_cache
  ;

  function get_validation_id
    return r_header.hea_id%type deterministic result_cache
  ;

end master_api;
/