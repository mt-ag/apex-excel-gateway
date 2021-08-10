prompt --application/pages/page_00021
begin
--   Manifest
--     PAGE: 00021
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
 p_id=>21
,p_user_interface_id=>wwv_flow_api.id(15551973743972668)
,p_name=>'Create Template - Header'
,p_alias=>'CREATE-TEMPLATE-HEADER'
,p_step_title=>'Create Template - Header'
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
,p_last_upd_yyyymmddhh24miss=>'20210523142627'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(46207363273708987)
,p_plug_name=>'Add Header (Step 2 of 5)'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(15467354594972571)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(46209348935709006)
,p_name=>'Source'
,p_region_name=>'source'
,p_parent_plug_id=>wwv_flow_api.id(46207363273708987)
,p_template=>wwv_flow_api.id(15467354594972571)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:i-h480:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_region_attributes=>'ondragover=''handleDragover(event)''   ondrop=''handleDrop(event)'''
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select HEA_ID, HEA_TEXT ',
'  from R_HEADER',
' where HEA_ID not in (9997,9998,9999) ',
'order by HEA_text'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16654338246449647)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(29579727171362090)
,p_query_column_id=>1
,p_column_alias=>'HEA_ID'
,p_column_display_sequence=>1
,p_column_heading=>'Hea Id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(29579307251362090)
,p_query_column_id=>2
,p_column_alias=>'HEA_TEXT'
,p_column_display_sequence=>2
,p_column_heading=>'Hea Text'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(46209626240709009)
,p_name=>'Target'
,p_region_name=>'target'
,p_parent_plug_id=>wwv_flow_api.id(46207363273708987)
,p_template=>wwv_flow_api.id(15467354594972571)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:i-h480:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_region_attributes=>'ondragover=''handleDragover(event)''   ondrop=''handleDrop(event)'''
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select seq_id, c003 as hea_text from apex_collections where collection_name = ''CREATE_TEMPLATE''',
'order by seq_id'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16653578665442017)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'<h4>Drop Header here</h4>'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(29578698105362089)
,p_query_column_id=>1
,p_column_alias=>'SEQ_ID'
,p_column_display_sequence=>1
,p_column_heading=>'Seq Id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(29578297821362088)
,p_query_column_id=>2
,p_column_alias=>'HEA_TEXT'
,p_column_display_sequence=>2
,p_column_heading=>'Hea Text'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(46249984726091989)
,p_plug_name=>'Hdden Items'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(15439936589972553)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50523332695103868)
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
 p_id=>wwv_flow_api.id(29577549888362085)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(46207363273708987)
,p_button_name=>'Add_Header'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(15529591007972618)
,p_button_image_alt=>'Add Header'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:27:&SESSION.::&DEBUG.:27::'
,p_icon_css_classes=>'fa-plus-square'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(29577196681362085)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(46207363273708987)
,p_button_name=>'Save_Header'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(15529591007972618)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_icon_css_classes=>'fa-step-forward'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(29576714523362085)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(46207363273708987)
,p_button_name=>'BackToTemplate'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(15529591007972618)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Back'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:20::'
,p_icon_css_classes=>'fa-step-backward'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(29616862287362130)
,p_branch_name=>'GoTo Page 22'
,p_branch_action=>'f?p=&APP_ID.:22:&SESSION.::&DEBUG.:22::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(29576043202362084)
,p_name=>'P21_ITEM'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(46249984726091989)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29602811455362122)
,p_name=>'Delete Item'
,p_event_sequence=>70
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.del'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29604285976362123)
,p_event_id=>wwv_flow_api.id(29602811455362122)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$s(''P21_ITEM'', $(this.triggeringElement).data(''seq_id''));'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29603795376362122)
,p_event_id=>wwv_flow_api.id(29602811455362122)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P21_ITEM'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29603332452362122)
,p_event_id=>wwv_flow_api.id(29602811455362122)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.server.process(',
'    ''Delete Item'',',
'    {',
'      x01: null',
'    },',
'    {',
'       success: function(){',
'             apex.event.trigger(''#target'', ''apexrefresh'')',
'       },',
'       dataType: ''text''',
'    });'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29600967982362121)
,p_name=>'MoveUp Item'
,p_event_sequence=>80
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.up'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29602404203362121)
,p_event_id=>wwv_flow_api.id(29600967982362121)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$s(''P21_ITEM'', $(this.triggeringElement).data(''seq_id''));'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29601925139362121)
,p_event_id=>wwv_flow_api.id(29600967982362121)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P21_ITEM'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29601418825362121)
,p_event_id=>wwv_flow_api.id(29600967982362121)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.server.process(',
'    ''MoveUp Item'',',
'    {',
'      x01: null',
'    },',
'    {',
'       success: function(){',
'             apex.event.trigger(''#target'', ''apexrefresh'')',
'       },',
'       dataType: ''text''',
'    });'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29599054694362120)
,p_name=>'MoveDown Item'
,p_event_sequence=>90
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.down'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29600597540362120)
,p_event_id=>wwv_flow_api.id(29599054694362120)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$s(''P21_ITEM'', $(this.triggeringElement).data(''seq_id''));'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29600069564362120)
,p_event_id=>wwv_flow_api.id(29599054694362120)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P21_ITEM'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29599528835362120)
,p_event_id=>wwv_flow_api.id(29599054694362120)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.server.process(',
'    ''MoveDown Item'',',
'    {',
'      x01: null',
'    },',
'    {',
'       success: function(){',
'             apex.event.trigger(''#target'', ''apexrefresh'')',
'       },',
'       dataType: ''text''',
'    });'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29615843223362129)
,p_name=>'Refresh Header'
,p_event_sequence=>120
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(46207363273708987)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29616391107362129)
,p_event_id=>wwv_flow_api.id(29615843223362129)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(46209348935709006)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29589135595362114)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Session State'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29589545142362114)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update Collection'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_collection.add_member(p_collection_name => ''create_template''',
'                              ,p_c001 => :P20_NAME',
'                              ,p_c002 => apex_application.g_x01 ',
'                              ,p_c003 => apex_application.g_x02',
'                              ,p_c004 => ''#000000'' ',
'                              ,p_c005 => ''#FFFFFF''',
'                              ,p_c006 => :P20_DEADLINE',
'                              ,p_c007 => :P20_NUMBER_OF_ROWS',
'                              );                        '))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29589907501362114)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete Item'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'APEX_COLLECTION.DELETE_MEMBER(',
'    p_collection_name => ''create_template'',',
'    p_seq => :P21_ITEM);',
'        ',
'APEX_COLLECTION.RESEQUENCE_COLLECTION (',
'p_collection_name => ''create_template''); '))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29590300488362114)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'MoveUp Item'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'APEX_COLLECTION.MOVE_MEMBER_UP(',
'    p_collection_name => ''create_template'',',
'    p_seq => :P21_ITEM);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29590729212362114)
,p_process_sequence=>40
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'MoveDown Item'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'APEX_COLLECTION.MOVE_MEMBER_DOWN(',
'    p_collection_name => ''create_template'',',
'    p_seq => :P21_ITEM);  '))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.component_end;
end;
/
