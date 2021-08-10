prompt --application/pages/page_00041
begin
--   Manifest
--     PAGE: 00041
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
 p_id=>41
,p_user_interface_id=>wwv_flow_api.id(15551973743972668)
,p_name=>'Upload File'
,p_alias=>'UPLOAD-FILE'
,p_page_mode=>'MODAL'
,p_step_title=>'Upload File'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var spinner;'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'900px'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20210511143744'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16114384538156512)
,p_plug_name=>'Dialog Body'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(15439936589972553)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16114695493156515)
,p_plug_name=>'DropZone'
,p_region_name=>'dropzone'
,p_parent_plug_id=>wwv_flow_api.id(16114384538156512)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(15439936589972553)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'PLUGIN_DE.DANIELH.DROPZONE2'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'COLLECTION'
,p_attribute_02=>'DROPZONE_UPLOAD'
,p_attribute_07=>'STYLE2'
,p_attribute_08=>'100%'
,p_attribute_09=>'400px'
,p_attribute_10=>'50'
,p_attribute_15=>'NORMAL'
,p_attribute_16=>'true'
,p_attribute_17=>'true'
,p_attribute_18=>'false'
,p_attribute_19=>'false'
,p_attribute_20=>'false'
,p_attribute_22=>'false'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16114935800156518)
,p_plug_name=>'Dialog Footer'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(15440983131972553)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16115002697156519)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(16114935800156518)
,p_button_name=>'UPLOAD'
,p_button_static_id=>'upload'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(15529591007972618)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Upload'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-upload'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(16115724538156526)
,p_branch_name=>'TO_40'
,p_branch_action=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.::P50_UPLOAD:1&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_branch_condition=>'P41_ERROR'
,p_branch_condition_text=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16114450308156513)
,p_name=>'P41_ERROR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(16114384538156512)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16114579378156514)
,p_name=>'P41_COLLECTION_EXISTS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(16114384538156512)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16114735195156516)
,p_name=>'Upload error'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(16114695493156515)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_DE.DANIELH.DROPZONE2|REGION TYPE|dropzone-upload-error'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16114861234156517)
,p_event_id=>wwv_flow_api.id(16114735195156516)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    apex_collection.truncate_collection (',
'      p_collection_name => ''DROPZONE_UPLOAD''',
'    );'))
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16115106374156520)
,p_name=>'Upload'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(16115002697156519)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16115274688156521)
,p_event_id=>wwv_flow_api.id(16115106374156520)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'spinner = apex.util.showSpinner();',
'$("#upload").attr("disabled", true);'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16115536706156524)
,p_event_id=>wwv_flow_api.id(16115106374156520)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'p00041_api.upload_file (',
'  pi_tpl_id         => :P0_TEMPLATE  ',
' ,po_error_occurred => :P41_error',
');'))
,p_attribute_03=>'P41_ERROR'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16115673055156525)
,p_event_id=>wwv_flow_api.id(16115106374156520)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_collection.truncate_collection (',
'      p_collection_name => ''DROPZONE_UPLOAD''',
'    );'))
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16115396153156522)
,p_event_id=>wwv_flow_api.id(16115106374156520)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const error = $v(''P41_ERROR'');',
'',
'if (error == 1) {',
'  apex.message.showErrors([',
'    {',
'        type:       "error",',
'        location:   "page",',
'        message:    "One or more files contain errors. Please have a look at the error log",',
'        unsafe:     false',
'    }',
'  ]);',
'} else {',
'  apex.page.submit();',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16115406785156523)
,p_event_id=>wwv_flow_api.id(16115106374156520)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'spinner.remove();',
'$("#upload").attr("disabled", false);'))
);
wwv_flow_api.component_end;
end;
/
