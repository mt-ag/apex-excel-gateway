prompt --application/shared_components/navigation/lists/edit_template
begin
--   Manifest
--     LIST: Edit Template
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.6'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>349023258543091759
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(94902239348804323)
,p_name=>'Edit Template'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(94902445581804326)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Edit Template'
,p_list_item_link_target=>'f?p=&APP_ID.:80:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(94902823680804328)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Edit Header'
,p_list_item_link_target=>'f?p=&APP_ID.:81:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(94903237084804328)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Edit Header-Groups'
,p_list_item_link_target=>'f?p=&APP_ID.:82:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(94903602990804328)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Edit Colors'
,p_list_item_link_target=>'f?p=&APP_ID.:83:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(94904025888804328)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Edit Validations/Formulas'
,p_list_item_link_target=>'f?p=&APP_ID.:84:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(94904444091804334)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Save Template'
,p_list_item_link_target=>'f?p=&APP_ID.:85:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
