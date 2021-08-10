prompt --application/pages/page_00027
begin
--   Manifest
--     PAGE: 00027
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>171169157754824360
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>27
,p_user_interface_id=>wwv_flow_api.id(84024473664228098)
,p_name=>'Add Header'
,p_alias=>'ADD-HEADER1'
,p_page_mode=>'MODAL'
,p_step_title=>'Add Header'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20210520115735'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(96419548094904939)
,p_plug_name=>'Add Header'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(83912436510227983)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'R_HEADER'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(96416774463903586)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(83913483052227983)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(98039726408610143)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(96416774463903586)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(84001975448228048)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(98040114517610143)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(96416774463903586)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(84001975448228048)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(98037862189610141)
,p_name=>'P27_DROPDOWN_VALUES'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(96419548094904939)
,p_prompt=>'Add Dropdown Values (Optioal)'
,p_display_as=>'PLUGIN_MESQUITAROD.MULTIROW.ITEM'
,p_cSize=>97
,p_field_template=>wwv_flow_api.id(84000702923228045)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'25'
,p_attribute_02=>'Limit of items reached'
,p_attribute_03=>'fa-plus-square-o'
,p_attribute_04=>'fa-minus-square-o'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(98037426621610140)
,p_name=>'P27_HEA_VAL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(96419548094904939)
,p_item_source_plug_id=>wwv_flow_api.id(96419548094904939)
,p_prompt=>'Validation'
,p_source=>'HEA_VAL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'R_VALIDATION'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select val_id as r, val_text as d ',
'  from r_validation'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(84000897035228045)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(98037064204610139)
,p_name=>'P27_HEA_XLSX_WIDTH'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(96419548094904939)
,p_item_source_plug_id=>wwv_flow_api.id(96419548094904939)
,p_prompt=>'Xlsx Width'
,p_source=>'HEA_XLSX_WIDTH'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(84001195775228045)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(98036679260610139)
,p_name=>'P27_HEA_TEXT'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(96419548094904939)
,p_item_source_plug_id=>wwv_flow_api.id(96419548094904939)
,p_prompt=>'Header'
,p_source=>'HEA_TEXT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>2000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(84001195775228045)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(98036208433610139)
,p_name=>'P27_HEA_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(96419548094904939)
,p_item_source_plug_id=>wwv_flow_api.id(96419548094904939)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hea Id'
,p_source=>'HEA_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(84000897035228045)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(98041355454610145)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(98039726408610143)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(98041851063610146)
,p_event_id=>wwv_flow_api.id(98041355454610145)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(98042224134610146)
,p_name=>'Hide Add_Dropdown Region'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(98040525869610145)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Header'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'p00027_api.save_header(',
'    pi_hea_text         => :P27_HEA_TEXT',
'  , pi_hea_xlsx_width   => :P27_HEA_XLSX_WIDTH',
'  , pi_hea_val_id       => :P27_HEA_VAL_ID',
'  , pi_dropdown_values  => :P27_DROPDOWN_VALUES',
');'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(98040927448610145)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.component_end;
end;
/
