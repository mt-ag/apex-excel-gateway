prompt --application/shared_components/user_interface/lovs/r_files
begin
--   Manifest
--     R_FILES
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>34214513418261287
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(23968339838824277)
,p_lov_name=>'R_FILES'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'FILES'
,p_return_column_name=>'FIL_ID'
,p_display_column_name=>'FIL_FILENAME'
,p_default_sort_column_name=>'FIL_FILENAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/
