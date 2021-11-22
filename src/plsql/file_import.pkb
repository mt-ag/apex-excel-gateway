create or replace package body file_import 
as 
 
  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.'; 

  type t_sheet_data_varray     is varray(300) of varchar2(4000); 
  type t_survey_answers_tab    is table of template_import_data%rowtype index by pls_integer; 

  cursor ref_cur is 
      select * 
      from table ( 
        apex_data_parser.parse ( 
          p_content         => (select fil_file from files where fil_id = 1) 
        ) 
      ) 
    ; 

  /* put each excel row in a varray which is iteratable and acessible over varray(i) */ 
  function get_varray ( 
    pi_r in ref_cur%rowtype 
  ) return t_sheet_data_varray 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_varray'; 
    l_params logger.tab_param; 

    l_varray_col_values t_sheet_data_varray; 
  begin 
    logger.log('START', l_scope, null, l_params); 

    l_varray_col_values := t_sheet_data_varray(  
      pi_r.col001, pi_r.col002, pi_r.col003, pi_r.col004, pi_r.col005, pi_r.col006, pi_r.col007, pi_r.col008 
    , pi_r.col009, pi_r.col010, pi_r.col011, pi_r.col012, pi_r.col013, pi_r.col014, pi_r.col015, pi_r.col016 
    , pi_r.col017, pi_r.col018, pi_r.col019, pi_r.col020, pi_r.col021, pi_r.col022, pi_r.col023, pi_r.col024 
    , pi_r.col025, pi_r.col026, pi_r.col027, pi_r.col028, pi_r.col029, pi_r.col030, pi_r.col031, pi_r.col032 
    , pi_r.col033, pi_r.col034, pi_r.col035, pi_r.col036, pi_r.col037, pi_r.col038, pi_r.col039, pi_r.col040 
    , pi_r.col041, pi_r.col042, pi_r.col043, pi_r.col044, pi_r.col045, pi_r.col046, pi_r.col047, pi_r.col048 
    , pi_r.col049, pi_r.col050, pi_r.col051, pi_r.col052, pi_r.col053, pi_r.col054, pi_r.col055, pi_r.col056 
    , pi_r.col057, pi_r.col058, pi_r.col059, pi_r.col060, pi_r.col061, pi_r.col062, pi_r.col063, pi_r.col064 
    , pi_r.col065, pi_r.col066, pi_r.col067, pi_r.col068, pi_r.col069, pi_r.col070, pi_r.col071, pi_r.col072 
    , pi_r.col073, pi_r.col074, pi_r.col075, pi_r.col076, pi_r.col077, pi_r.col078, pi_r.col079, pi_r.col080 
    , pi_r.col081, pi_r.col082, pi_r.col083, pi_r.col084, pi_r.col085, pi_r.col086, pi_r.col087, pi_r.col088 
    , pi_r.col089, pi_r.col090, pi_r.col091, pi_r.col092, pi_r.col093, pi_r.col094, pi_r.col095, pi_r.col096 
    , pi_r.col097, pi_r.col098, pi_r.col099, pi_r.col100, pi_r.col101, pi_r.col102, pi_r.col103, pi_r.col104 
    , pi_r.col105, pi_r.col106, pi_r.col107, pi_r.col108, pi_r.col109, pi_r.col110, pi_r.col111, pi_r.col112 
    , pi_r.col113, pi_r.col114, pi_r.col115, pi_r.col116, pi_r.col117, pi_r.col118, pi_r.col119, pi_r.col120 
    , pi_r.col121, pi_r.col122, pi_r.col123, pi_r.col124, pi_r.col125, pi_r.col126, pi_r.col127, pi_r.col128 
    , pi_r.col129, pi_r.col130, pi_r.col131, pi_r.col132, pi_r.col133, pi_r.col134, pi_r.col135, pi_r.col136 
    , pi_r.col137, pi_r.col138, pi_r.col139, pi_r.col140, pi_r.col141, pi_r.col142, pi_r.col143, pi_r.col144 
    , pi_r.col145, pi_r.col146, pi_r.col147, pi_r.col148, pi_r.col149, pi_r.col150, pi_r.col151, pi_r.col152 
    , pi_r.col153, pi_r.col154, pi_r.col155, pi_r.col156, pi_r.col157, pi_r.col158, pi_r.col159, pi_r.col160 
    , pi_r.col161, pi_r.col162, pi_r.col163, pi_r.col164, pi_r.col165, pi_r.col166, pi_r.col167, pi_r.col168 
    , pi_r.col169, pi_r.col170, pi_r.col171, pi_r.col172, pi_r.col173, pi_r.col174, pi_r.col175, pi_r.col176 
    , pi_r.col177, pi_r.col178, pi_r.col179, pi_r.col180, pi_r.col181, pi_r.col182, pi_r.col183, pi_r.col184 
    , pi_r.col185, pi_r.col186, pi_r.col187, pi_r.col188, pi_r.col189, pi_r.col190, pi_r.col191, pi_r.col192 
    , pi_r.col193, pi_r.col194, pi_r.col195, pi_r.col196, pi_r.col197, pi_r.col198, pi_r.col199, pi_r.col200 
    , pi_r.col201, pi_r.col202, pi_r.col203, pi_r.col204, pi_r.col205, pi_r.col206, pi_r.col207, pi_r.col208 
    , pi_r.col209, pi_r.col210, pi_r.col211, pi_r.col212, pi_r.col213, pi_r.col214, pi_r.col215, pi_r.col216 
    , pi_r.col217, pi_r.col218, pi_r.col219, pi_r.col220, pi_r.col221, pi_r.col222, pi_r.col223, pi_r.col224 
    , pi_r.col225, pi_r.col226, pi_r.col227, pi_r.col228, pi_r.col229, pi_r.col230, pi_r.col231, pi_r.col232 
    , pi_r.col233, pi_r.col234, pi_r.col235, pi_r.col236, pi_r.col237, pi_r.col238, pi_r.col239, pi_r.col240 
    , pi_r.col241, pi_r.col242, pi_r.col243, pi_r.col244, pi_r.col245, pi_r.col246, pi_r.col247, pi_r.col248 
    , pi_r.col249, pi_r.col250, pi_r.col251, pi_r.col252, pi_r.col253, pi_r.col254, pi_r.col255, pi_r.col256 
    , pi_r.col257, pi_r.col258, pi_r.col259, pi_r.col260, pi_r.col261, pi_r.col262, pi_r.col263, pi_r.col264 
    , pi_r.col265, pi_r.col266, pi_r.col267, pi_r.col268, pi_r.col269, pi_r.col270, pi_r.col271, pi_r.col272 
    , pi_r.col273, pi_r.col274, pi_r.col275, pi_r.col276, pi_r.col277, pi_r.col278, pi_r.col279, pi_r.col280 
    , pi_r.col281, pi_r.col282, pi_r.col283, pi_r.col284, pi_r.col285, pi_r.col286, pi_r.col287, pi_r.col288 
    , pi_r.col289, pi_r.col290, pi_r.col291, pi_r.col292, pi_r.col293, pi_r.col294, pi_r.col295, pi_r.col296 
    , pi_r.col297, pi_r.col298, pi_r.col299, pi_r.col300 
    ); 

    logger.log('END', l_scope); 

    return l_varray_col_values; 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end get_varray; 

  function remove_empty_spaces( 
    pi_string in varchar2 
  ) return varchar2 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'remove_empty_spaces'; 
    l_params logger.tab_param; 

    l_return varchar2(4000 char); 
  begin 
    l_return := replace( 
                  replace ( 
                    replace (pi_string, CHR(13)) 
                  , CHR(10) 
                  ) 
                  , ' ' 
    ); 

    return l_return; 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end; 

  procedure log_processing_error ( 
    pi_message  in import_errors.ier_message%type 
  , pi_filename in import_errors.ier_filename%type 
  , pi_row_id   in import_errors.ier_row_id%type   default null 
  , pi_header   in import_errors.ier_header%type  default null 
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'log_processing_error'; 
    l_params logger.tab_param; 
  begin 
    logger.append_param(l_params, 'pi_message', pi_message); 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.append_param(l_params, 'pi_row_id', pi_row_id); 
    logger.append_param(l_params, 'pi_header', pi_header); 
    logger.log('START', l_scope, null, l_params); 

    insert into import_errors ( 
      ier_message 
    , ier_filename 
    , ier_row_id 
    , ier_header 
    , ier_session 
    ) values ( 
      pi_message 
    , pi_filename 
    , pi_row_id 
    , pi_header 
    , apex_application.g_instance 
    ); 

    logger.log_warn(pi_message, l_scope, null, l_params); 

    logger.log('END', l_scope); 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end log_processing_error; 


  procedure validate_required_ids ( 
    pi_per_id          in r_person.per_id%type 
  , pi_tis_id          in template_import_status.tis_id%type 
  , pi_filename        in import_errors.ier_filename%type 
  , pi_row_id          in import_errors.ier_row_id%type 
  , pio_error_occurred in out nocopy boolean  
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'validate_required_ids'; 
    l_params logger.tab_param; 
  begin 
    logger.append_param(l_params, 'pi_per_id', pi_per_id); 
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id); 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.append_param(l_params, 'pi_row_id', pi_row_id); 
    logger.log('START', l_scope, null, l_params); 

    if pi_per_id is null then 
      pio_error_occurred := true; 
      log_processing_error( 
        pi_message  => 'Person ID can not imported' 
      , pi_filename => pi_filename 
      , pi_row_id   => pi_row_id 
      ); 
    end if; 

    if pi_tis_id is null then 
      pio_error_occurred := true; 
      log_processing_error( 
        pi_message  => 'template_import_status ID can not imported' 
      , pi_filename => pi_filename 
      , pi_row_id   => pi_row_id 
      ); 
    end if; 

    logger.log('END', l_scope); 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end validate_required_ids; 


  procedure get_tis_id ( 
    pi_tpl_id          in r_templates.tpl_id%type 
  , pi_per_id          in r_person.per_id%type 
  , pi_filename        in import_errors.ier_filename%type 
  , po_tis_id          out nocopy template_import_status.tis_id%type 
  , pio_error_occurred in out nocopy boolean 
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_tis_id'; 
    l_params logger.tab_param; 
    l_count_no_data_found number;
  begin 
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id); 
    logger.append_param(l_params, 'pi_per_id', pi_per_id); 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.log('START', l_scope, null, l_params); 

    -- validate input parameters not null 
    if    pi_tpl_id is null  
       or pi_per_id is null  
    then 
      pio_error_occurred := true; 
      log_processing_error( 
        pi_message  => 'Required values Survey ID or contact person ID not available' 
      , pi_filename => pi_filename 
      ); 
    else 
      l_count_no_data_found := 1;

        -- get tis_id 
        select tis_id 
          into po_tis_id 
          from template_import_status 
         where tis_per_id = pi_per_id 
           and tis_tpl_id = pi_tpl_id
        ; 

        -- validate tis_id not null 
        if po_tis_id is null then 
          pio_error_occurred := true; 
          log_processing_error( 
            pi_message  => 'Survey for contact persons could not be found' 
          , pi_filename => pi_filename 
          ); 
        end if; 
    end if; 

    logger.log('END', l_scope); 
  exception 
    when no_data_found then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);          
        if l_count_no_data_found = 1 then    
          raise_application_error(-20002,'Survey for contact persons could not be found!');
        end if;
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end get_tis_id; 


  procedure prepare_answer_write ( 
    pi_answer                in template_import_data.tid_text%type 
  , pi_header                in r_header.hea_text%type 
  , pi_tis_id                in template_import_status.tis_id%type 
  , pi_row_id                in template_import_data.tid_row_id%type 
  , pi_tpl_id                in r_templates.tpl_id%type 
  , pi_filename              in import_errors.ier_filename%type 
  , pio_error_occurred       in out nocopy boolean 
  , po_survey_answers_row    out nocopy template_import_data%rowtype 
  , pi_column_nr             in number
  ) 
  as 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'prepare_answer_write'; 
    l_params logger.tab_param; 

    l_tph_id template_header.tph_id%type; 
    l_count pls_integer; 
    l_answer template_import_data.tid_text%type;

    l_column_nr number;
  begin 
    logger.append_param(l_params, 'pi_answer', pi_answer); 
    logger.append_param(l_params, 'pi_header', pi_header); 
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id); 
    logger.append_param(l_params, 'pi_row_id', pi_row_id); 
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id); 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.append_param(l_params, 'pi_column_nr', pi_column_nr); 
    logger.log('START', l_scope, null, l_params); 

    if pi_header = 'Validation' then
        l_column_nr := 282;
    elsif pi_header = 'Annotation' then     
        l_column_nr := 280;
    else 
        l_column_nr := pi_column_nr;
    end if;    


    select count(*) 
      into l_count 
      from template_header 
      join r_header  
        on hea_id = tph_hea_id 
       and remove_empty_spaces(hea_text) = remove_empty_spaces(pi_header) 
       and tph_sort_order = l_column_nr
     where tph_tpl_id = pi_tpl_id 
    ; 

    if l_count = 1 then 
      select tph_id 
        into l_tph_id
        from template_header 
        join r_header  
          on hea_id = tph_hea_id 
         and remove_empty_spaces(hea_text) = remove_empty_spaces(pi_header) 
         and tph_sort_order = l_column_nr
       where tph_tpl_id = pi_tpl_id 
      ; 

      l_answer := pi_answer;

      po_survey_answers_row.tid_row_id := pi_row_id; 
      po_survey_answers_row.tid_tis_id := pi_tis_id; 
      po_survey_answers_row.tid_tph_id := l_tph_id; 
      po_survey_answers_row.tid_text   := l_answer; 
    else 
        pio_error_occurred := true; 
        log_processing_error( 
          pi_message  => 'r_header could not be found => ' || pi_header 
        , pi_filename => pi_filename 
        , pi_row_id   => pi_row_id 
        , pi_header   => pi_header 
        ); 
    end if; 

    logger.log('END', l_scope); 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end prepare_answer_write; 


  procedure read_file( 
    pi_tpl_id         in  r_templates.tpl_id%type 
  , pi_fil_id         in  files.fil_id%type 
  , pi_filename       in  files.fil_filename%type 
  , po_error_occurred out nocopy boolean 
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'read_file'; 
    l_params logger.tab_param; 

    l_per_id r_person.per_id%type; 
    l_tis_id template_import_status.tis_id%type; 

    l_header_row  t_sheet_data_varray; 
    l_current_row t_sheet_data_varray; 

    l_row_id pls_integer; 
    l_row_count pls_integer; 

    l_current_answer   template_import_data.tid_text%type; 
    l_current_question r_header.hea_text%type; 

    l_error_occurred        boolean := false; 

    l_line_number_count     number; 
    l_insert_count          pls_integer := 1; 
    l_update_count          pls_integer := 1; 
    l_column_count          pls_integer := 1; 
    l_check_korrektur       varchar2(100);
    l_column                pls_integer; 

    l_insert_tab t_survey_answers_tab; 
    l_update_tab t_survey_answers_tab; 
    l_update_fehlerhaft_tph_id template_import_data.tid_text%type; 
    l_count_update_error_tph_id number; 
  begin 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.append_param(l_params, 'pi_fil_id', pi_fil_id); 
    logger.log('START', l_scope, null, l_params); 

    -- Zelleninhalt A8 auslesen um prüfen zu können ob es eine Korrekturdatei ist  
    select col001
      into l_check_korrektur
      from table ( 
        apex_data_parser.parse ( 
          p_content         => (select fil_file from files where fil_id = pi_fil_id) 
        , p_add_headers_row => 'N' 
        , p_xlsx_sheet_name => 'sheet1.xml' 
        , p_max_rows        => 500 
        , p_file_name       => pi_filename  
        ) 
      )
      where line_number = excel_gen.gc_header_row;    

    select count(line_number)
      into l_line_number_count
      from table ( 
        apex_data_parser.parse ( 
          p_content         => (select fil_file from files where fil_id = pi_fil_id) 
        , p_add_headers_row => 'N' 
        , p_xlsx_sheet_name => 'sheet1.xml' 
        , p_max_rows        => 500 
        , p_file_name       => pi_filename 
        ) 
      )
      where not (line_number > excel_gen.gc_header_row and
    col001 || col002 || col003 || col004 || col005 || col006 || col007 || col008 || col009 || col010 || col011 || col012 || col013 || col014 || col015 || 
    col016 || col017 || col018 || col019 || col020 || col021 || col022 || col023 || col024 || col025 || col026 || col027 || col028 || col029 || col030 || 
    col031 || col032 || col033 || col034 || col035 || col036 || col037 || col038 || col039 || col040 || col041 || col042 || col043 || col044 || col045 is null); 

    select tph_sort_order 
      into l_column   
      from template_header
      join r_header 
        on hea_id = tph_hea_id
      join r_validation
        on hea_val_id = val_id
      left join template_header_validations
             on thv_tph_id = tph_id  
     where tph_tpl_id = pi_tpl_id 
       and val_id = 4       
    order by tph_sort_order;
  
 for rec in ( 
   select * 
   from table ( 
  apex_data_parser.parse ( 
    p_content         => (select fil_file from files where fil_id = pi_fil_id) 
  , p_add_headers_row => 'N' 
  , p_xlsx_sheet_name => 'sheet1.xml' 
  , p_max_rows        => 500 
  , p_file_name       => pi_filename 
  ) 
   )  
   where not (line_number > excel_gen.gc_header_row and
  case when l_column = 1 then null else col001 end ||
  case when l_column = 2 then null else col002 end ||
  case when l_column = 3 then null else col003 end ||
  case when l_column = 4 then null else col004 end ||
  case when l_column = 5 then null else col005 end ||
  case when l_column = 6 then null else col006 end ||
  case when l_column = 7 then null else col007 end ||
  case when l_column = 8 then null else col008 end ||
  case when l_column = 9 then null else col009 end ||
  case when l_column = 10 then null else col010 end ||
  case when l_column = 11 then null else col011 end ||
  case when l_column = 12 then null else col012 end ||
  case when l_column = 13 then null else col013 end ||
  case when l_column = 14 then null else col014 end ||
  case when l_column = 15 then null else col015 end ||
  case when l_column = 16 then null else col016 end ||
  case when l_column = 17 then null else col017 end ||
  case when l_column = 18 then null else col018 end ||
  case when l_column = 19 then null else col019 end ||
  case when l_column = 20 then null else col020 end ||
  case when l_column = 21 then null else col021 end ||
  case when l_column = 22 then null else col022 end ||
  case when l_column = 23 then null else col023 end ||
  case when l_column = 24 then null else col024 end ||
  case when l_column = 25 then null else col025 end ||
  case when l_column = 26 then null else col026 end ||
  case when l_column = 27 then null else col027 end ||
  case when l_column = 28 then null else col028 end ||
  case when l_column = 29 then null else col029 end ||
  case when l_column = 30 then null else col030 end ||
  case when l_column = 31 then null else col031 end ||
  case when l_column = 32 then null else col032 end ||
  case when l_column = 33 then null else col033 end ||
  case when l_column = 34 then null else col034 end ||
  case when l_column = 35 then null else col035 end ||
  case when l_column = 36 then null else col036 end ||
  case when l_column = 37 then null else col037 end ||
  case when l_column = 38 then null else col038 end ||
  case when l_column = 39 then null else col039 end ||
  case when l_column = 40 then null else col040 end ||
  case when l_column = 41 then null else col041 end ||
  case when l_column = 42 then null else col042 end ||
  case when l_column = 43 then null else col043 end ||
  case when l_column = 44 then null else col044 end ||
  case when l_column = 45 then null else col045 end is null)     
 ) 
 loop 
      -- Falls es eine korrekturdatei ist muss der Column Counter um 1 verringert werden damit die Spalten richtig gematcht werden können
      /*if l_check_korrektur = 'Validation' then
         l_column_count := -1;
      else
         l_column_count := 1;   
      end if; */
      l_column_count := 1;   
   case  
  when rec.line_number = 1 then 
    l_current_row := get_varray(rec); 

    l_per_id := l_current_row(excel_gen.gc_ids_col1); 
    logger.log_info('imported per_id =>' || l_per_id); 

    l_tis_id := l_current_row(excel_gen.gc_ids_col2); 
    logger.log_info('imported tis_id =>' || l_tis_id); 

    validate_required_ids ( 
      pi_per_id          => l_per_id 
    , pi_tis_id          => l_tis_id  
    , pi_filename        => pi_filename 
    , pi_row_id          => rec.line_number 
    , pio_error_occurred => l_error_occurred 
    ); 

  update (
   select tis_deadline from template_import_status
       join r_person on tis_per_id = per_id
       join r_templates on tis_tpl_id = tpl_id
      where tis_id = l_tis_id) pss
        set pss.tis_deadline = NULL;

  update (
   select tis_sts_id from template_import_status
     join r_person on tis_per_id = per_id
     join r_templates on tis_tpl_id = tpl_id
    where tis_id = l_tis_id) pss  
      set pss.tis_sts_id = 2;

        update (
     select tis_shipping_status from template_import_status
       join r_person on tis_per_id = per_id
       join r_templates on tis_tpl_id = tpl_id
      where tis_id = l_tis_id) pss 
        set pss.tis_shipping_status = 2;

  when rec.line_number = excel_gen.gc_header_row then 
    l_header_row := get_varray(rec); 
  when rec.line_number > excel_gen.gc_header_row then 
    l_current_row := get_varray(rec); 
    if l_current_row(excel_gen.gc_ids_col1) is null then 
   l_row_id := tid_row_seq.nextval; 
    end if; 

    for i in 1..l_current_row.last 
    loop 
   if l_header_row(i) is not null then 
     -- hidden id to match corrected answer  
     if l_current_row(excel_gen.gc_ids_col1) is not null then 
    prepare_answer_write ( 
      pi_answer                => l_current_row(i) 
    , pi_header                => l_header_row(i) 
    , pi_tis_id                => l_tis_id 
    , pi_row_id                => l_current_row(excel_gen.gc_ids_col1) 
    , pi_tpl_id                => pi_tpl_id 
    , pi_filename              => pi_filename 
    , pio_error_occurred       => l_error_occurred 
    , po_survey_answers_row    => l_update_tab(l_update_count)
    , pi_column_nr             => l_column_count    
    ); 
    l_column_count := l_column_count +1;

    l_update_count := l_update_count + 1; 
     else 
    prepare_answer_write ( 
      pi_answer                => l_current_row(i) 
    , pi_header               => l_header_row(i) 
    , pi_tis_id                => l_tis_id 
    , pi_row_id                => l_row_id 
    , pi_tpl_id                => pi_tpl_id 
    , pi_filename              => pi_filename 
    , pio_error_occurred       => l_error_occurred 
    , po_survey_answers_row    => l_insert_tab(l_insert_count) 
    , pi_column_nr             => l_column_count    
    ); 
    l_column_count := l_column_count +1;
    l_insert_count := l_insert_count + 1; 
     end if;  
   end if; 
    end loop;           
  else 
    null;   
      end case;           
 end loop;     

    -- insert / update only when file has no errors 
    if not l_error_occurred then 
      -- merge into unfortunately not possible from plsql table       
      forall i in 1..l_insert_tab.count 
        insert into template_import_data values l_insert_tab(i)         
      ; 

      forall i in 1..l_update_tab.count 

        update template_import_data  
           set tid_text   = l_update_tab(i).tid_text 
         where tid_tis_id = l_update_tab(i).tid_tis_id 
           and tid_tph_id = l_update_tab(i).tid_tph_id 
           and tid_row_id = l_update_tab(i).tid_row_id 
      ; 

      for i in 1..l_update_tab.count loop

      select count(tid_tph_id) into l_count_update_error_tph_id from template_import_data 
        join template_header on tid_tph_id = tph_id 
      where tid_text = '1' 
        and tid_tis_id = l_update_tab(i).tid_tis_id 
        and tid_row_id = l_update_tab(i).tid_row_id 
        and tph_hea_id = 9999; 

      if l_count_update_error_tph_id = 1 then 

      -- Status zurücksetzen 
      select tid_tph_id into l_update_fehlerhaft_tph_id from template_import_data 
        join template_header on tid_tph_id = tph_id 
      where tid_text = '1' 
        and tid_tis_id = l_update_tab(i).tid_tis_id 
        and tid_row_id = l_update_tab(i).tid_row_id 
        and tph_hea_id = 9999; 

      update template_import_data  
        set tid_text = '0'
      where tid_tis_id = l_update_tab(i).tid_tis_id 
        and tid_tph_id = l_update_fehlerhaft_tph_id 
        and tid_row_id = l_update_tab(i).tid_row_id; 

      end if; 

      end loop;     

    -- Plausibilitaetspruefung starten
    validation_api.validation(l_tis_id); 

    end if; 

    <<end_case>>
    null;  

    po_error_occurred := l_error_occurred;

    logger.log('END', l_scope); 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end read_file; 


  procedure upload_file ( 
    pi_collection_name in  apex_collections.collection_name%type default 'DROPZONE_UPLOAD' 
  , pi_tpl_id          in  r_templates.tpl_id%type 
  , po_error_occurred  out nocopy number 
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'upload_file'; 
    l_params logger.tab_param; 

    l_fil_id files.fil_id%type; 

    l_file_error_occurred boolean; 
    l_any_error_occurred  boolean; 
  begin 
    logger.append_param(l_params, 'pi_collection_name', pi_collection_name); 
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id); 
    logger.log('START', l_scope, null, l_params); 

    for rec in ( 
      select c001                        as fil_filename 
           , c002                        as fil_mimetype 
           , apex_application.g_instance as fil_session 
           , blob001                     as fil_file 
           , 0                           as fil_import_export 
        from apex_collections 
       where collection_name = pi_collection_name 
    ) 
    loop 
      insert into files (  
        fil_filename 
      , fil_mimetype 
      , fil_session 
      , fil_file 
      , fil_import_export 
      , fil_import_completed    
      ) values (  
        rec.fil_filename 
      , rec.fil_mimetype 
      , rec.fil_session 
      , rec.fil_file 
      , rec.fil_import_export 
      , 0    
      ) returning fil_id into l_fil_id 
      ; 

      read_file( 
        pi_tpl_id         => pi_tpl_id 
      , pi_fil_id         => l_fil_id 
      , pi_filename       => rec.fil_filename 
      , po_error_occurred => l_file_error_occurred 
      ); 

      if l_file_error_occurred then 
        l_any_error_occurred := true; 
      else
        update files
           set fil_import_completed = 1
         where fil_id = l_fil_id;  
      end if; 
    end loop; 

    -- delete files from collection after insert 
    apex_collection.truncate_collection ( 
      p_collection_name => pi_collection_name 
    ); 

    if l_any_error_occurred then 
      po_error_occurred := 1; 
    else 
      po_error_occurred := 0; 
    end if; 

    logger.log('END', l_scope); 
  exception 
    when others then 
      apex_collection.truncate_collection ( 
        p_collection_name => pi_collection_name 
      ); 

      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end upload_file; 

end file_import;
/