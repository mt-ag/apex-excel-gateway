prompt --application/shared_components/security/authorizations/administration_rights
begin
--   Manifest
--     SECURITY SCHEME: Administration Rights
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>171169157754824360
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(84027075057228121)
,p_name=>'Administration Rights'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_is_admin boolean := false;',
'begin',
'    l_is_admin := APEX_ACL.HAS_USER_ROLE (',
'                    p_application_id  => :APP_ID,',
'                    p_user_name       => :APP_USER,',
'                    p_role_static_id  => ''ADMINISTRATOR'' );',
'',
'    return l_is_admin;',
'end;',
''))
,p_error_message=>'Insufficient privileges, user is not an Administrator'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_api.component_end;
end;
/
