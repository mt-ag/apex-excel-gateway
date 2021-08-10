prompt --application/shared_components/security/app_access_control/administrator
begin
--   Manifest
--     ACL ROLE: ADMINISTRATOR
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>171169157754824360
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_acl_role(
 p_id=>wwv_flow_api.id(102653686704974584)
,p_static_id=>'ADMINISTRATOR'
,p_name=>'ADMINISTRATOR'
);
wwv_flow_api.component_end;
end;
/
