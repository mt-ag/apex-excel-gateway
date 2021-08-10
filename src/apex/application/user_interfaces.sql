prompt --application/user_interfaces
begin
--   Manifest
--     USER INTERFACES: 445
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>171169157754824360
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(84024473664228098)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN:&APP_SESSION.::&DEBUG.:::'
,p_theme_style_by_user_pref=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_api.id(83886311955227947)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(83991584789228038)
,p_nav_list_template_options=>'js-navCollapsed--default:t-TreeNav--styleB'
,p_css_file_urls=>'#APP_IMAGES#app-icon.css?version=#APP_VERSION#'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(84024129943228096)
,p_nav_bar_list_template_id=>wwv_flow_api.id(83991112618228037)
,p_nav_bar_template_options=>'js-menu-callout'
);
wwv_flow_api.component_end;
end;
/
