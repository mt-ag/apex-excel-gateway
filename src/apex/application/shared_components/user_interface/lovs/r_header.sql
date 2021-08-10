prompt --application/shared_components/user_interface/lovs/r_header
begin
--   Manifest
--     R_HEADER
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>0
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(23970661859843266)
,p_lov_name=>'R_HEADER'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'R_HEADER'
,p_return_column_name=>'HEA_ID'
,p_display_column_name=>'HEA_TEXT'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'HEA_TEXT'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/