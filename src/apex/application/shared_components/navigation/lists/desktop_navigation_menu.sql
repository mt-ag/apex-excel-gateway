prompt --application/shared_components/navigation/lists/desktop_navigation_menu
begin
--   Manifest
--     LIST: Desktop Navigation Menu
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
 p_id=>wwv_flow_api.id(87282845799596413)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87134819638596201)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(86994517635069648)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Create Template'
,p_list_item_link_target=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-o'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(86994183699066939)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Send Template'
,p_list_item_link_target=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-send-o'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(86993865040064203)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Upload Template'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-upload'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(86993616666062163)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Check Data'
,p_list_item_link_target=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-clipboard-check'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(92405505796893274)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Export Data'
,p_list_item_link_target=>'f?p=&APP_ID.:60:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-download'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'60'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87037691710472932)
,p_list_item_display_sequence=>1000
,p_list_item_link_text=>'Administration'
,p_list_item_icon=>'fa-database-edit'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(78682481475658635)
,p_list_item_display_sequence=>1010
,p_list_item_link_text=>'Feedback'
,p_list_item_link_target=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-user-wrench'
,p_parent_list_item_id=>wwv_flow_api.id(87037691710472932)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'10000'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_display_sequence=>1020
,p_list_item_link_text=>'Manage Data'
,p_list_item_icon=>'fa-database-edit'
,p_parent_list_item_id=>wwv_flow_api.id(87037691710472932)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(78713546129680533)
,p_list_item_display_sequence=>1030
,p_list_item_link_text=>'Dropdown'
,p_list_item_link_target=>'f?p=&APP_ID.:1011:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87036744506468362)
,p_list_item_display_sequence=>1040
,p_list_item_link_text=>'File'
,p_list_item_link_target=>'f?p=&APP_ID.:1002:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87036378241466964)
,p_list_item_display_sequence=>1050
,p_list_item_link_text=>'Header'
,p_list_item_link_target=>'f?p=&APP_ID.:1003:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87036146821464733)
,p_list_item_display_sequence=>1060
,p_list_item_link_text=>'Person'
,p_list_item_link_target=>'f?p=&APP_ID.:1005:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87034982696458875)
,p_list_item_display_sequence=>1070
,p_list_item_link_text=>'Status'
,p_list_item_link_target=>'f?p=&APP_ID.:1007:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87035320553460080)
,p_list_item_display_sequence=>1080
,p_list_item_link_text=>'Shippingstatus'
,p_list_item_link_target=>'f?p=&APP_ID.:1006:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87034717126457710)
,p_list_item_display_sequence=>1090
,p_list_item_link_text=>'Templates'
,p_list_item_link_target=>'f?p=&APP_ID.:1008:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(125079202717758347)
,p_list_item_display_sequence=>1095
,p_list_item_link_text=>'Template-Automations'
,p_list_item_link_target=>'f?p=&APP_ID.:1014:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1014'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87033533742451140)
,p_list_item_display_sequence=>1100
,p_list_item_link_text=>'Template-Header'
,p_list_item_link_target=>'f?p=&APP_ID.:1010:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(73369603279102433)
,p_list_item_display_sequence=>1110
,p_list_item_link_text=>'Template-Header-Group'
,p_list_item_link_target=>'f?p=&APP_ID.:1012:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(72236394767918032)
,p_list_item_display_sequence=>1115
,p_list_item_link_text=>'Template-Header-Validations'
,p_list_item_link_target=>'f?p=&APP_ID.:1013:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87034364657456625)
,p_list_item_display_sequence=>1120
,p_list_item_link_text=>'Template-Import-Data'
,p_list_item_link_target=>'f?p=&APP_ID.:1009:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(87035816358462403)
,p_list_item_display_sequence=>1130
,p_list_item_link_text=>'Template-Import-Status'
,p_list_item_link_target=>'f?p=&APP_ID.:1004:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(78676098562646618)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
