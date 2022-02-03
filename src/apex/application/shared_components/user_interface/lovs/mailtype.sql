prompt --application/shared_components/user_interface/lovs/mailtype
begin
--   Manifest
--     MAILTYPE
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.10.15'
,p_release=>'21.2.1'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>364658460193179534
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(179208213233763794)
,p_lov_name=>'MAILTYPE'
,p_lov_query=>'.'||wwv_flow_api.id(179208213233763794)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(179208447738763797)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Initial Mail'
,p_lov_return_value=>'1'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(179208844899763798)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Correction Mail'
,p_lov_return_value=>'2'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(179209303359763798)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Reminder Mail'
,p_lov_return_value=>'3'
);
wwv_flow_api.component_end;
end;
/
