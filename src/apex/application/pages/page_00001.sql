prompt --application/pages/page_00001
begin
--   Manifest
--     PAGE: 00001
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>205442218172938197
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(87144684090596262)
,p_name=>'Home'
,p_alias=>'HOME'
,p_step_title=>'Excel Gateway for Oracle APEX'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.t-Body-content {   ',
'background-image:url(#APP_IMAGES#prozess.jpg);',
'background-repeat: no-repeat;',
'background-size : 92% 92%;  ',
'display: flex; ',
'justify-content: center; ',
'align-items: center;',
'}'))
,p_last_updated_by=>'THERWIX'
,p_last_upd_yyyymmddhh24miss=>'20210819120622'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(87131029095592923)
,p_plug_name=>'Home'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(87256721244596377)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<b>Please select a template above or create a new template. The selected template serves as a filter for further work with the application.</b>',
'<br><br>',
'<img src="#APP_IMAGES#prozess.jpg" alt="Prozess">'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.component_end;
end;
/
