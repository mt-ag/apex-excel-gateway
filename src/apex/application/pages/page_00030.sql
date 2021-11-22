prompt --application/pages/page_00030
begin
--   Manifest
--     PAGE: 00030
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>288269999118260128
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>30
,p_user_interface_id=>wwv_flow_api.id(118297534082341935)
,p_name=>'Send Template'
,p_alias=>'SEND-TEMPLATE'
,p_step_title=>'Send Template'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#mail {',
'    height: 48px;',
'    text-align: left;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20211117082942'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(118311558919345277)
,p_plug_name=>'Send Template'
,p_region_name=>'ig_30'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(118210993527341837)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'q varchar2(4000);',
'begin',
'',
'q:=''',
'select per_id',
'     , per_name',
'     , per_email',
'     , tis_sts_id',
'     , fil_filename',
'     , fil_mimetype',
'     , fil_id',
'     , tpl_id',
'     , tis_deadline',
'     , tis_annotation',
'     , tis_fil_id',
'     , tis_shipping_status',
'     , APEX_UTIL.PREPARE_URL(''''f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.:APPLICATION_PROCESS=download_blob:::FIL_ID:'''' || fil_id)  as download_url',
'     , tis_id',
'     , ''''Download'''' as download',
'     , file_length',
'  from p00030_VW',
' where tpl_id = :P0_TEMPLATE'';',
'',
'',
'if :P30_MAILTYPE = 1 then',
'',
'q:=q||'' and tis_sts_id = 1 ',
'        and tis_shipping_status = 1',
'        and (tis_fil_id IS NULL or (tis_fil_id IS NOT NULL and file_length != 0))'';',
'   ',
'elsif :P30_MAILTYPE = 2 then ',
'',
'q:=q||'' and tis_sts_id = 2 ',
'   and tis_shipping_status = 2 ',
'   and (tis_fil_id IS NULL or (tis_fil_id IS NOT NULL and file_length != 0))'';',
'',
'elsif :P30_MAILTYPE = 3 then',
'',
'q:=q||'' and tis_sts_id != 3 ',
'   and tis_shipping_status != 1    ',
'   and TO_CHAR(SYSDATE, ''''mm/dd/yyyy'''') > TO_CHAR(tis_deadline, ''''mm/dd/yyyy'''')'';',
'',
'end if;',
'',
'return q;',
'end;'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P30_MAILTYPE,P0_TEMPLATE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Send Template'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130596545494938874)
,p_name=>'TIS_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIS_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>250
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130596428695938873)
,p_name=>'TIS_SHIPPING_STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIS_SHIPPING_STATUS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Shipping Status'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>240
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(118487326007100933)
,p_lov_display_extra=>true
,p_lov_display_null=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130596268337938872)
,p_name=>'TIS_FIL_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIS_FIL_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>230
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130596252079938871)
,p_name=>'TIS_ANNOTATION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIS_ANNOTATION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Annotation'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130596116337938870)
,p_name=>'TIS_DEADLINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIS_DEADLINE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_JET'
,p_heading=>'Deadline'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>210
,p_value_alignment=>'LEFT'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
,p_attribute_12=>'MONTH-PICKER:YEAR-PICKER'
,p_attribute_13=>'VISIBLE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130596018495938869)
,p_name=>'TPL_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TPL_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>200
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130595942472938868)
,p_name=>'TIS_STS_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIS_STS_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>190
,p_value_alignment=>'LEFT'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(118487480627102486)
,p_lov_display_extra=>true
,p_lov_display_null=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118315030499345312)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118314868330345311)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118314811026345310)
,p_name=>'FILE_LENGTH'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FILE_LENGTH'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>180
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118314671506345309)
,p_name=>'DOWNLOAD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DOWNLOAD'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_LINK'
,p_heading=>'Download'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>170
,p_value_alignment=>'LEFT'
,p_link_target=>'javascript:void(0);'
,p_link_text=>'&DOWNLOAD.'
,p_link_attributes=>'data-id="&PER_ID." data-fil_id="&FIL_ID." data-fil_filename="&FIL_FILENAME." class="download t-Button t-Button--link"'
,p_enable_filter=>false
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118314551221345307)
,p_name=>'DOWNLOAD_URL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DOWNLOAD_URL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>150
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118313900171345301)
,p_name=>'FIL_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FIL_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>90
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118313841782345300)
,p_name=>'FIL_MIMETYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FIL_MIMETYPE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>80
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118313710298345299)
,p_name=>'FIL_FILENAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FIL_FILENAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Filename'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>800
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118313517103345297)
,p_name=>'PER_EMAIL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PER_EMAIL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Email'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>800
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118313409297345296)
,p_name=>'PER_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PER_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>1604
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(118313274935345295)
,p_name=>'PER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PER_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(118311566562345278)
,p_internal_uid=>15566006223976011
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(118451306373924687)
,p_interactive_grid_id=>wwv_flow_api.id(118311566562345278)
,p_static_id=>'278564'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(118451399538924687)
,p_report_id=>wwv_flow_api.id(118451306373924687)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130607365301939672)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>29
,p_column_id=>wwv_flow_api.id(130596545494938874)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130606502530939670)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(130596428695938873)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130605590757939668)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>27
,p_column_id=>wwv_flow_api.id(130596268337938872)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130604707090939665)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(130596252079938871)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130603816790939663)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(130596116337938870)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130602923850939660)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(130596018495938869)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130601916542939654)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(130595942472938868)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118474775762083947)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(118314868330345311)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118471304270078351)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(118314811026345310)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118470768903078349)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(118314671506345309)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118469798507078345)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(118314551221345307)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118466821925078335)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(118313900171345301)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118466311094078333)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(118313841782345300)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118465762291078331)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(118313710298345299)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>246
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118464763692078326)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(118313517103345297)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118464263090078322)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(118313409297345296)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(118463791893078320)
,p_view_id=>wwv_flow_api.id(118451399538924687)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(118313274935345295)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(118312421852345286)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(118311558919345277)
,p_button_name=>'P30_SEND_MAIL'
,p_button_static_id=>'mail'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--iconLeft:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_api.id(118275151346341885)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Send Mail'
,p_button_position=>'BODY'
,p_icon_css_classes=>'fa-envelope-o'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(119366193920343068)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(118311558919345277)
,p_button_name=>'ADD_PERSON'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(118275151346341885)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Person'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:31:&SESSION.::&DEBUG.:31::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(134004199470261868)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(118311558919345277)
,p_button_name=>'AUTOMATIONS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(118275151346341885)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Automations'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:32:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-gears'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(119014452541443581)
,p_name=>'P30_FIL_FILENAME'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(118311558919345277)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(119014319999443580)
,p_name=>'P30_FIL_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(118311558919345277)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(118315522705345317)
,p_name=>'P30_PER_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(118311558919345277)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(118313013728345292)
,p_name=>'P30_DOWNLOAD_URL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(118311558919345277)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(118311730207345279)
,p_name=>'P30_MAILTYPE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(118311558919345277)
,p_item_default=>'0'
,p_prompt=>'Mailtype'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'MAILTYPE'
,p_lov=>'.'||wwv_flow_api.id(118454953808932163)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Please select -'
,p_lov_null_value=>'0'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(118273957453341882)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul>',
'	<li>Initial Mail: all templates that have not yet been sent and processed</li>',
'	<li>Correction Mail: all templates where corrections must be made</li>',
'	<li>Reminder Mail: all templates where the deadline has passed</li>	',
'</ul>'))
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(118312574713345288)
,p_validation_name=>'SELCTED MAILTYPE NOT NULL'
,p_validation_sequence=>10
,p_validation=>'P30_MAILTYPE'
,p_validation2=>'0'
,p_validation_type=>'ITEM_IN_VALIDATION_NOT_EQ_STRING2'
,p_error_message=>'Please select a mailtype'
,p_when_button_pressed=>wwv_flow_api.id(118312421852345286)
,p_associated_item=>wwv_flow_api.id(118311730207345279)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(118312687305345289)
,p_name=>'Change Mailtype'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P30_MAILTYPE'
,p_condition_element=>'P30_MAILTYPE'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(118312841746345290)
,p_event_id=>wwv_flow_api.id(118312687305345289)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(118311558919345277)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37328432262122302)
,p_event_id=>wwv_flow_api.id(118312687305345289)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(118311558919345277)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37328573683122303)
,p_event_id=>wwv_flow_api.id(118312687305345289)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(118312421852345286)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37328327229122301)
,p_event_id=>wwv_flow_api.id(118312687305345289)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(118312421852345286)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(118313093571345293)
,p_name=>'Change Filter'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P0_TEMPLATE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(118313209222345294)
,p_event_id=>wwv_flow_api.id(118313093571345293)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(118311558919345277)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(118315168486345314)
,p_name=>'Click Download'
,p_event_sequence=>30
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.download'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'body'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(118315284473345315)
,p_event_id=>wwv_flow_api.id(118315168486345314)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$s(''P30_PER_ID'', $(this.triggeringElement).data(''id''));',
'$s(''P30_FIL_ID'', $(this.triggeringElement).data(''fil_id''));',
'$s(''P30_FIL_FILENAME'', $(this.triggeringElement).data(''fil_filename''));'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(118315418643345316)
,p_event_id=>wwv_flow_api.id(118315168486345314)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P30_PER_ID,P30_FIL_ID,P30_FIL_FILENAME'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(118495490657181668)
,p_event_id=>wwv_flow_api.id(118315168486345314)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_fil_id number;',
'begin    ',
'    if not :P30_FIL_FILENAME like ''%correction%'' or :P30_FIL_ID is null then',
'        p00030_api.generate_excel_file ( ',
'            pi_tpl_id => :P0_TEMPLATE',
'          , pi_per_id => :P30_PER_ID',
'        );',
'        ',
'        select max(fil_id) ',
'          into l_fil_id ',
'          from files;',
'    else',
'        l_fil_id := :P30_FIL_ID;',
'    end if;',
'    ',
'    select ''f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.:APPLICATION_PROCESS=download_blob:::FIL_ID:'' || l_fil_id as download_url ',
'      into :P30_DOWNLOAD_URL ',
'      from dual;',
'      ',
'end;      '))
,p_attribute_02=>'P30_PER_ID,P0_TEMPLATE,P30_FIL_ID,P30_FIL_FILENAME'
,p_attribute_03=>'P30_DOWNLOAD_URL'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(118495569622181669)
,p_event_id=>wwv_flow_api.id(118315168486345314)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'javascript:window.location.href = $v("P30_DOWNLOAD_URL");',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(119367381317343080)
,p_event_id=>wwv_flow_api.id(118315168486345314)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(118311558919345277)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(134004462230261871)
,p_name=>'Open Slideover'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(134004199470261868)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(69024896168341136)
,p_name=>'Enable/Disable Add Person'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P0_TEMPLATE'
,p_condition_element=>'P0_TEMPLATE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(69025047877341138)
,p_event_id=>wwv_flow_api.id(69024896168341136)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(119366193920343068)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(69024971460341137)
,p_event_id=>wwv_flow_api.id(69024896168341136)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(119366193920343068)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(69025138676341139)
,p_name=>'Enable/Disable Automations'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P0_TEMPLATE'
,p_condition_element=>'P0_TEMPLATE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(69025368277341141)
,p_event_id=>wwv_flow_api.id(69025138676341139)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(134004199470261868)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(69025245834341140)
,p_event_id=>wwv_flow_api.id(69025138676341139)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(134004199470261868)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(118315120451345313)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(118311558919345277)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Send Template - Save Interactive Grid Data'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update template_import_status',
'   set tis_annotation       = :tis_annotation,',
'       tis_deadline         = :tis_deadline',
' where tis_id = :tis_id;',
'  '))
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>288269999118260128
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(118495729615181670)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send Mail'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'p00030_api.send_mail (',
'  pi_choice         => :P30_MAILTYPE,',
'  pi_app_id         => :APP_ID,  ',
'  pi_app_page_id    => :APP_PAGE_ID,',
'  pi_static_id      => ''ig_30''',
');'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(118312421852345286)
,p_process_success_message=>'The email (s) have been sent!'
);
null;
wwv_flow_api.component_end;
end;
/
