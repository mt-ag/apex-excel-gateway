prompt --application/pages/page_00032
begin
--   Manifest
--     PAGE: 00032
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>0
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>32
,p_user_interface_id=>wwv_flow_api.id(15551973743972668)
,p_name=>'Automations'
,p_alias=>'AUTOMATIONS'
,p_page_mode=>'MODAL'
,p_step_title=>'Automations'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20210528104610'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(62532425056102786)
,p_plug_name=>'Settings'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(15440115460972553)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(31259849292892613)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(62532425056102786)
,p_button_name=>'Save'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(15529591007972618)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_button_position=>'BELOW_BOX'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(31259962274892614)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(62532425056102786)
,p_button_name=>'Cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(15529591007972618)
,p_button_image_alt=>'Cancel'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(31273459255210188)
,p_name=>'P32_ENABLED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(62532425056102786)
,p_prompt=>'Status'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC2:Enabled;1,Disabled;0'
,p_field_template=>wwv_flow_api.id(15528397114972615)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(31273838246210190)
,p_name=>'P32_DAYS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(62532425056102786)
,p_prompt=>'Days'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC2:Monday;2,Tuesday;3,Wednesday;4,Thursday;5,Friday;6,Saturday;7,Sunday;1'
,p_field_template=>wwv_flow_api.id(15528397114972615)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'7'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(31260036254892615)
,p_name=>'Close Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(31259962274892614)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31260163395892616)
,p_event_id=>wwv_flow_api.id(31260036254892615)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(31259494000892609)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Status'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tpa_enabled',
'  into :P32_ENABLED',
'  from template_automations',
' where tpa_tpl_id = :P0_TEMPLATE ;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(31259735266892612)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get DAYS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tpa_days',
'  into :P32_DAYS',
'  from template_automations',
' where tpa_tpl_id = :P0_TEMPLATE ;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(31260292789892617)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Automation'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'p00032_api.save_automation(',
'    pi_tpa_tpl_id  => :P0_TEMPLATE,',
'    pi_tpa_enabled => :P32_ENABLED,',
'    pi_tpa_days    => :P32_DAYS',
');'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(31260400973892619)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.component_end;
end;
/
