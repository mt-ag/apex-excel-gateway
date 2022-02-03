prompt --application/shared_components/logic/application_items/fil_id
begin
--   Manifest
--     APPLICATION ITEM: FIL_ID
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.10.15'
,p_release=>'21.2.1'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>364658460193179534
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(179256160471024982)
,p_name=>'FIL_ID'
,p_protection_level=>'N'
,p_escape_on_http_output=>'N'
);
wwv_flow_api.component_end;
end;
/
