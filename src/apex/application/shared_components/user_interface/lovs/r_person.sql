prompt --application/shared_components/user_interface/lovs/r_person
begin
--   Manifest
--     R_PERSON
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
 p_id=>wwv_flow_api.id(86067749502533846)
,p_lov_name=>'R_PERSON'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  per_id,',
'        per_firstname || '' '' || per_lastname as per_name,',
'        per_email',
'  from  r_person'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_query_table=>'R_PERSON'
,p_return_column_name=>'PER_ID'
,p_display_column_name=>'PER_NAME'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'PER_NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(86067238090522840)
,p_query_column_name=>'PER_ID'
,p_display_sequence=>10
,p_data_type=>'NUMBER'
,p_is_visible=>'N'
,p_is_searchable=>'N'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(86066816882522840)
,p_query_column_name=>'PER_NAME'
,p_heading=>'Per Name'
,p_display_sequence=>20
,p_data_type=>'VARCHAR2'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(86066455155522839)
,p_query_column_name=>'PER_EMAIL'
,p_heading=>'Per Email'
,p_display_sequence=>30
,p_data_type=>'VARCHAR2'
);
wwv_flow_api.component_end;
end;
/
