create or replace package body p00028_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure save_header_group (
    pi_thg_text                   in template_header_group.thg_text%type
  , pi_thg_xlsx_background_color  in template_header_group.thg_xlsx_background_color%type
  , pi_thg_xlsx_font_color        in template_header_group.thg_xlsx_font_color%type      
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'save_header';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_thg_text', pi_thg_text);
    logger.append_param(l_params, 'pi_thg_xlsx_background_color', pi_thg_xlsx_background_color);
    logger.append_param(l_params, 'pi_thg_xlsx_font_color', pi_thg_xlsx_font_color);
    logger.log('START', l_scope, null, l_params);

    insert into template_header_group (thg_text, thg_xlsx_background_color, thg_xlsx_font_color)
    values (pi_thg_text, replace(pi_thg_xlsx_background_color,'#','ff'), replace(pi_thg_xlsx_font_color,'#','ff'));

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end save_header_group;
  
end p00028_api;
/