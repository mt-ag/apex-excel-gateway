create or replace package body p00041_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure upload_file (
    pi_collection_name in  apex_collections.collection_name%type default 'DROPZONE_UPLOAD'
  , pi_tpl_id          in  r_templates.tpl_id%type       
  , po_error_occurred  out nocopy number
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'upload_file';
    l_params logger.tab_param;

  begin
    logger.append_param(l_params, 'pi_collection_name', pi_collection_name);
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.log('START', l_scope, null, l_params);

    file_import.upload_file (
      pi_collection_name => pi_collection_name
    , pi_tpl_id          => pi_tpl_id    
    , po_error_occurred  => po_error_occurred
    );

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end;

end p00041_api;
/