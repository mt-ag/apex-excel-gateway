prompt --application/shared_components/navigation/lists/desktop_navigation_menu
begin
--   Manifest
--     LIST: Desktop Navigation Menu
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
 p_id=>wwv_flow_api.id(178912631798173415)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179060657959173627)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254135838255508247)
,p_list_item_display_sequence=>15
,p_list_item_link_text=>'Prepare Template'
,p_list_item_icon=>'fa-file-o'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179200959962700180)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Create Template'
,p_list_item_link_target=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-plus'
,p_parent_list_item_id=>wwv_flow_api.id(254135838255508247)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254134921456494194)
,p_list_item_display_sequence=>21
,p_list_item_link_text=>'Edit Template'
,p_list_item_link_target=>'f?p=&APP_ID.:80:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-edit'
,p_parent_list_item_id=>wwv_flow_api.id(254135838255508247)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254134584857492014)
,p_list_item_display_sequence=>22
,p_list_item_link_text=>'Delete Template'
,p_list_item_link_target=>'f?p=&APP_ID.:90:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-file-x'
,p_parent_list_item_id=>wwv_flow_api.id(254135838255508247)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179201293898702889)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Send Template'
,p_list_item_link_target=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-send-o'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179201612557705625)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Upload Template'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-upload'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179201860931707665)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Check Data'
,p_list_item_link_target=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-clipboard-check'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(173789971800876554)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Export Data'
,p_list_item_link_target=>'f?p=&APP_ID.:60:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-download'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'60'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179157785887296896)
,p_list_item_display_sequence=>1000
,p_list_item_link_text=>'Administration'
,p_list_item_icon=>'fa-database-edit'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(187512996122111193)
,p_list_item_display_sequence=>1010
,p_list_item_link_text=>'Feedback'
,p_list_item_link_target=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-user-wrench'
,p_parent_list_item_id=>wwv_flow_api.id(179157785887296896)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'10000'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_display_sequence=>1020
,p_list_item_link_text=>'Manage Data'
,p_list_item_icon=>'fa-database-edit'
,p_parent_list_item_id=>wwv_flow_api.id(179157785887296896)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(187481931468089295)
,p_list_item_display_sequence=>1030
,p_list_item_link_text=>'Dropdown'
,p_list_item_link_target=>'f?p=&APP_ID.:1011:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179158733091301466)
,p_list_item_display_sequence=>1040
,p_list_item_link_text=>'File'
,p_list_item_link_target=>'f?p=&APP_ID.:1002:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179159099356302864)
,p_list_item_display_sequence=>1050
,p_list_item_link_text=>'Header'
,p_list_item_link_target=>'f?p=&APP_ID.:1003:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179159330776305095)
,p_list_item_display_sequence=>1060
,p_list_item_link_text=>'Person'
,p_list_item_link_target=>'f?p=&APP_ID.:1005:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179160494901310953)
,p_list_item_display_sequence=>1070
,p_list_item_link_text=>'Status'
,p_list_item_link_target=>'f?p=&APP_ID.:1007:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179160157044309748)
,p_list_item_display_sequence=>1080
,p_list_item_link_text=>'Shippingstatus'
,p_list_item_link_target=>'f?p=&APP_ID.:1006:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(254492832595740817)
,p_list_item_display_sequence=>1085
,p_list_item_link_text=>'Spreadsheet Protection'
,p_list_item_link_target=>'f?p=&APP_ID.:1015:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179160760471312118)
,p_list_item_display_sequence=>1090
,p_list_item_link_text=>'Templates'
,p_list_item_link_target=>'f?p=&APP_ID.:1008:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(141116274880011481)
,p_list_item_display_sequence=>1095
,p_list_item_link_text=>'Template-Automations'
,p_list_item_link_target=>'f?p=&APP_ID.:1014:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1014'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179161943855318688)
,p_list_item_display_sequence=>1100
,p_list_item_link_text=>'Template-Header'
,p_list_item_link_target=>'f?p=&APP_ID.:1010:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(192825874318667395)
,p_list_item_display_sequence=>1110
,p_list_item_link_text=>'Template-Header-Group'
,p_list_item_link_target=>'f?p=&APP_ID.:1012:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(193959082829851796)
,p_list_item_display_sequence=>1115
,p_list_item_link_text=>'Template-Header-Validations'
,p_list_item_link_target=>'f?p=&APP_ID.:1013:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179161112940313203)
,p_list_item_display_sequence=>1120
,p_list_item_link_text=>'Template-Import-Data'
,p_list_item_link_target=>'f?p=&APP_ID.:1009:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(179159661239307425)
,p_list_item_display_sequence=>1130
,p_list_item_link_text=>'Template-Import-Status'
,p_list_item_link_target=>'f?p=&APP_ID.:1004:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(187519379035123210)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
