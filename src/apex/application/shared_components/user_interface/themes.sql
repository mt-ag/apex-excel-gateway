prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 445
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.10.15'
,p_release=>'21.2.1'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>364658460193179534
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(179031064012173530)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(178930089832173443)
,p_default_dialog_template=>wwv_flow_api.id(178924302165173440)
,p_error_template=>wwv_flow_api.id(178918886248173434)
,p_printer_friendly_template=>wwv_flow_api.id(178930089832173443)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(178918886248173434)
,p_default_button_template=>wwv_flow_api.id(179028295291173516)
,p_default_region_template=>wwv_flow_api.id(178966174358173469)
,p_default_chart_template=>wwv_flow_api.id(178966174358173469)
,p_default_form_template=>wwv_flow_api.id(178966174358173469)
,p_default_reportr_template=>wwv_flow_api.id(178966174358173469)
,p_default_tabform_template=>wwv_flow_api.id(178966174358173469)
,p_default_wizard_template=>wwv_flow_api.id(178966174358173469)
,p_default_menur_template=>wwv_flow_api.id(178975581789173474)
,p_default_listr_template=>wwv_flow_api.id(178966174358173469)
,p_default_irr_template=>wwv_flow_api.id(178964252952173468)
,p_default_report_template=>wwv_flow_api.id(178995031349173488)
,p_default_label_template=>wwv_flow_api.id(179027216878173513)
,p_default_menu_template=>wwv_flow_api.id(179029628430173517)
,p_default_calendar_template=>wwv_flow_api.id(179029803457173519)
,p_default_list_template=>wwv_flow_api.id(179011430719173501)
,p_default_nav_list_template=>wwv_flow_api.id(179022909613173509)
,p_default_top_nav_list_temp=>wwv_flow_api.id(179022909613173509)
,p_default_side_nav_list_temp=>wwv_flow_api.id(179017904632173506)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(178939802895173451)
,p_default_dialogr_template=>wwv_flow_api.id(178938756353173451)
,p_default_option_label=>wwv_flow_api.id(179027216878173513)
,p_default_required_label=>wwv_flow_api.id(179027515618173513)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(179017432461173505)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/21.1/')
,p_files_version=>72
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_api.component_end;
end;
/
