prompt --application/pages/page_groups
begin
--   Manifest
--     PAGE GROUPS: 111
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>0
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(15555130428972694)
,p_group_name=>'Administration'
);
wwv_flow_api.component_end;
end;
/
