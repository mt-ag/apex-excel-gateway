prompt --application/shared_components/email/templates/correction
begin
--   Manifest
--     REPORT LAYOUT: CORRECTION
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.6'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>349023258543091759
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_email_template(
 p_id=>wwv_flow_api.id(169760983050579171)
,p_name=>'CORRECTION'
,p_static_id=>'CORRECTION'
,p_subject=>'Correction Template'
,p_html_body=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<b>Dear #CONTACT_PERSON#,</b><br>',
'<br>',
'This is a template to collect data.<br> ',
'<br> ',
'We have found some incorrect data. Please have a look in the attached list and fill out again.<br>',
'<br>',
'Thank you in advance for your cooperation.<br>',
'<br>',
'Best regards<br>',
'<br>',
'<table width="100%">',
'  <tr>',
'    <th align="left">Deadline:</th>',
'    <td>#DEADLINE#</td>',
'  </tr>',
'  <tr>',
'    <th align="left" valign="top">Notes:</th>',
'    <td>#NOTES#</td>',
'  </tr>',
'</table>'))
,p_html_header=>'<b style="font-size: 24px;">Correction Template</b>'
,p_text_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Dear #CONTACT_PERSON#,',
'',
'This is a template to collect data. ',
'We have found some incorrect data. Please have a look in the attached list and fill out again.',
'',
'Thank you in advance for your cooperation.',
'',
'Best regards',
'',
'Deadline:   #DEADLINE#',
'Notes:      #NOTES#'))
);
wwv_flow_api.component_end;
end;
/
