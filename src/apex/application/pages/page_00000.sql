prompt --application/pages/page_00000
begin
--   Manifest
--     PAGE: 00000
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.10.15'
,p_release=>'21.2.1'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>364658460193179534
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>0
,p_user_interface_id=>wwv_flow_api.id(179050793507173566)
,p_name=>'Global Page - Desktop'
,p_step_title=>'Global Page - Desktop'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20211214125433'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179064087961176901)
,p_plug_name=>'Filter'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-Form--stretchInputs:t-Form--leftLabels:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(178939802895173451)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'CURRENT_PAGE_NOT_IN_CONDITION'
,p_plug_display_when_condition=>'20,21,22,23,24,25,27,28,31,32,41,42,80,81,82,83,84,85,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,9999,10000,10010,10011,10013,10014,10020'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(179064212982176902)
,p_name=>'P0_TEMPLATE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179064087961176901)
,p_prompt=>'Template'
,p_placeholder=>'- please select -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'R_TEMPLATES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(179027017662173513)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(179063840147176899)
,p_name=>'FadeOutSuccessMesage'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(179063954576176900)
,p_event_id=>wwv_flow_api.id(179063840147176899)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.jQuery(function() {',
'  apex.theme42.util.configAPEXMsgs({',
'    autoDismiss: true,',
'    duration: 3000',
'  });',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(179064303674176903)
,p_name=>'Change Filter'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P0_TEMPLATE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(179064419287176904)
,p_event_id=>wwv_flow_api.id(179064303674176903)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P0_TEMPLATE'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.component_end;
end;
/
