prompt --application/shared_components/email/templates/newtemplate
begin
--   Manifest
--     REPORT LAYOUT: NEWTEMPLATE
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>34214513418261287
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_email_template(
 p_id=>wwv_flow_api.id(15763298923305661)
,p_name=>'NEWTEMPLATE'
,p_static_id=>'NEWTEMPLATE'
,p_subject=>'New Template'
,p_html_body=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<img src="cid:Logo.png" alt="logo" width="140" height="150"/><br>',
'<b>Dear #CONTACT_PERSON#,</b><br>',
'<br>',
'This is a template to collect data.<br> ',
'<br>',
'Please fill out the attached list.<br>',
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
,p_html_header=>'<b style="font-size: 24px;">New Template</b>'
,p_text_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Dear #CONTACT_PERSON#,',
'',
'This is a template to collect data.',
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
