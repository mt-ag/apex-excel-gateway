prompt --application/shared_components/user_interface/theme_style
begin
--   Manifest
--     THEME STYLE: 445
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>205442218172938197
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(168084980081303444)
,p_theme_id=>42
,p_name=>'Redwood Light'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/oracle-fonts/oraclesans-apex#MIN#.css?v=#APEX_VERSION#',
'#THEME_IMAGES#css/Redwood#MIN#.css?v=#APEX_VERSION#'))
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Redwood-Theme.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Redwood-Theme#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2596426436825065489
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(168084586330303443)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(168084157055303443)
,p_theme_id=>42
,p_name=>'Vita - Dark'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Dark.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Dark#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3543348412015319650
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(168083729127303443)
,p_theme_id=>42
,p_name=>'Vita - Red'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Red.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Red#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>1938457712423918173
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(168083333358303443)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Slate.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(136360724330017946)
,p_theme_id=>42
,p_name=>'MT AG'
,p_is_current=>true
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_config=>'{"classes":[],"vars":{},"customCSS":"/* Page 0 */\n#P0_TEMPLATE {\n    background-color: #0077df !important;\n    color: white !important;\n    font-weight: bold;    \n    margin-left: 5px;\n}\n\n#P0_TEMPLATE_CONTAINER {\n\tmargin-top: 5px;\n    marg'
||'in-bottom: 5px;\n}\n\n#P0_TEMPLATE_CONTAINER .t-Form-itemWrapper:after{\n    width: 0;\n    height: 0;\n    border-left: 6px solid transparent;\n    border-right: 6px solid transparent;\n    border-top: 6px solid white;\n    position: absolute;  \n  '
||'  top: 39%; \n    right: 19px;\n    content: \"\";\n    z-index: 9999;\n}\n\n#P0_TEMPLATE_LABEL {\n    color: black !important;\n    font-weight: bold;\n    white-space: nowrap;\n    margin-left: -8px;\n}\n\n/* Page 30 */\n#P30_MAILTYPE {\n    border'
||'-color: dimgrey !important;\n    background-color: #0077df !important;\n    color: white !important;\n    font-weight: bold !important;      \n}\n\n#P30_MAILTYPE_LABEL {\n    color: white !important;\n}\n\n#mail {\n    height: 48px;\n    text-align: '
||'left;\n}\n\n/* Page 21 */\n.draglist{\n    list-style-type: none;\n}\n\n.droplist{\n    list-style-type: decimal-leading-zero;\n}\n\n.draglist-el {\n    padding-top: 5px;\n    padding-bottom: 5px;\n}\n\n.droplist-el {\n    padding-top: 5px;\n    padd'
||'ing-bottom: 5px;\n}\n\nhr {  \n    margin-top: 5px; \n    margin-bottom: 0px; \n}\n\n/* Page 51 & 60 */\n.grid .a-GV-headerLabel {\n    white-space: pre-line;\n}\n\n.grid .a-GV-w-hdr{\n    overflow-x: auto !important;\n}","useCustomLess":"N"}'
,p_theme_roller_output_file_url=>'#THEME_DB_IMAGES#69081493842920251.css'
,p_theme_roller_read_only=>false
);
wwv_flow_api.component_end;
end;
/
