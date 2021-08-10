set define '^'
set concat '.'

PROMPT >> Excel Gateway for Oracle APEX
PROMPT >> =======================

PROMPT >> Please enter needed Variables

ACCEPT ws_name char default 'MT_EXCEL_GATEWAY' PROMPT 'Enter Workspace Name: [MT_EXCEL_GATEWAY]'
ACCEPT parsing_schema char default 'MT_EXCEL_GATEWAY' PROMPT 'Enter Parsing Schema: [MT_EXCEL_GATEWAY]'
ACCEPT app_alias char default 'MT_EXCEL_GATEWAY' PROMPT 'Enter Application Alias: [MT_EXCEL_GATEWAY]'
ACCEPT app_name char default 'Excel Gateway for Oracle APEX' PROMPT 'Enter Application Name: [Excel Gateway for Oracle APEX]'


@install_db_scratch.sql

PROMPT >> Application Installation
PROMPT >> ========================

PROMPT >> Set up environment
begin
  apex_application_install.set_workspace( p_workspace => '^ws_name.' );
  apex_application_install.generate_application_id;
  apex_application_install.generate_offset;
  apex_application_install.set_schema( p_schema => '^parsing_schema.' );
  apex_application_install.set_application_alias( p_application_alias => '^app_alias.' );
  apex_application_install.set_application_name( p_application_name => '^app_name.' );
end;
/

PROMPT >> Install Application
@apex/install.sql

PROMPT >> Finished Installation of Excel Gateway for Oracle APEX
PROMPT >> ====================================