prompt --application/deployment/install/install_demo_data
begin
--   Manifest
--     INSTALL: INSTALL-Demo Data
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>205442218172938197
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(131640739482181957)
,p_install_id=>wwv_flow_api.id(132587475904314597)
,p_name=>'Demo Data'
,p_sequence=>50
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete R_SHIPPINGSTATUS;',
'delete R_STATUS;',
'delete R_VALIDATION;',
'delete r_header;',
'',
'Insert into R_SHIPPINGSTATUS (SPS_NAME) values (''Template not sent'');',
'Insert into R_SHIPPINGSTATUS (SPS_NAME) values (''Template sent'');',
'Insert into R_SHIPPINGSTATUS (SPS_NAME) values (''Correction sent'');',
'Insert into R_SHIPPINGSTATUS (SPS_NAME) values (''Reminder sent'');',
'',
'Insert into R_STATUS (STS_NAME) values (''Not edited'');',
'Insert into R_STATUS (STS_NAME) values (''In processing'');',
'Insert into R_STATUS (STS_NAME) values (''Completed'');',
'',
'Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values (''email'',''Invalid email address'');',
'Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values (''number'',''Invalid number'');',
'Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values (''date'',''Invalid date'');',
'Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values (''formula'',''formula'');',
'',
'insert into r_header (hea_id, hea_text, hea_xlsx_width) values (9999, ''Faulty'',30);',
'insert into r_header (hea_id, hea_text, hea_xlsx_width) values (9998, ''Annotation'',30);',
'insert into r_header (hea_id, hea_text, hea_xlsx_width) values (9997, ''Feedback'',30);',
'insert into r_header (hea_id, hea_text, hea_xlsx_width) values (9996, ''Validation'',30);',
''))
);
wwv_flow_api.component_end;
end;
/
