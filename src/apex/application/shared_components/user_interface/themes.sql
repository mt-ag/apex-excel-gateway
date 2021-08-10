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
,p_default_id_offset=>34214513418261287
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(15532244248972632)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(15431270068972545)
,p_default_dialog_template=>wwv_flow_api.id(15425482401972542)
,p_error_template=>wwv_flow_api.id(15420066484972536)
,p_printer_friendly_template=>wwv_flow_api.id(15431270068972545)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(15420066484972536)
,p_default_button_template=>wwv_flow_api.id(15529475527972618)
,p_default_region_template=>wwv_flow_api.id(15467354594972571)
,p_default_chart_template=>wwv_flow_api.id(15467354594972571)
,p_default_form_template=>wwv_flow_api.id(15467354594972571)
,p_default_reportr_template=>wwv_flow_api.id(15467354594972571)
,p_default_tabform_template=>wwv_flow_api.id(15467354594972571)
,p_default_wizard_template=>wwv_flow_api.id(15467354594972571)
,p_default_menur_template=>wwv_flow_api.id(15476762025972576)
,p_default_listr_template=>wwv_flow_api.id(15467354594972571)
,p_default_irr_template=>wwv_flow_api.id(15465433188972570)
,p_default_report_template=>wwv_flow_api.id(15496211585972590)
,p_default_label_template=>wwv_flow_api.id(15528397114972615)
,p_default_menu_template=>wwv_flow_api.id(15530808666972619)
,p_default_calendar_template=>wwv_flow_api.id(15530983693972621)
,p_default_list_template=>wwv_flow_api.id(15512610955972603)
,p_default_nav_list_template=>wwv_flow_api.id(15524089849972611)
,p_default_top_nav_list_temp=>wwv_flow_api.id(15524089849972611)
,p_default_side_nav_list_temp=>wwv_flow_api.id(15519084868972608)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(15440983131972553)
,p_default_dialogr_template=>wwv_flow_api.id(15439936589972553)
,p_default_option_label=>wwv_flow_api.id(15528397114972615)
,p_default_required_label=>wwv_flow_api.id(15528695854972615)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(15518612697972607)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.6/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_api.component_end;
end;
/
