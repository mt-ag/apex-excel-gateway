prompt --application/shared_components/navigation/lists/desktop_navigation_bar
begin
--   Manifest
--     LIST: Desktop Navigation Bar
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>205442218172938197
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(87145027811596264)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(78665292810251958)
,p_list_item_display_sequence=>0
,p_list_item_link_text=>'About this Application'
,p_list_item_link_target=>'f?p=&APP_ID.:10020:&SESSION.::&DEBUG.:10020:::'
,p_list_item_icon=>'fa-info-circle-o'
,p_list_text_02=>'icon-only'
,p_required_patch=>wwv_flow_api.id(78666468415251960)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(78683085311658642)
,p_list_item_display_sequence=>5
,p_list_item_link_text=>'Feedback'
,p_list_item_link_target=>'f?p=&APP_ID.:10010:&SESSION.::&DEBUG.:10010:P10010_PAGE_ID:&APP_PAGE_ID.:'
,p_list_item_icon=>'fa-comment-o'
,p_list_text_02=>'icon-only'
,p_required_patch=>wwv_flow_api.id(78713352113658713)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87133275969596188)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'&APP_USER.'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87132779200596187)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_api.id(87133275969596188)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87132422917596186)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Sign Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_parent_list_item_id=>wwv_flow_api.id(87133275969596188)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
