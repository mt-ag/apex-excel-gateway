prompt --application/shared_components/automations/send_new_reminder
begin
--   Manifest
--     AUTOMATION: Send New Reminder
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>205442218172938197
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_automation(
 p_id=>wwv_flow_api.id(71439382587741484)
,p_name=>'Send New Reminder'
,p_static_id=>'send-new-reminder'
,p_trigger_type=>'POLLING'
,p_polling_interval=>'FREQ=DAILY;INTERVAL=1;BYHOUR=0;BYMINUTE=0'
,p_polling_status=>'DISABLED'
,p_result_type=>'ROWS'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_type=>'SQL'
,p_query_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
'     , tis_id',
'     , file_length',
'  from p00030_VW',
'  join template_automations tpa on tpl_id = tpa.tpa_tpl_id',
' where tis_sts_id != 3 ',
'   and tis_shipping_status != 1    ',
'   and TO_CHAR(SYSDATE, ''mm/dd/yyyy'') > TO_CHAR(tis_deadline, ''mm/dd/yyyy'')',
'   and tpa.tpa_enabled = 1',
'   and to_char(to_date(sysdate), ''d'') member of apex_string.split((select tpa_days from template_automations where tpa_tpl_id = tpa.tpa_tpl_id), '':'')',
''))
,p_include_rowid_column=>false
,p_commit_each_row=>false
,p_error_handling_type=>'IGNORE'
);
wwv_flow_api.create_automation_action(
 p_id=>wwv_flow_api.id(71439193596741484)
,p_automation_id=>wwv_flow_api.id(71439382587741484)
,p_name=>'New Action'
,p_execution_sequence=>10
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    email_pkg.reminder_automation (',
'        p_tis_id            => :tis_id,',
'        p_tis_annotation    => :tis_annotation,',
'        p_per_id            => :per_id,',
'        p_per_name          => :per_name,',
'        p_per_email         => :per_email,',
'        p_tpl_id            => :tpl_id',
'    );',
'',
'end;'))
,p_action_clob_language=>'PLSQL'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
);
wwv_flow_api.component_end;
end;
/
