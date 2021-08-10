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
,p_default_id_offset=>34214513418261287
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>20
,p_user_interface_id=>wwv_flow_api.id(15551973743972668)
,p_name=>'Create Template'
,p_alias=>'CREATE-TEMPLATE'
,p_step_title=>'Create Template'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function handleDrag(event) {',
'      var data = {hea_id: event.target.dataset.hea_id, hea_text: event.target.dataset.hea_text};',
'      var json_data = JSON.stringify(data);',
'      event.dataTransfer.setData(''data'', json_data);',
'}',
'',
'function handleDragover(event){',
'      event.preventDefault();',
'}',
'',
'',
'function handleDrop(event){',
'      var hea_id = JSON.parse(event.dataTransfer.getData(''data'')).hea_id;',
'      var hea_text = JSON.parse(event.dataTransfer.getData(''data'')).hea_text;',
'',
'      apex.server.process(',
'            ''Update Collection'',',
'            {',
'               x01: hea_id,',
'               x02: hea_text ',
'            },',
'            {',
'               success: function(){',
'                     apex.event.trigger(''#target'', ''apexrefresh'')',
'               },',
'               dataType: ''text''',
'            });',
'',
'}'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(".only-numeric").bind("keypress", function (e) {',
'    var keyCode = e.which ? e.which : e.keyCode               ',
'    if (!(keyCode >= 48 && keyCode <= 57)) {',
'      return false;',
'    }else{',
'      return true;',
'    }',
'});'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.draglist{',
'      list-style-type: none;',
'}',
'',
'.droplist{',
'      list-style-type: decimal-leading-zero;',
'}',
'',
'.draglist-el {',
'      padding-top: 5px;',
'      	padding-bottom: 5px;',
'}',
'',
'.droplist-el {',
'      padding-top: 5px;',
'      	padding-bottom: 5px;',
'}',
'',
'hr {  ',
'  margin-top: 5px; ',
'  margin-bottom: 0px; ',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20210523144249'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16633629897346901)
,p_plug_name=>'Create Template (Step 1 of 5)'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(15467354594972571)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20795519485592126)
,p_plug_name=>'Create new Template'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayLabels'
,p_plug_template=>wwv_flow_api.id(15467354594972571)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(29655826028442915)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(15526691571972612)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16633879385346903)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(16633629897346901)
,p_button_name=>'Save_Template'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(15529591007972618)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_icon_css_classes=>'fa-step-forward'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16676004356729901)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16633629897346901)
,p_button_name=>'Reset'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(15529591007972618)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reset'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(20795641605592127)
,p_branch_name=>'GoTo Page 21'
,p_branch_action=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:21::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(16633879385346903)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16633727709346902)
,p_name=>'P20_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(16633629897346901)
,p_prompt=>'Template Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(15528695854972615)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(29248142303055401)
,p_name=>'P20_DEADLINE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(16633629897346901)
,p_prompt=>'Deadline (number of days to edit)'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'only-numeric'
,p_field_template=>wwv_flow_api.id(15528397114972615)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(29248239138055402)
,p_name=>'P20_NUMBER_OF_ROWS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(16633629897346901)
,p_prompt=>'Number of maximum rows'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'only-numeric'
,p_field_template=>wwv_flow_api.id(15528397114972615)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20795727751592128)
,p_validation_name=>'Check Template Name'
,p_validation_sequence=>10
,p_validation=>'P20_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please enter a template Name'
,p_when_button_pressed=>wwv_flow_api.id(16633879385346903)
,p_associated_item=>wwv_flow_api.id(16633727709346902)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16676141622729902)
,p_name=>'Clear all items'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(16676004356729901)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16676242432729903)
,p_event_id=>wwv_flow_api.id(16676141622729902)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20_NAME,P20_DEADLINE,P20_NUMBER_OF_ROWS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16676341033729904)
,p_event_id=>wwv_flow_api.id(16676141622729902)
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
 p_id=>wwv_flow_api.id(16678345852729924)
,p_event_id=>wwv_flow_api.id(16676141622729902)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(20795366393592124)
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
,p_process_when_button_id=>wwv_flow_api.id(16633879385346903)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(10913973936486816)
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
