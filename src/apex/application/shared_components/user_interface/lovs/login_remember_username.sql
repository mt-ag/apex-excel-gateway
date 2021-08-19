prompt --application/shared_components/user_interface/lovs/login_remember_username
begin
--   Manifest
--     LOGIN_REMEMBER_USERNAME
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>205442218172938197
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(87139580352596219)
,p_lov_name=>'LOGIN_REMEMBER_USERNAME'
,p_lov_query=>'.'||wwv_flow_api.id(87139580352596219)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(87139201256596216)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Remember username'
,p_lov_return_value=>'Y'
);
wwv_flow_api.component_end;
end;
/
