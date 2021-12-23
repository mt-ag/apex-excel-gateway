prompt --application/shared_components/user_interface/lovs/mailtype
begin
--   Manifest
--     MAILTYPE
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.6'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>349023258543091759
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(169815045309327965)
,p_lov_name=>'MAILTYPE'
,p_lov_query=>'.'||wwv_flow_api.id(169815045309327965)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(169814810804327962)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Initial Mail'
,p_lov_return_value=>'1'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(169814413643327961)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Correction Mail'
,p_lov_return_value=>'2'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(169813955183327961)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Reminder Mail'
,p_lov_return_value=>'3'
);
wwv_flow_api.component_end;
end;
/
