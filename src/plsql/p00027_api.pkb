create or replace package body p00027_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure save_header (
    pi_hea_text         in r_header.hea_text%type
  , pi_hea_xlsx_width   in r_header.hea_xlsx_width%type
  , pi_hea_val_id       in r_header.hea_val_id%type
  , pi_dropdown_values  in varchar2        
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'save_header';
    l_params logger.tab_param;
    l_hea_id r_header.hea_id%type;
  begin
    logger.append_param(l_params, 'pi_hea_text', pi_hea_text);
    logger.append_param(l_params, 'pi_hea_xlsx_width', pi_hea_xlsx_width);
    logger.append_param(l_params, 'pi_hea_val_id', pi_hea_val_id);
    logger.append_param(l_params, 'pi_dropdown_values', pi_dropdown_values);
    logger.log('START', l_scope, null, l_params);

    insert into r_header (HEA_TEXT, HEA_XLSX_WIDTH, HEA_VAL_ID)
    values (pi_hea_text, pi_hea_xlsx_width, pi_hea_val_id)
    returning hea_id into l_hea_id;

    insert into r_dropdowns (DDS_HEA_ID, DDS_TEXT)
    select l_hea_id, column_value From TABLE(apex_string.split(pi_dropdown_values,':'));

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end save_header;
  
end p00027_api;
/