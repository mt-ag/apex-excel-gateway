prompt --application/shared_components/user_interface/lovs/r_shippingstatus
begin
--   Manifest
--     R_SHIPPINGSTATUS
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
 p_id=>wwv_flow_api.id(15741765668731666)
,p_lov_name=>'R_SHIPPINGSTATUS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'R_SHIPPINGSTATUS'
,p_return_column_name=>'SPS_ID'
,p_display_column_name=>'SPS_NAME'
,p_default_sort_column_name=>'SPS_NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/
