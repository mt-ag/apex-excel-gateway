prompt --application/shared_components/email/templates/reminder
begin
--   Manifest
--     REPORT LAYOUT: REMINDER
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
 p_id=>wwv_flow_api.id(15763618340316846)
,p_name=>'REMINDER'
,p_static_id=>'REMINDER'
,p_subject=>'Reminder Survey'
,p_html_body=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<b>Dear #CONTACT_PERSON#,</b><br>',
'<br>',
'This is a reminder to collect data.<br> ',
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
,p_html_header=>'<b style="font-size: 24px;">Reminder Survey</b>'
,p_text_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Dear #CONTACT_PERSON#,',
'',
'This is a reminder to collect data.',
'',
'Please fill out the attached list.',
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
