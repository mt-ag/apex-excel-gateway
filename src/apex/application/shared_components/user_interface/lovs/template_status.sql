prompt --application/shared_components/user_interface/lovs/template_status
begin
--   Manifest
--     TEMPLATE_STATUS
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
 p_id=>wwv_flow_api.id(28034739356066767)
,p_lov_name=>'TEMPLATE_STATUS'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tpl_name as display,',
'       tis_id as return',
'  from r_templates tpl',
'  join template_import_status tis on tpl_id = tis_tpl_id     ',
''))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_return_column_name=>'RETURN'
,p_display_column_name=>'DISPLAY'
,p_default_sort_column_name=>'DISPLAY'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.component_end;
end;
/
