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
,p_default_id_offset=>68429026836522574
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>30
,p_user_interface_id=>wwv_flow_api.id(18662539674288619)
,p_name=>'Send Template'
,p_alias=>'SEND-TEMPLATE'
,p_step_title=>'Send Template'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($v("P30_MAILTYPE") != 0) {',
'    $("#mail").attr("disabled", false);',
'}',
'else {    ',
'    $("#mail").attr("disabled", true);',
'}'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#P30_DAYS .apex-item-option [for="P30_DAYS_1"] {',
'    -webkit-column-break-inside: avoid;    ',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20210528092445'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18648514837285277)
,p_plug_name=>'Send Template'
,p_region_name=>'ig_30'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(18749080229288717)
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
'     , ''''f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.:APPLICATION_PROCESS=download_blob:::FIL_ID:'''' || fil_id  as download_url',
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
 p_id=>wwv_flow_api.id(18646798821285259)
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
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(18646664459285258)
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
 p_id=>wwv_flow_api.id(18646556653285257)
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
 p_id=>wwv_flow_api.id(18646363458285255)
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
 p_id=>wwv_flow_api.id(18646231974285254)
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
 p_id=>wwv_flow_api.id(18646173585285253)
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
 p_id=>wwv_flow_api.id(18645522535285247)
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
 p_id=>wwv_flow_api.id(18645402250285245)
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
,p_link_attributes=>'data-id="&PER_ID." class="download t-Button t-Button--link"data-id="&PER_ID." data-fil_id="&FIL_ID." class="download t-Button t-Button--link"'
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
 p_id=>wwv_flow_api.id(18645262730285244)
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
 p_id=>wwv_flow_api.id(18645205426285243)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(18645043257285242)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(6364131283691686)
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
,p_lov_id=>wwv_flow_api.id(18472593129528068)
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
 p_id=>wwv_flow_api.id(6364055260691685)
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
 p_id=>wwv_flow_api.id(6363957418691684)
,p_name=>'TIS_DEADLINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIS_DEADLINE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Deadline'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>210
,p_value_alignment=>'LEFT'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
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
 p_id=>wwv_flow_api.id(6363821676691683)
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
,p_max_length=>8000
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
 p_id=>wwv_flow_api.id(6363805418691682)
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
 p_id=>wwv_flow_api.id(6363645060691681)
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
,p_lov_id=>wwv_flow_api.id(18472747749529621)
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
 p_id=>wwv_flow_api.id(6363528261691680)
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
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(18648507194285276)
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
 p_id=>wwv_flow_api.id(18508767382705867)
,p_interactive_grid_id=>wwv_flow_api.id(18648507194285276)
,p_static_id=>'278564'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(18508674217705867)
,p_report_id=>wwv_flow_api.id(18508767382705867)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18496281863552234)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(18646798821285259)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18495810666552232)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(18646664459285258)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18495310064552228)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(18646556653285257)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18494311465552223)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(18646363458285255)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>246
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18493762662552221)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(18646231974285254)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18493251831552219)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(18646173585285253)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18490275249552209)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(18645522535285247)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18489304853552205)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(18645402250285245)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18488769486552203)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(18645262730285244)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(18485297994546607)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(18645205426285243)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6358157213690900)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(6364131283691686)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6357149905690894)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(6364055260691685)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6356256965690891)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(6363957418691684)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6355366665690889)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(6363821676691683)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6354482998690886)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>27
,p_column_id=>wwv_flow_api.id(6363805418691682)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6353571225690884)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(6363645060691681)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6352708454690882)
,p_view_id=>wwv_flow_api.id(18508674217705867)
,p_display_seq=>29
,p_column_id=>wwv_flow_api.id(6363528261691680)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18647651904285268)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(18648514837285277)
,p_button_name=>'P30_SEND_MAIL'
,p_button_static_id=>'mail'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--iconLeft:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_api.id(18684922410288669)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Send Mail'
,p_button_position=>'BODY'
,p_button_css_classes=>'MAIL_SENDEN'
,p_icon_css_classes=>'fa-envelope-o'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17593879836287486)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18648514837285277)
,p_button_name=>'ADD_PERSON'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(18684922410288669)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Person'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:31:&SESSION.::&DEBUG.:31::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2955874286368686)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18648514837285277)
,p_button_name=>'AUTOMATIONS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(18684922410288669)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Automations'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:32:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-gears'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18648343549285275)
,p_name=>'P30_MAILTYPE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18648514837285277)
,p_item_default=>'0'
,p_prompt=>'Mailtype'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'MAILTYPE'
,p_lov=>'.'||wwv_flow_api.id(18505119947698391)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Please select -'
,p_lov_null_value=>'0'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(18686116303288672)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18647060028285262)
,p_name=>'P30_DOWNLOAD_URL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18648514837285277)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18644551051285237)
,p_name=>'P30_PER_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(18648514837285277)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17945753757186974)
,p_name=>'P30_FIL_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(18648514837285277)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17945621215186973)
,p_name=>'P30_FIL_FILENAME'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(18648514837285277)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(18647499043285266)
,p_validation_name=>'SELCTED MAILTYPE NOT NULL'
,p_validation_sequence=>10
,p_validation=>'P30_MAILTYPE'
,p_validation2=>'0'
,p_validation_type=>'ITEM_IN_VALIDATION_NOT_EQ_STRING2'
,p_error_message=>'Please select a mailtype'
,p_when_button_pressed=>wwv_flow_api.id(18647651904285268)
,p_associated_item=>wwv_flow_api.id(18648343549285275)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18647386451285265)
,p_name=>'Change Mailtype'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P30_MAILTYPE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18647232010285264)
,p_event_id=>wwv_flow_api.id(18647386451285265)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18648514837285277)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18647208069285263)
,p_event_id=>wwv_flow_api.id(18647386451285265)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($v("P30_MAILTYPE") != 0) {',
'    $("#mail").attr("disabled", false);',
'}',
'else {    ',
'    $("#mail").attr("disabled", true);',
'};'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18646980185285261)
,p_name=>'Change Filter'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P0_TEMPLATE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18646864534285260)
,p_event_id=>wwv_flow_api.id(18646980185285261)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18648514837285277)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18644905270285240)
,p_name=>'Click Download'
,p_event_sequence=>30
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.download'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'body'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18644789283285239)
,p_event_id=>wwv_flow_api.id(18644905270285240)
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
 p_id=>wwv_flow_api.id(18644655113285238)
,p_event_id=>wwv_flow_api.id(18644905270285240)
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
 p_id=>wwv_flow_api.id(18464583099448886)
,p_event_id=>wwv_flow_api.id(18644905270285240)
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
 p_id=>wwv_flow_api.id(18464504134448885)
,p_event_id=>wwv_flow_api.id(18644905270285240)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'javascript:window.location.href = $v("P30_DOWNLOAD_URL");',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17592692439287474)
,p_event_id=>wwv_flow_api.id(18644905270285240)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18648514837285277)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2955611526368683)
,p_name=>'Open Slideover'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2955874286368686)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18644953305285241)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(18648514837285277)
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
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18464344141448884)
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
,p_process_when_button_id=>wwv_flow_api.id(18647651904285268)
,p_process_success_message=>'The email (s) have been sent!'
);
wwv_flow_api.component_end;
end;
/
