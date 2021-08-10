prompt --application/shared_components/user_interface/lovs/r_templates
begin
--   Manifest
--     R_TEMPLATES
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>171169157754824360
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(84045008609257929)
,p_lov_name=>'R_TEMPLATES'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'R_TEMPLATES'
,p_return_column_name=>'TPL_ID'
,p_display_column_name=>'TPL_NAME'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'TPL_NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/
