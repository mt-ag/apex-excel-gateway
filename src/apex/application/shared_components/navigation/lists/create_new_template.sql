prompt --application/shared_components/navigation/lists/create_new_template
begin
--   Manifest
--     LIST: Create new template
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
 p_id=>wwv_flow_api.id(193154645791643813)
,p_name=>'Create new template'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(193154858685643815)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'New Template'
,p_list_item_link_target=>'f?p=&APP_ID.:20:&APP_SESSION.::&DEBUG.:::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(193155284605643819)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Add Header'
,p_list_item_link_target=>'f?p=&APP_ID.:21:&APP_SESSION.::&DEBUG.:::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(193155695908643820)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Add Header-Groups'
,p_list_item_link_target=>'f?p=&APP_ID.:22:&APP_SESSION.::&DEBUG.:::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(193155924347643820)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Add Colors'
,p_list_item_link_target=>'f?p=&APP_ID.:23:&APP_SESSION.::&DEBUG.:::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(193965219485938977)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Add Validations/Formulas'
,p_list_item_link_target=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(193156342142643820)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Save Template'
,p_list_item_link_target=>'f?p=&APP_ID.:25:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.component_end;
end;
/
