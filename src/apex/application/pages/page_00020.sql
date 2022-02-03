prompt --application/pages/page_00020
begin
--   Manifest
--     PAGE: 00020
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
 p_id=>20
,p_user_interface_id=>wwv_flow_api.id(179050793507173566)
,p_name=>'Create Template'
,p_alias=>'CREATE-TEMPLATE'
,p_step_title=>'Create Template'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>'only_numeric()'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20211215163826'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184294339248793024)
,p_plug_name=>'Create new Template'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayLabels'
,p_plug_template=>wwv_flow_api.id(178966174358173469)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_list_id=>wwv_flow_api.id(193154645791643813)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(179025511335173510)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(180132449660547799)
,p_plug_name=>'Create Template (Step 1 of 5)'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(178966174358173469)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(180132699148547801)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(180132449660547799)
,p_button_name=>'Save_Template'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(179028410771173516)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-step-forward'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(180174824119930799)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(180132449660547799)
,p_button_name=>'Reset'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(179028410771173516)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reset'
,p_button_position=>'PREVIOUS'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(184294461368793025)
,p_branch_name=>'GoTo Page 21'
,p_branch_action=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:21::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(180132699148547801)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254146810389853158)
,p_name=>'P20_PROTECTION'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(180132449660547799)
,p_prompt=>'Sheet Protection'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'R_SPREADSHEET_PROTECTION'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- no protection -'
,p_cHeight=>1
,p_colspan=>6
,p_grid_column=>1
,p_field_template=>wwv_flow_api.id(179027216878173513)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(253718105269403558)
,p_name=>'P20_ADOPT_TEMPLATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(180132449660547799)
,p_prompt=>'Adopt existing template'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'R_TEMPLATES'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- please select -'
,p_cHeight=>1
,p_colspan=>6
,p_grid_column=>1
,p_field_template=>wwv_flow_api.id(179027216878173513)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'If you would like to adopt headers and so on from an existing template, then please select one'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(192747058901256300)
,p_name=>'P20_NUMBER_OF_ROWS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(180132449660547799)
,p_prompt=>'Number of maximum rows'
,p_placeholder=>'e.g. 100'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'only-numeric'
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(179027216878173513)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(192746962066256299)
,p_name=>'P20_DEADLINE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(180132449660547799)
,p_prompt=>'Deadline (number of days to edit)'
,p_placeholder=>'e.g. 14'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'only-numeric'
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_grid_column=>7
,p_field_template=>wwv_flow_api.id(179027216878173513)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(180132547472547800)
,p_name=>'P20_NAME'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(180132449660547799)
,p_prompt=>'Template Name'
,p_placeholder=>'e.g. Employee List'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_column=>1
,p_field_template=>wwv_flow_api.id(179027515618173513)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(98082618259953942)
,p_validation_name=>'Check Template Name'
,p_validation_sequence=>10
,p_validation=>'P20_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please enter a template Name'
,p_when_button_pressed=>wwv_flow_api.id(180132699148547801)
,p_associated_item=>wwv_flow_api.id(180132547472547800)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(180174961385930800)
,p_name=>'Clear all items'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(180174824119930799)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(180175062195930801)
,p_event_id=>wwv_flow_api.id(180174961385930800)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20_NAME,P20_DEADLINE,P20_NUMBER_OF_ROWS,P20_PROTECTION'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(180175160796930802)
,p_event_id=>wwv_flow_api.id(180174961385930800)
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
 p_id=>wwv_flow_api.id(180177165615930822)
,p_event_id=>wwv_flow_api.id(180174961385930800)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'Reset'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184294186156793022)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Collection'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if APEX_COLLECTION.COLLECTION_EXISTS(p_collection_name => ''create_template'') then',
'    APEX_COLLECTION.TRUNCATE_COLLECTION(p_collection_name => ''create_template'');    ',
'else    ',
'    apex_collection.create_collection(''create_template'');',
'end if;    ',
'',
'if :P20_ADOPT_TEMPLATE is not null then',
'',
'    for rec in (',
'    select ',
'       :P20_NAME as tpl_name,',
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
'     where tpl_id = :P20_ADOPT_TEMPLATE',
'       and tph_hea_id not in (master_api.get_faulty_id(), master_api.get_annotation_id(), master_api.get_feedback_id(), master_api.get_validation_id())',
'    order by tph_sort_order',
'    )    ',
'    loop',
'    apex_collection.add_member(p_collection_name => ''create_template''',
'                              ,p_c001 => rec.tpl_name',
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
'',
'end if;   ',
' '))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(180132699148547801)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(174412793699687714)
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
