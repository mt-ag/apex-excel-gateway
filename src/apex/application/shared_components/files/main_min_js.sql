prompt --application/shared_components/files/main_min_js
begin
--   Manifest
--     APP STATIC FILES: 445
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>288269999118260128
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E206F6E6C795F6E756D6572696328297B2428222E6F6E6C792D6E756D6572696322292E62696E6428226B65797072657373222C2866756E6374696F6E2865297B76617220743D652E77686963683F652E77686963683A652E6B657943';
wwv_flow_api.g_varchar2_table(2) := '6F64653B72657475726E20743E3D34382626743C3D35377D29297D66756E6374696F6E2068616E646C65447261672865297B76617220743D7B6865615F69643A652E7461726765742E646174617365742E6865615F69642C6865615F746578743A652E74';
wwv_flow_api.g_varchar2_table(3) := '61726765742E646174617365742E6865615F746578747D2C613D4A534F4E2E737472696E676966792874293B652E646174615472616E736665722E73657444617461282264617461222C61297D66756E6374696F6E2068616E646C65447261676F766572';
wwv_flow_api.g_varchar2_table(4) := '2865297B652E70726576656E7444656661756C7428297D66756E6374696F6E2068616E646C6544726F702865297B76617220743D4A534F4E2E706172736528652E646174615472616E736665722E676574446174612822646174612229292E6865615F69';
wwv_flow_api.g_varchar2_table(5) := '642C613D4A534F4E2E706172736528652E646174615472616E736665722E676574446174612822646174612229292E6865615F746578743B617065782E7365727665722E70726F63657373282255706461746520436F6C6C656374696F6E222C7B783031';
wwv_flow_api.g_varchar2_table(6) := '3A742C7830323A617D2C7B737563636573733A66756E6374696F6E28297B617065782E6576656E742E74726967676572282223746172676574222C22617065787265667265736822297D2C64617461547970653A2274657874227D297D66756E6374696F';
wwv_flow_api.g_varchar2_table(7) := '6E20686967686C696768745F63656C6C7328297B2428222E677269642074642E56414C49444154494F4E22292E65616368282866756E6374696F6E28297B63656C6C446174613D242874686973292E7465787428292C22223D3D63656C6C446174613F74';
wwv_flow_api.g_varchar2_table(8) := '6869732E7374796C652E6261636B67726F756E64436F6C6F723D226C696D65677265656E223A2222213D63656C6C44617461262628746869732E7374796C652E6261636B67726F756E64436F6C6F723D22746F6D61746F22292C746869732E7374796C65';
wwv_flow_api.g_varchar2_table(9) := '2E636F6C6F723D227768697465227D29297D66756E6374696F6E20726567656E65726174655F627574746F6E28297B313D3D247628225035315F4641554C545922293F24282223726567656E657261746522292E61747472282264697361626C6564222C';
wwv_flow_api.g_varchar2_table(10) := '2131293A24282223726567656E657261746522292E61747472282264697361626C6564222C2130297D0A2F2F2320736F757263654D617070696E6755524C3D6D61696E2E6A732E6D6170';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(37965097369890460)
,p_file_name=>'main.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
