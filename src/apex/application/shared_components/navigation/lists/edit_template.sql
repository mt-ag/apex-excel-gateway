prompt --application/shared_components/navigation/lists/edit_template
begin
--   Manifest
--     LIST: Edit Template
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.10.15'
,p_release=>'21.2.1'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>364658460193179534
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(254121019194287436)
,p_name=>'Edit Template'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254120812961287433)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Edit Template'
,p_list_item_link_target=>'f?p=&APP_ID.:80:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254120434862287431)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Edit Header'
,p_list_item_link_target=>'f?p=&APP_ID.:81:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254120021458287431)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Edit Header-Groups'
,p_list_item_link_target=>'f?p=&APP_ID.:82:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254119655552287431)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Edit Colors'
,p_list_item_link_target=>'f?p=&APP_ID.:83:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254119232654287431)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Edit Validations/Formulas'
,p_list_item_link_target=>'f?p=&APP_ID.:84:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254118814451287425)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Save Template'
,p_list_item_link_target=>'f?p=&APP_ID.:85:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
