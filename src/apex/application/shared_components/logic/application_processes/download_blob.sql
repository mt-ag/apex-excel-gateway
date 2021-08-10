prompt --application/shared_components/logic/application_processes/download_blob
begin
--   Manifest
--     APPLICATION PROCESS: download_blob
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>34214513418261287
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_flow_process(
 p_id=>wwv_flow_api.id(15757712215835772)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'download_blob'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_files_row files%rowtype;',
'begin',
'  select *',
'    into l_files_row',
'    from files ',
'   where fil_id = :FIL_ID;',
'',
'  -- Im HTTP-Header wird der Dateityp gesetzt. Damit erkennt der Browser',
'  -- welche Applikation (bspw. MS Word) zu starten ist',
'  owa_util.mime_header(coalesce(l_files_row.fil_mimetype,''application/octet''),false);',
'',
unistr('  -- Die Dateigr\00F6\00DFe wird dem Browser ebenfalls mitgeteilt'),
'  htp.p(''Content-length:''|| dbms_lob.getlength(l_files_row.fil_file));',
'',
'  -- Das Datum (LETZTE_AENDERUNG) wird ebenfalls als HTTP-Header gesetzt',
'  htp.p(''Date:''||to_char(l_files_row.fil_modified_on,''Dy, DD Mon RRRR hh24:mi:ss'')||'' CET'');',
'',
'  htp.p(''Content-Disposition: attachment; filename=''||l_files_row.fil_filename);',
'',
unistr('  -- Der Browser soll die Datei unter keinen Umst\00E4nden aus dem Cache holen.'),
'  htp.p(''Cache-Control: must-revalidate, max-age=0'');',
'  htp.p(''Expires: Thu, 01 Jan 1970 01:00:00 CET'');',
'',
'  -- Die Datei bekommt eine ID - damit kann der Browser sie eindeutig erkennen.',
'  htp.p(''Etag: TAB_files...''||:FIL_ID||''...''||to_char(l_files_row.fil_modified_on, ''JHH24MISS''));',
'',
'  -- Alle HTTP-Header-Felder sind gesetzt',
'  owa_util.http_header_close;',
'',
unistr('  -- Dieser kurze Aufruf f\00FChrt den eigentlichen Datei-Download durch.'),
'  wpg_docload.download_file(l_files_row.fil_file);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
wwv_flow_api.component_end;
end;
/
