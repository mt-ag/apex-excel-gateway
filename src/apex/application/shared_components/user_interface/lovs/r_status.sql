prompt --application/shared_components/user_interface/lovs/r_status
begin
--   Manifest
--     R_STATUS
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
 p_id=>wwv_flow_api.id(169782518491157642)
,p_lov_name=>'R_STATUS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'R_STATUS'
,p_return_column_name=>'STS_ID'
,p_display_column_name=>'STS_NAME'
,p_default_sort_column_name=>'STS_NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/
