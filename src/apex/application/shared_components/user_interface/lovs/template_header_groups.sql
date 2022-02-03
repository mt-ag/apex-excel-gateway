prompt --application/shared_components/user_interface/lovs/template_header_groups
begin
--   Manifest
--     TEMPLATE_HEADER_GROUPS
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
 p_id=>wwv_flow_api.id(192975374221499456)
,p_lov_name=>'TEMPLATE_HEADER_GROUPS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'TEMPLATE_HEADER_GROUP'
,p_return_column_name=>'THG_ID'
,p_display_column_name=>'THG_TEXT'
,p_default_sort_column_name=>'THG_TEXT'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/
