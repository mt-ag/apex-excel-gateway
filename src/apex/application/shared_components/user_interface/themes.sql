prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 445
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>171169157754824360
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(84004744169228062)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(83903769989227975)
,p_default_dialog_template=>wwv_flow_api.id(83897982322227972)
,p_error_template=>wwv_flow_api.id(83892566405227966)
,p_printer_friendly_template=>wwv_flow_api.id(83903769989227975)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(83892566405227966)
,p_default_button_template=>wwv_flow_api.id(84001975448228048)
,p_default_region_template=>wwv_flow_api.id(83939854515228001)
,p_default_chart_template=>wwv_flow_api.id(83939854515228001)
,p_default_form_template=>wwv_flow_api.id(83939854515228001)
,p_default_reportr_template=>wwv_flow_api.id(83939854515228001)
,p_default_tabform_template=>wwv_flow_api.id(83939854515228001)
,p_default_wizard_template=>wwv_flow_api.id(83939854515228001)
,p_default_menur_template=>wwv_flow_api.id(83949261946228006)
,p_default_listr_template=>wwv_flow_api.id(83939854515228001)
,p_default_irr_template=>wwv_flow_api.id(83937933109228000)
,p_default_report_template=>wwv_flow_api.id(83968711506228020)
,p_default_label_template=>wwv_flow_api.id(84000897035228045)
,p_default_menu_template=>wwv_flow_api.id(84003308587228049)
,p_default_calendar_template=>wwv_flow_api.id(84003483614228051)
,p_default_list_template=>wwv_flow_api.id(83985110876228033)
,p_default_nav_list_template=>wwv_flow_api.id(83996589770228041)
,p_default_top_nav_list_temp=>wwv_flow_api.id(83996589770228041)
,p_default_side_nav_list_temp=>wwv_flow_api.id(83991584789228038)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(83913483052227983)
,p_default_dialogr_template=>wwv_flow_api.id(83912436510227983)
,p_default_option_label=>wwv_flow_api.id(84000897035228045)
,p_default_required_label=>wwv_flow_api.id(84001195775228045)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(83991112618228037)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.6/')
,p_files_version=>65
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_api.component_end;
end;
/
