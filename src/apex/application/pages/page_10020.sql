prompt --application/pages/page_10020
begin
--   Manifest
--     PAGE: 10020
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
 p_id=>10020
,p_user_interface_id=>wwv_flow_api.id(179050793507173566)
,p_name=>'About this Application'
,p_alias=>'HELP'
,p_page_mode=>'MODAL'
,p_step_title=>'About this Application'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_api.id(187529009182517868)
,p_help_text=>'All application help text can be accessed from this page. The links in the "Documentation" region give a much more in-depth explanation of the application''s features and functionality.'
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20211105123144'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(187529650555517869)
,p_plug_name=>'About Page'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(178966174358173469)
,p_plug_display_sequence=>20
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<center>   ',
'    <b>Excel Gateway for Oracle APEX</b><br />',
'	<i style="color:gray;">Version 1.0</i></p>',
'    <img src="#APP_IMAGES#Logo.png" alt="Excel Gateway for Oracle APEX" style="width:150px;height:150px;"></p>  ',
'    <b>Manual: <a href="#APP_IMAGES#Excel for Oracle APEX - Manual.pdf" target="_blank">click here</a><p/>',
'</center>'))
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.component_end;
end;
/
