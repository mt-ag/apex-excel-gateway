prompt --application/shared_components/user_interface/templates/report/dropzone
begin
--   Manifest
--     ROW TEMPLATE: DROPZONE
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>288269999118260128
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(119399139003811284)
,p_row_template_name=>'DropZone'
,p_internal_name=>'DROPZONE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div>',
'    <li data-hea_id=''#HEA_ID#'' data-hea_text=''#HEA_TEXT#'' class=''droplist-el'' >',
'        <button type="button" data-id=''#HEA_ID#'' data-seq_id=''#SEQ_ID#'' class="del" style="padding-left:0px;border:none;background:none" ><span class="fa fa-trash" style="color:#0076df;"></span></button>',
'        <button type="button" data-seq_id=''#SEQ_ID#'' class="down" style="padding-left:0px;border:none;background:none" ><span class="fa fa-arrow-up" style="color:#0076df;"></span></button>',
'        <button type="button" data-seq_id=''#SEQ_ID#'' class="up"   style="padding-left:0px;border:none;background:none" ><span class="fa fa-arrow-down" style="color:#0076df;"></span></button>',
'        #HEA_TEXT#<hr></li>',
'</div>',
'',
'',
''))
,p_row_template_before_rows=>' <ul class=''droplist'' ondragstart=''handleDrag(event)''>'
,p_row_template_after_rows=>' </ul>'
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_theme_id=>42
,p_theme_class_id=>7
,p_translate_this_template=>'N'
);
wwv_flow_api.component_end;
end;
/
