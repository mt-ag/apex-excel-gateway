prompt --application/shared_components/user_interface/lovs/r_person
begin
--   Manifest
--     R_PERSON
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
 p_id=>wwv_flow_api.id(16628908332035084)
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
 p_id=>wwv_flow_api.id(16629419744046090)
,p_query_column_name=>'PER_ID'
,p_display_sequence=>10
,p_data_type=>'NUMBER'
,p_is_visible=>'N'
,p_is_searchable=>'N'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(16629840952046090)
,p_query_column_name=>'PER_NAME'
,p_heading=>'Per Name'
,p_display_sequence=>20
,p_data_type=>'VARCHAR2'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(16630202679046091)
,p_query_column_name=>'PER_EMAIL'
,p_heading=>'Per Email'
,p_display_sequence=>30
,p_data_type=>'VARCHAR2'
);
wwv_flow_api.component_end;
end;
/
