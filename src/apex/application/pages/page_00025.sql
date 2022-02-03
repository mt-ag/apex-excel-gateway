prompt --application/pages/page_00025
begin
--   Manifest
--     PAGE: 00025
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
 p_id=>25
,p_user_interface_id=>wwv_flow_api.id(179050793507173566)
,p_name=>'Save Template'
,p_alias=>'SAVE-TEMPLATE'
,p_step_title=>'Save Template'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20211215164054'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(197060767018742708)
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
 p_id=>wwv_flow_api.id(192547112465563694)
,p_plug_name=>'Save Template'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(178966174358173469)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(192590440095946704)
,p_plug_name=>'Summary Detail'
,p_parent_plug_id=>wwv_flow_api.id(192547112465563694)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(178964252952173468)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  seq_id as SEQ_ID, ',
'        c003 as HEA_TEXT, ',
'        case when substr(lower(c004),1,2) = ''ff'' then replace(c004,substr(c004,1,2),''#'') else c004 end as TPH_XLSX_FONT_COLOR, ',
'        case when substr(lower(c005),1,2) = ''ff'' then replace(c005,substr(c005,1,2),''#'') else c005 end as TPH_XLSX_BACKGROUND_COLOR,',
'        c008 as TPH_THG_ID,',
'        c009 as THV_FORMULA1,',
'        c010 as THV_FORMULA2',
'  from  apex_collections ',
' where  collection_name = ''CREATE_TEMPLATE'''))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Summary Detail'
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
 p_id=>wwv_flow_api.id(203763812394786394)
,p_name=>'TPH_XLSX_BACKGROUND_COLOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TPH_XLSX_BACKGROUND_COLOR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_COLOR_PICKER'
,p_heading=>'Xlsx Background Color'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
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
 p_id=>wwv_flow_api.id(203763723981786393)
,p_name=>'TPH_XLSX_FONT_COLOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TPH_XLSX_FONT_COLOR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_COLOR_PICKER'
,p_heading=>'Xlsx Font Color'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
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
 p_id=>wwv_flow_api.id(193986817971006208)
,p_name=>'THV_FORMULA2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'THV_FORMULA2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Formula2'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
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
 p_id=>wwv_flow_api.id(193986654084006207)
,p_name=>'THV_FORMULA1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'THV_FORMULA1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Formula1'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
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
 p_id=>wwv_flow_api.id(192590773799946707)
,p_name=>'HEA_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HEA_TEXT'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Header'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
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
 p_id=>wwv_flow_api.id(192590691309946706)
,p_name=>'SEQ_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SEQ_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Column'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(171663726273746426)
,p_name=>'TPH_THG_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TPH_THG_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Header-Group'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(192975374221499456)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(192590551022946705)
,p_internal_uid=>165949784932790955
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
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
 p_id=>wwv_flow_api.id(192611249134099917)
,p_interactive_grid_id=>wwv_flow_api.id(192590551022946705)
,p_static_id=>'278907'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(192611371765099917)
,p_report_id=>wwv_flow_api.id(192611249134099917)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(203803538351869209)
,p_view_id=>wwv_flow_api.id(192611371765099917)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(203763812394786394)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(203802570580869207)
,p_view_id=>wwv_flow_api.id(192611371765099917)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(203763723981786393)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(194010432672071507)
,p_view_id=>wwv_flow_api.id(192611371765099917)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(193986817971006208)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(194009542391071505)
,p_view_id=>wwv_flow_api.id(192611371765099917)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(193986654084006207)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(192612396587099929)
,p_view_id=>wwv_flow_api.id(192611371765099917)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(192590773799946707)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(192611844710099923)
,p_view_id=>wwv_flow_api.id(192611371765099917)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(192590691309946706)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(171612602987659334)
,p_view_id=>wwv_flow_api.id(192611371765099917)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(171663726273746426)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(171663641691746425)
,p_name=>'Summary'
,p_parent_plug_id=>wwv_flow_api.id(192547112465563694)
,p_template=>wwv_flow_api.id(178966174358173469)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader js-removeLandmark:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-AVPList--fixedLabelMedium:t-AVPList--leftAligned:t-Report--hideNoPagination'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  c001 as Template_Name,',
'        c006 as Deadline,',
'        c007 as Number_of_rows,',
'        case when c011 is not null then ssp_name else ''-'' end as Protection ',
'  from  apex_collections ',
'  left join r_spreadsheet_protection on c011 = ssp_id',
' where  collection_name = ''CREATE_TEMPLATE''',
'   and  seq_id = 1'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_api.id(178998042399173490)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(193970593765943779)
,p_query_column_id=>1
,p_column_alias=>'TEMPLATE_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Template Name:'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<b>#TEMPLATE_NAME#</b>'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(193970923896943779)
,p_query_column_id=>2
,p_column_alias=>'DEADLINE'
,p_column_display_sequence=>30
,p_column_heading=>'Deadline:'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<b>#DEADLINE#</b>'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(193971416825943779)
,p_query_column_id=>3
,p_column_alias=>'NUMBER_OF_ROWS'
,p_column_display_sequence=>40
,p_column_heading=>'Number Of Rows:'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<b>#NUMBER_OF_ROWS#</b>'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254146702409853157)
,p_query_column_id=>4
,p_column_alias=>'PROTECTION'
,p_column_display_sequence=>50
,p_column_heading=>'Protection: '
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<b>#PROTECTION#</b>'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(255702342776446458)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(192547112465563694)
,p_button_name=>'Preview'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(179028410771173516)
,p_button_image_alt=>'Preview'
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-file-excel-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(193966909774943752)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(192547112465563694)
,p_button_name=>'Save_Template'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(179028410771173516)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save Template'
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-save'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(193966482960943747)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(192547112465563694)
,p_button_name=>'BackToValidations'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(179028410771173516)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Back'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:24:&SESSION.::&DEBUG.:24::'
,p_icon_css_classes=>'fa-step-backward'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(193972969075943806)
,p_branch_name=>'GoTo30'
,p_branch_action=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(193966909774943752)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(255702066133446456)
,p_branch_name=>'Show preview'
,p_branch_action=>'P25_DOWNLOAD_URL'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'BRANCH_TO_URL_IDENT_BY_ITEM'
,p_branch_when_button_id=>wwv_flow_api.id(255702342776446458)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(255702050989446455)
,p_name=>'P25_DOWNLOAD_URL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(192547112465563694)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(193972424416943803)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Template'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'p00025_api.create_new_template(pi_collection_name => ''create_template'');',
'APEX_COLLECTION.TRUNCATE_COLLECTION(p_collection_name => ''create_template'');'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(193966909774943752)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(255702196380446457)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Preview'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_tpl_name r_templates.tpl_name%type;',
'begin',
'    select c001 ',
'      into l_tpl_name',
'      from apex_collections ',
'     where collection_name = ''CREATE_TEMPLATE''',
'       and seq_id = 1;',
'    ',
'    l_tpl_name := replace(l_tpl_name, '' '', ''_'');',
'    ',
'    delete files where fil_filename = l_tpl_name || ''_sample_file.xlsx'';',
'',
'    p00025_api.create_preview(pi_collection_name => ''CREATE_TEMPLATE'');',
'    ',
'    select ''f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.:APPLICATION_PROCESS=download_blob:::FIL_ID:'' || fil_id  as download_url',
'    into :P25_DOWNLOAD_URL',
'    from files',
'    where fil_filename = l_tpl_name || ''_sample_file.xlsx'';',
'end;    '))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(255702342776446458)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(193972053292943801)
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
