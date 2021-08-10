prompt --application/shared_components/user_interface/lovs/r_validation
begin
--   Manifest
--     R_VALIDATION
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>68429026836522574
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(10451812895985921)
,p_lov_name=>'R_VALIDATION'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select val_id as r, val_text as d ',
'  from r_validation'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/
