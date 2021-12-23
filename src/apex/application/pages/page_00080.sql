prompt --application/pages/page_00080
begin
--   Manifest
--     PAGE: 00080
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.6'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>349023258543091759
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>80
,p_user_interface_id=>wwv_flow_api.id(169972465035918193)
,p_name=>'Edit Template'
,p_alias=>'EDIT-TEMPLATE'
,p_step_title=>'Edit Template'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>'only_numeric()'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20211214143430'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(263797421711371527)
,p_plug_name=>'Edit Template (Step 1 of 5)'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(170057084184918290)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(259635532123126302)
,p_plug_name=>'Edit Template'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayLabels'
,p_plug_template=>wwv_flow_api.id(170057084184918290)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(94902239348804323)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(169997747207918249)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(94907209859827670)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(263797421711371527)
,p_button_name=>'Save_Template'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(169994847771918243)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-step-forward'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(94912916422827854)
,p_branch_name=>'GoTo Page 81'
,p_branch_action=>'f?p=&APP_ID.:81:&SESSION.::&DEBUG.:81::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(94907209859827670)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(94909175080827717)
,p_name=>'P80_PROTECTION'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(263797421711371527)
,p_prompt=>'Sheet Protection'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'R_SPREADSHEET_PROTECTION'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- No protection -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(169996041664918246)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(94908707912827715)
,p_name=>'P80_NUMBER_OF_ROWS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(263797421711371527)
,p_prompt=>'Number of maximum rows'
,p_placeholder=>'e.g. 100'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'only-numeric'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(169996041664918246)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(94908328035827715)
,p_name=>'P80_DEADLINE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(263797421711371527)
,p_prompt=>'Deadline (number of days to edit)'
,p_placeholder=>'e.g. 14'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'only-numeric'
,p_field_template=>wwv_flow_api.id(169996041664918246)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(94907939453827706)
,p_name=>'P80_NAME'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(263797421711371527)
,p_prompt=>'Template Name'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'R_TEMPLATES'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- please select -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(169995742924918246)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(94877346995238610)
,p_name=>'Change'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P80_NAME'
,p_condition_element=>'P80_NAME'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(94877795295238614)
,p_event_id=>wwv_flow_api.id(94877346995238610)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P80_DEADLINE,P80_NUMBER_OF_ROWS,P80_PROTECTION'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(94877646835238613)
,p_event_id=>wwv_flow_api.id(94877346995238610)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P80_DEADLINE,P80_NUMBER_OF_ROWS,P80_PROTECTION'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(94877504411238612)
,p_event_id=>wwv_flow_api.id(94877346995238610)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P80_DEADLINE,P80_NUMBER_OF_ROWS,P80_PROTECTION'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(94877460109238611)
,p_event_id=>wwv_flow_api.id(94877346995238610)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tpl_deadline, tpl_number_of_rows, tpl_ssp_id',
'  into :P80_DEADLINE, :P80_NUMBER_OF_ROWS, :P80_PROTECTION',
'  from r_templates',
' where tpl_id = :P80_NAME; '))
,p_attribute_02=>'P80_NAME'
,p_attribute_03=>'P80_DEADLINE,P80_NUMBER_OF_ROWS,P80_PROTECTION'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(94910171897827826)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Collection'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if APEX_COLLECTION.COLLECTION_EXISTS(p_collection_name => ''edit_template'') then',
'        APEX_COLLECTION.TRUNCATE_COLLECTION(p_collection_name => ''edit_template'');    ',
'    else    ',
'        apex_collection.create_collection(''edit_template'');',
'    end if;        ',
'',
'    for rec in (',
'    select ',
'       :P80_NAME as tpl_id,',
'       tph_hea_id as hea_id,',
'       hea_text as hea_text,',
'       tph_thg_id  as tph_thg_id,',
'       tph_xlsx_background_color as tph_xlsx_background_color, ',
'       tph_xlsx_font_color as tph_xlsx_font_color,',
'       thv_formula1,',
'       thv_formula2,',
'       :P80_DEADLINE as tpl_deadline,',
'       :P80_NUMBER_OF_ROWS as tpl_number_of_rows,',
'       :P80_PROTECTION as tpl_ssp_id',
'      from r_header',
'      join template_header',
'        on hea_id = tph_hea_id',
'      join r_templates ',
'        on tph_tpl_id = tpl_id',
'      left join template_header_validations',
'        on thv_tph_id = tph_id    ',
'     where tpl_id = :P80_NAME',
'       and tph_hea_id not in (master_api.get_faulty_id(), master_api.get_annotation_id(), master_api.get_feedback_id(), master_api.get_validation_id())',
'    order by tph_sort_order',
'    )    ',
'    loop',
'    apex_collection.add_member(p_collection_name => ''edit_template''',
'                              ,p_c001 => rec.tpl_id',
'                              ,p_c002 => rec.hea_id',
'                              ,p_c003 => rec.hea_text',
'                              ,p_c004 => rec.tph_xlsx_font_color',
'                              ,p_c005 => rec.tph_xlsx_background_color ',
'                              ,p_c006 => rec.tpl_deadline',
'                              ,p_c007 => rec.tpl_number_of_rows',
'                              ,p_c008 => rec.tph_thg_id ',
'                              ,p_c009 => rec.thv_formula1 ',
'                              ,p_c010 => rec.thv_formula2 ',
'                              ,p_c011 => rec.tpl_ssp_id',
'                              );    ',
'    end loop;',
'end;                       '))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(94907209859827670)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(94910531632827831)
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
