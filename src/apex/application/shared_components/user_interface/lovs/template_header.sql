prompt --application/shared_components/user_interface/lovs/template_header
begin
--   Manifest
--     TEMPLATE_HEADER
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
 p_id=>wwv_flow_api.id(191532428383244666)
,p_lov_name=>'TEMPLATE_HEADER'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tpl_name || '' - '' || hea_text as display,',
'       tph_id as return',
'  from r_header hea',
'  join template_header tph on hea_id = tph_hea_id  ',
'  join r_templates on tph_tpl_id = tpl_id'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'RETURN'
,p_display_column_name=>'DISPLAY'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'DISPLAY'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/
