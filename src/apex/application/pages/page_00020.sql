prompt --application/pages/page_00020
begin
--   Manifest
--     PAGE: 00020
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>205442218172938197
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>20
,p_user_interface_id=>wwv_flow_api.id(87144684090596262)
,p_name=>'Create Template'
,p_alias=>'CREATE-TEMPLATE'
,p_step_title=>'Create Template'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>'only_numeric()'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20210819145905'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86063027937222029)
,p_plug_name=>'Create Template (Step 1 of 5)'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(87229303239596359)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(81901138348976804)
,p_plug_name=>'Create new Template'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayLabels'
,p_plug_template=>wwv_flow_api.id(87229303239596359)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(73040831806126015)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(87169966262596318)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(86062778449222027)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(86063027937222029)
,p_button_name=>'Save_Template'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(87167066826596312)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-step-forward'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(86020653477839029)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(86063027937222029)
,p_button_name=>'Reset'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(87167066826596312)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reset'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(81901016228976803)
,p_branch_name=>'GoTo Page 21'
,p_branch_action=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:21::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(86062778449222027)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(86062930125222028)
,p_name=>'P20_NAME'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86063027937222029)
,p_prompt=>'Template Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(87167961979596315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(73448515531513529)
,p_name=>'P20_DEADLINE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(86063027937222029)
,p_prompt=>'Deadline (number of days to edit)'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'only-numeric'
,p_field_template=>wwv_flow_api.id(87168260719596315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(73448418696513528)
,p_name=>'P20_NUMBER_OF_ROWS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(86063027937222029)
,p_prompt=>'Number of maximum rows'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'only-numeric'
,p_field_template=>wwv_flow_api.id(87168260719596315)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168112859337815886)
,p_validation_name=>'Check Template Name'
,p_validation_sequence=>10
,p_validation=>'P20_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please enter a template Name'
,p_when_button_pressed=>wwv_flow_api.id(86062778449222027)
,p_associated_item=>wwv_flow_api.id(86062930125222028)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(86020516211839028)
,p_name=>'Clear all items'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(86020653477839029)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(86020415401839027)
,p_event_id=>wwv_flow_api.id(86020516211839028)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20_NAME,P20_DEADLINE,P20_NUMBER_OF_ROWS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(86020316800839026)
,p_event_id=>wwv_flow_api.id(86020516211839028)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if APEX_COLLECTION.COLLECTION_EXISTS(p_collection_name => ''create_template'') then',
'    APEX_COLLECTION.TRUNCATE_COLLECTION(p_collection_name => ''create_template'');    ',
'end if;   '))
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(86018311981839006)
,p_event_id=>wwv_flow_api.id(86020516211839028)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(81901291440976806)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Collection'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if APEX_COLLECTION.COLLECTION_EXISTS(p_collection_name => ''create_template'') then',
'    APEX_COLLECTION.TRUNCATE_COLLECTION(p_collection_name => ''create_template'');    ',
'else    ',
'    apex_collection.create_collection(''create_template'');',
'end if;    '))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(86062778449222027)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(91782683898082114)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Session State'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.component_end;
end;
/
