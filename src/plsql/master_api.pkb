create or replace package body master_api as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  function get_faulty_id
    return r_header.hea_id%type deterministic result_cache
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_faulty_id';
    l_params logger.tab_param;

    l_faulty_id r_header.hea_id%type;
  begin
    select hea_id
      into l_faulty_id
      from r_header
     where hea_text = 'Faulty'
    ;

    return l_faulty_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_faulty_id;

  function get_annotation_id
    return r_header.hea_id%type deterministic result_cache
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_annotation_id';
    l_params logger.tab_param;

    l_annotation_id r_header.hea_id%type;
  begin
    select hea_id
      into l_annotation_id
      from r_header
     where hea_text = 'Annotation'
    ;

    return l_annotation_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_annotation_id;

  function get_feedback_id
    return r_header.hea_id%type deterministic result_cache
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_feedback_id';
    l_params logger.tab_param;

    l_feedback_id r_header.hea_id%type;
  begin
    select hea_id
      into l_feedback_id
      from r_header
     where hea_text = 'Feedback'
    ;

    return l_feedback_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_feedback_id;

  function get_validation_id
    return r_header.hea_id%type deterministic result_cache
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_validation_id';
    l_params logger.tab_param;

    l_validation_id r_header.hea_id%type;
  begin
    select hea_id
      into l_validation_id
      from r_header
     where hea_text = 'Validation'
    ;

    return l_validation_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_validation_id;

end master_api;
/  