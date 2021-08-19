create or replace package body excel_gen
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';
  
  -- get index of last excel column depending on number of 'abfragen'-columns
  function getExcelColumnName(
    p_column_count pls_integer
  ) return varchar2
  as
    l_dividend pls_integer := p_column_count;
    l_columnName varchar2(5) := '';
    l_modulo pls_integer;
  begin
    while (l_dividend > 0)
    loop
        l_modulo := mod(l_dividend - 1, 26);
        l_columnName := chr(65 + l_modulo) || l_columnName;
        l_dividend := (l_dividend - l_modulo) / 26;
    end loop;

    return l_columnName;

  end getExcelColumnName;  

  function get_number_of_rows(
    pi_tpl_id   r_templates.tpl_id%type
  ) return r_templates.tpl_number_of_rows%type
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_number_of_rows';
    l_params logger.tab_param;
    
    l_number_of_rows r_templates.tpl_number_of_rows%type;
  begin  
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.log('START', l_scope, null, l_params);
    
    select tpl_number_of_rows
      into l_number_of_rows
      from r_templates
     where tpl_id = pi_tpl_id; 
    
    return l_number_of_rows;
    
    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_number_of_rows;
    
  procedure generate_abfragen (
    pi_tpl_id    in r_templates.tpl_id%type
  , pi_sheet_num in pls_integer
  , pi_invalid   in boolean
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_abfragen';
    l_params logger.tab_param;

    l_annotation_id     r_header.hea_id%type := master_api.get_annotation_id;
    l_error_id          r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id     r_header.hea_id%type := master_api.get_validation_id;

    l_max_sort_order pls_integer;

    l_columnName varchar2(5);
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_sheet_num', pi_sheet_num);
    logger.log('START', l_scope, null, l_params);

    l_max_sort_order := 0;

    if pi_invalid then
      for rec in (
        select hea_text
             , tph_xlsx_font_color
             , tph_xlsx_background_color
             , hea_xlsx_width
           from template_header
           join r_header
             on hea_id = tph_hea_id
        where tph_tpl_id = pi_tpl_id
          and tph_hea_id = l_validation_id
        order by tph_sort_order
      )
      loop
        xlsx_builder_pkg.cell(
          p_col       => 1  
        , p_row       => gc_header_row
        , p_value     => rec.hea_text
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.tph_xlsx_font_color)
        , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.tph_xlsx_background_color)
        , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')  
        , p_alignment => xlsx_builder_pkg.get_alignment( p_wraptext => true, p_vertical => 'top', p_horizontal => 'center') 
        , p_sheet     => pi_sheet_num
        );

        xlsx_builder_pkg.set_column_width(
          p_col   => 1 
        , p_width => rec.hea_xlsx_width
        , p_sheet => pi_sheet_num
        );
      end loop;

      for rec in (
        select hea_text
             , tph_xlsx_font_color
             , tph_xlsx_background_color
             , hea_xlsx_width
           from template_header
           join r_header
             on hea_id = tph_hea_id
        where tph_tpl_id = pi_tpl_id
          and tph_hea_id = l_annotation_id
        order by tph_sort_order
      )
      loop
        xlsx_builder_pkg.cell(
          p_col       => 2  
        , p_row       => gc_header_row
        , p_value     => rec.hea_text
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.tph_xlsx_font_color)
        , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.tph_xlsx_background_color)
        , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')  
        , p_alignment => xlsx_builder_pkg.get_alignment( p_wraptext => true, p_vertical => 'top', p_horizontal => 'center') 
        , p_sheet     => pi_sheet_num
        );

        xlsx_builder_pkg.set_column_width(
          p_col   => 2 
        , p_width => rec.hea_xlsx_width
        , p_sheet => pi_sheet_num
        );     
      end loop;
      l_max_sort_order := 2;  
    end if;

    for rec in (
      select tph_sort_order
           , hea_text
           , tph_xlsx_font_color
           , tph_xlsx_background_color
           , hea_xlsx_width
        from template_header
        join r_header 
          on hea_id = tph_hea_id
       where tph_tpl_id = pi_tpl_id
         and tph_hea_id not in (l_annotation_id, l_error_id, l_validation_id)         
       order by tph_sort_order
    )
    loop
      xlsx_builder_pkg.cell(
        p_col => l_max_sort_order + rec.tph_sort_order  
      , p_row => gc_header_row
      , p_value => rec.hea_text
      , p_fontid => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.tph_xlsx_font_color)
      , p_fillid => xlsx_builder_pkg.get_fill('solid', rec.tph_xlsx_background_color)
      , p_borderid => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')
      , p_alignment => xlsx_builder_pkg.get_alignment( p_wraptext => true, p_vertical => 'top', p_horizontal => 'center')
      , p_sheet => pi_sheet_num
      );

      xlsx_builder_pkg.set_column_width(     
        p_col   => l_max_sort_order + rec.tph_sort_order          
      , p_width => rec.hea_xlsx_width
      , p_sheet => pi_sheet_num
      );
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_abfragen;

  procedure generate_abfragegruppen (
    pi_tpl_id    in r_templates.tpl_id%type
  , pi_sheet_num in pls_integer
  , pi_invalid   in boolean
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_abfragegruppen';
    l_params logger.tab_param;

    l_max_sort_order    pls_integer;
    l_last_thg_id       template_header_group.thg_id%type;
    l_first_colnr_group pls_integer;
    l_thg_text          template_header_group.thg_text%type;
    l_tph_sort_order    template_header.tph_sort_order%type;

    l_count             pls_integer := 0;
    c_alignment         constant xlsx_builder_pkg.t_alignment_rec := xlsx_builder_pkg.get_alignment(
      p_wraptext   => true
    , p_vertical   => 'top'
    , p_horizontal => 'center'
    );
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_sheet_num', pi_sheet_num);
    logger.append_param(l_params, 'pi_invalid', pi_invalid);
    logger.log('START', l_scope, null, l_params);

    for rec in (
      select thg_id
           , tph_sort_order
           , thg_text
           , thg_xlsx_font_color
           , thg_xlsx_background_color
        from template_header_group
        join template_header
          on tph_thg_id = thg_id
         and tph_tpl_id = pi_tpl_id
       order by tph_sort_order
    )
    loop
      l_count := l_count + 1;

      if pi_invalid then
          l_tph_sort_order := rec.tph_sort_order + 2;
      else
          l_tph_sort_order := rec.tph_sort_order;
      end if;

      -- set Rahmen
      xlsx_builder_pkg.cell (
         p_col       => l_tph_sort_order
       , p_row       => gc_headergroup_row
       , p_sheet     => pi_sheet_num
       , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')
       , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.thg_xlsx_font_color)
       , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.thg_xlsx_background_color)
       , p_alignment => c_alignment
       , p_value     => ''
      );

      -- get last col nr
      select min(tph_sort_order), max(tph_sort_order)
        into l_first_colnr_group, l_max_sort_order
        from template_header_group
        join template_header
          on tph_thg_id = thg_id
         and tph_tpl_id = pi_tpl_id
         and thg_id = rec.thg_id
      ; 

      if pi_invalid then
          l_first_colnr_group := l_first_colnr_group +2;
          l_max_sort_order := l_max_sort_order +2;
      end if;

      -- if first group
      if l_tph_sort_order != l_max_sort_order then

        -- write group text
        xlsx_builder_pkg.cell (
          p_col       => l_tph_sort_order
        , p_row       => gc_headergroup_row
        , p_value     => rec.thg_text
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.thg_xlsx_font_color)
        , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.thg_xlsx_background_color)
        , p_alignment => c_alignment
        , p_sheet     => pi_sheet_num
        , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')
        );
      else

        xlsx_builder_pkg.cell (
          p_col       => l_tph_sort_order
        , p_row       => gc_headergroup_row
        , p_value     => rec.thg_text
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.thg_xlsx_font_color)
        , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.thg_xlsx_background_color)
        , p_alignment => c_alignment
        , p_sheet     => pi_sheet_num
        , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')
        );

        -- merge old ones
        xlsx_builder_pkg.mergecells (
          p_tl_col => l_first_colnr_group
        , p_tl_row => gc_headergroup_row
        , p_br_col => l_tph_sort_order
        , p_br_row => gc_headergroup_row
        , p_sheet  => pi_sheet_num
        );

/*
        -- generiere Pseudospalte fuer Zeilenumbrueche
        xlsx_builder_pkg.cell (
          p_col       => 300
        , p_row       => gc_headergroup_row
        , p_value     => '-' || Chr(13) || '-' || Chr(13) || '-'
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => 'FFFFFFFF')
        , p_alignment => c_alignment
        , p_sheet     => pi_sheet_num
        );
*/

      end if;
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_abfragegruppen;
  
  procedure generate_answers (
    pi_tis_id    in template_import_status.tis_id%type
  , pi_sheet_num in pls_integer
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_answers';
    l_params logger.tab_param;

    l_annotation_id      r_header.hea_id%type := master_api.get_annotation_id;
    l_faulty_id          r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id      r_header.hea_id%type := master_api.get_validation_id;

    l_max_sort_order  template_header.tph_sort_order%type;
    l_annotation      template_import_data.tid_text%type;

    l_last_row pls_integer;
    l_rownum   pls_integer := 0;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    select max(tph_sort_order)
      into l_max_sort_order
      from template_header
      join template_import_data
        on tid_tph_id = tph_id
       and tid_tis_id = pi_tis_id
     where tph_hea_id not in (l_annotation_id, l_faulty_id, l_validation_id)
    ;

    -- generate answers
    for rec in (
      select tid_row_id, tph_sort_order, tid_text
        from template_import_data
        join template_header
          on tid_tph_id = tph_id
        join r_header
          on tph_hea_id = hea_id
       where tid_tis_id = pi_tis_id
         and tph_hea_id not in (l_annotation_id, l_faulty_id, l_validation_id)
         and tid_row_id in (
             select tid_row_id
               from template_import_data
               join template_header
                 on tid_tph_id = tph_id
              where tid_tis_id = pi_tis_id
                and tph_hea_id = l_faulty_id
                and tid_text   = '1'
         )
       order by tid_row_id, tph_sort_order
    )
    loop
      if l_last_row is null or rec.tid_row_id != l_last_row then
        l_last_row := rec.tid_row_id;
        l_rownum := l_rownum + 1;

        -- Validation
        for i in (
        select tid_text
          from template_import_data 
          join template_header
            on tid_tph_id = tph_id
           and tph_hea_id = l_validation_id
           and tid_row_id = rec.tid_row_id
         where tid_tis_id = pi_tis_id 
        )    
        loop

        xlsx_builder_pkg.cell (
          p_col       => 1  
        , p_row       => l_rownum + gc_header_row
        , p_value     => i.tid_text
        , p_sheet     => pi_sheet_num
        , p_borderid => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')    
        );

        end loop;

        -- Annotation
        for i in (
        select tid_text
          from template_import_data 
          join template_header
            on tid_tph_id = tph_id
           and tph_hea_id = l_annotation_id
           and tid_row_id = rec.tid_row_id
         where tid_tis_id = pi_tis_id 
        )
        loop

        xlsx_builder_pkg.cell (
          p_col       => 2  
        , p_row       => l_rownum + gc_header_row
        , p_value     => i.tid_text
        , p_sheet     => pi_sheet_num
        , p_borderid => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')    
        );

        end loop;

      end if;

      -- generate each answer cell
      xlsx_builder_pkg.cell (
        p_col       => 2+ rec.tph_sort_order  
      , p_row       => l_rownum + gc_header_row
      , p_value     => rec.tid_text
      , p_sheet     => pi_sheet_num
      , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')            
      );
    end loop;

    -- generate hidden rownrs to match answers at the import
    for rec in (
      select tid_row_id, rownum
        from (
             select tid_row_id
               from template_import_data
               join template_header
                 on tid_tph_id = tph_id
              where tid_tis_id = pi_tis_id
                and tph_hea_id = l_faulty_id
                and tid_text   = '1'                
            )
           order by tid_row_id
    )
    loop
      xlsx_builder_pkg.cell (
        p_col       => gc_ids_col1
      , p_row       => rec.rownum + gc_header_row
      , p_value     => rec.tid_row_id
      , p_sheet     => pi_sheet_num
      );
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_answers;

  procedure generate_hidden_ids (
    pi_per_id    in r_person.per_id%type
  , pi_tis_id    in template_import_status.tis_id%type  
  , pi_sheet_num in pls_integer
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_hidden_ids';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_per_id', pi_per_id);
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.append_param(l_params, 'pi_sheet_num', pi_sheet_num);
    logger.log('START', l_scope, null, l_params);

    -- per_nr
    xlsx_builder_pkg.cell(
      p_col => gc_ids_col1
    , p_row => 1
    , p_value => pi_per_id
    , p_sheet => pi_sheet_num
    );

    xlsx_builder_pkg.set_column_width(
      p_col   => gc_ids_col1
    , p_width => 0
    , p_sheet => pi_sheet_num
    );    

    -- tis_id
    xlsx_builder_pkg.cell(
      p_col => gc_ids_col2
    , p_row => 1
    , p_value => pi_tis_id
    , p_sheet => pi_sheet_num
    );

    xlsx_builder_pkg.set_column_width(
      p_col   => gc_ids_col2
    , p_width => 0
    , p_sheet => pi_sheet_num
    );   

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_hidden_ids;

 procedure generate_validations (
    pi_tpl_id    in r_templates.tpl_id%type
  , pi_sheet_num in pls_integer
  , pi_invalid   in boolean
  , pi_number_of_rows in r_templates.tpl_number_of_rows%type 
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_validation';
    l_params logger.tab_param;

    l_annotation_id     r_header.hea_id%type := master_api.get_annotation_id;
    l_error_id          r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id     r_header.hea_id%type := master_api.get_validation_id;

    l_max_sort_order pls_integer;
    l_columnName varchar2(5 char);
    l_formula_row number;
    l_formula varchar2(2000 char);
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_sheet_num', pi_sheet_num);
    logger.append_param(l_params, 'pi_number_of_rows', pi_number_of_rows);
    logger.log('START', l_scope, null, l_params);    
    
    if pi_invalid then
        l_max_sort_order := 2;
    else
        l_max_sort_order := 0;
    end if;    
    
    for rec in (
      select tph_sort_order
           , hea_text
           , tph_xlsx_font_color
           , tph_xlsx_background_color
           , hea_xlsx_width
           , val_text      
           , val_message           
           , thv_formula1  
           , thv_formula2  
           , case when val_text = 'date' then to_date(thv_formula1 , 'dd-mm-yyyy') - to_date('30.12.1899','dd-mm-yyyy') end as thv_formula1_date
           , case when val_text = 'date' then to_date(thv_formula2 , 'dd-mm-yyyy') - to_date('30.12.1899','dd-mm-yyyy') end as thv_formula2_date
        from template_header
        join r_header 
          on hea_id = tph_hea_id
        join r_validation
          on hea_val_id = val_id
        left join template_header_validations
          on thv_tph_id = tph_id  
       where tph_tpl_id = pi_tpl_id
         and tph_hea_id not in (l_annotation_id, l_error_id, l_validation_id)         
       order by tph_sort_order
    )
    loop
      --if date add validation
      if rec.val_text = 'date' then

        -- get excel column name
        l_columnName := getExcelColumnName(l_max_sort_order + rec.tph_sort_order);

        -- add validation 
        for i in 1..pi_number_of_rows
        loop
            xlsx_builder_pkg.add_validation (
              p_type => 'date'
            , p_sqref => l_columnName || TO_CHAR (gc_header_row + i)
            , p_formula1 => rec.thv_formula1_date
            , p_formula2 => rec.thv_formula2_date
            , p_title => initcap(rec.val_text)
            , p_prompt => rec.thv_formula1 || ' - ' || rec.thv_formula2
            , p_show_error => true
            , p_error_txt => rec.val_message
            , p_sheet => pi_sheet_num
            );
        end loop;
      end if;

      --if number add validation  
      if rec.val_text = 'number' then

        -- get excel column name
        l_columnName := getExcelColumnName(l_max_sort_order + rec.tph_sort_order);

        -- add validation 
        for i in 1..pi_number_of_rows
        loop
            xlsx_builder_pkg.add_validation (
              p_type => 'decimal'
            , p_sqref => l_columnName || TO_CHAR (gc_header_row + i)
            , p_formula1 => rec.thv_formula1
            , p_formula2 => rec.thv_formula2
            , p_title => initcap(rec.val_text)
            , p_prompt => rec.thv_formula1 ||' - ' || rec.thv_formula2
            , p_show_error => true
            , p_error_txt => rec.val_message
            , p_sheet => pi_sheet_num
            );
        end loop;
      end if;  
      
      --if email add validation  
      if rec.val_text = 'email' then

        -- get excel column name
        l_columnName := getExcelColumnName(l_max_sort_order + rec.tph_sort_order);

        -- add validation for first 100 rows (same as dropdowns)
        for i in 1..pi_number_of_rows
        loop
            xlsx_builder_pkg.add_validation (
              p_type => 'custom'
            , p_sqref => l_columnName || TO_CHAR (gc_header_row + i)
            , p_formula1 => 'ISNUMBER(MATCH("*@*.?*",' || l_columnName || TO_CHAR (gc_header_row + i) ||',0))'
            , p_title => initcap(rec.val_text)
            , p_prompt => '-'
            , p_show_error => true
            , p_error_txt => rec.val_message
            , p_sheet => pi_sheet_num
            );
        end loop;
      end if;  
      
      --if formula add validation  
      if rec.val_text = 'formula' then

        -- get excel column name
        l_columnName := getExcelColumnName(l_max_sort_order + rec.tph_sort_order);

        -- add validation for first 100 rows (same as dropdowns)
        for i in 1..pi_number_of_rows
        loop
            l_formula_row := to_char(gc_header_row + i);
            l_formula := replace(rec.thv_formula1,'#',l_formula_row);
            
            xlsx_builder_pkg.cell (
              p_col => rec.tph_sort_order  
            , p_row => gc_header_row + i
            , p_sheet => pi_sheet_num
            , p_formula => l_formula
            , p_value => 'n/a'
            );
        end loop;
      end if; 
     
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_validations;
 
 procedure generate_dropdowns (
    pi_tpl_id         in r_templates.tpl_id%type
  , pi_sheet_num_main in pls_integer
  , pi_sheet_num_data in pls_integer  
  , pi_invalid        in boolean
  , pi_number_of_rows in r_templates.tpl_number_of_rows%type       
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_dropdowns';
    l_params logger.tab_param;
    l_cell   number default 0;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_sheet_num_main', pi_sheet_num_main);
    logger.append_param(l_params, 'pi_sheet_num_data', pi_sheet_num_data);
    logger.append_param(l_params, 'pi_number_of_rows', pi_number_of_rows);
    logger.log('START', l_scope, null, l_params);

    if pi_invalid then 
        l_cell := 2;
    end if;    

    -- iterate dropdowns for the current template
    for dds_group in (
      select hea_id, tph_sort_order, rownum, count
        from (
          select hea_id, tph_sort_order + l_cell
            as tph_sort_order, count(*) as count
            from r_dropdowns
            join r_header
              on dds_hea_id = hea_id
            join template_header
              on tph_hea_id = hea_id
             and tph_tpl_id = pi_tpl_id
          group by hea_id, tph_sort_order
          order by tph_sort_order
      )
    )
    loop
      -- iterate options for the current dropdown
      for dds_option in (
        select dds_text, rownum
         from r_dropdowns
        where dds_hea_id = dds_group.hea_id
        order by dds_text
      )
      loop
        -- write options into the hidden file
        xlsx_builder_pkg.cell(
          p_col   => dds_group.rownum
        , p_row   => dds_option.rownum
        , p_value => dds_option.dds_text
        , p_sheet => pi_sheet_num_data
        );
      end loop;

      -- create dropdowns
      for i in 1..pi_number_of_rows
      loop
        xlsx_builder_pkg.list_validation (
          p_sqref_col => dds_group.tph_sort_order
        , p_sqref_row => gc_header_row + i
        , p_tl_col    => dds_group.rownum
        , p_tl_row    => 1
        , p_br_col    => dds_group.rownum
        , p_br_row    => dds_group.count
        , p_show_error => true
        , p_sheet     => pi_sheet_num_main
        , p_sheet_datasource => pi_sheet_num_data
        );
      end loop;
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_dropdowns; 

 procedure generate_single_file (
    pi_tis_id        in template_import_status.tis_id%type
  , pi_tpl_id        in r_templates.tpl_id%type
  , pi_tpl_name      in r_templates.tpl_name%type
  , pi_per_id        in r_person.per_id%type
  , pi_per_firstname in r_person.per_firstname%type
  , pi_per_lastname  in r_person.per_lastname%type
  , pi_invalid       in boolean default false 
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_single_file';
    l_params logger.tab_param;

    l_blob                  blob;
    l_sheetname             varchar2(200 char);
    l_filename              files.fil_filename%type;
    l_fil_id                files.fil_id%type;

    l_sheet_num_main   pls_integer;
    l_sheet_num_hidden pls_integer;

    l_column_count pls_integer;
    l_value varchar2(200);
    l_number_of_rows pls_integer;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_tpl_name', pi_tpl_name);
    logger.append_param(l_params, 'pi_per_id', pi_per_id);
    logger.append_param(l_params, 'pi_per_firstname', pi_per_firstname);
    logger.append_param(l_params, 'pi_per_lastname', pi_per_lastname);
    logger.append_param(l_params, 'pi_invalid', pi_invalid);
    logger.log('START', l_scope, null, l_params);

    if pi_invalid then    
    l_filename := pi_tpl_name || '_' || pi_per_firstname  || '_' || pi_per_lastname || '_correction';
    else
    l_filename := pi_tpl_name || '_' || pi_per_firstname  || '_' || pi_per_lastname;
    end if;
    l_filename := replace(l_filename, ' ', '_') || '.xlsx';

    l_sheetname := pi_tpl_name;
    l_sheetname := replace(l_sheetname, ' ', '_');

    -- initially clear workbook
    xlsx_builder_pkg.clear_workbook;

    l_sheet_num_main   := xlsx_builder_pkg.new_sheet(l_sheetname);
    l_sheet_num_hidden := xlsx_builder_pkg.new_sheet('Dropdown Data', true);

    xlsx_builder_pkg.cell(
      p_col => 1
    , p_row => 1
    , p_value => 'Template: ' || pi_tpl_name
    , p_fontid => xlsx_builder_pkg.get_font(p_name => 'Arial', p_fontsize => 10, p_rgb => 'ff000000', p_bold => true)
    , p_sheet => l_sheet_num_main
    );

    xlsx_builder_pkg.cell(
      p_col => 1
    , p_row => 2
    , p_value => 'Contact: ' || pi_per_firstname || ' ' || pi_per_lastname
    , p_fontid => xlsx_builder_pkg.get_font(p_name => 'Arial', p_fontsize => 10, p_rgb => 'ff000000', p_bold => true)
    , p_sheet => l_sheet_num_main
    );

    -- get number of rows
    l_number_of_rows := get_number_of_rows(pi_tpl_id);
    
    generate_abfragen (
      pi_tpl_id    => pi_tpl_id
    , pi_sheet_num => l_sheet_num_main
    , pi_invalid   => pi_invalid
    );
    
    generate_abfragegruppen (
      pi_tpl_id    => pi_tpl_id
    , pi_sheet_num => l_sheet_num_main
    , pi_invalid   => pi_invalid
    );
    
    generate_validations (
      pi_tpl_id    => pi_tpl_id
    , pi_sheet_num => l_sheet_num_main
    , pi_invalid   => pi_invalid
    , pi_number_of_rows => l_number_of_rows
    );

    generate_hidden_ids (
      pi_per_id    => pi_per_id
    , pi_tis_id    => pi_tis_id
    , pi_sheet_num => l_sheet_num_main
    );

    if pi_invalid then
      generate_answers (
        pi_tis_id    => pi_tis_id
      , pi_sheet_num => l_sheet_num_main
      );
    end if;

    generate_dropdowns (
      pi_tpl_id         => pi_tpl_id
    , pi_sheet_num_main => l_sheet_num_main
    , pi_sheet_num_data => l_sheet_num_hidden    
    , pi_invalid        => pi_invalid
    , pi_number_of_rows => l_number_of_rows
    );

    -- generate blob file
    l_blob := xlsx_builder_pkg.finish;

    insert into files (
      fil_file
    , fil_filename
    , fil_mimetype
    , fil_session
    , fil_import_export
    ) values (
      l_blob
    , l_filename
    , 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    , apex_application.g_instance
    , 1
    ) returning fil_id into l_fil_id;

    if pi_tis_id > 0 then
        update template_import_status
           set tis_fil_id = l_fil_id
         where tis_id = pi_tis_id
        ;
    end if;

    if pi_invalid then
        update template_import_status
           set tis_shipping_status = 2
         where tis_id = pi_tis_id
        ;
    end if;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_single_file;

  procedure regenerate_invalid_rows (
    pi_tis_id in template_import_status.tis_id%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'regenerate_invalid_rows';
    l_params logger.tab_param;

    l_tpl_id        r_templates.tpl_id%type;
    l_tpl_name      r_templates.tpl_name%type;
    l_per_id        r_person.per_id%type;
    l_per_firstname r_person.per_firstname%type;
    l_per_lastname  r_person.per_lastname%type;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    -- query relevant data
    select tpl_id
         , tpl_name
         , per_id
         , per_firstname
         , per_lastname
      into l_tpl_id
         , l_tpl_name
         , l_per_id
         , l_per_firstname
         , l_per_lastname
      from template_import_status
      join r_person
        on tis_per_id = per_id
      join r_templates
        on tis_tpl_id = tpl_id
     where tis_id = pi_tis_id
    ;

    generate_single_file (
      pi_tis_id        => pi_tis_id
    , pi_tpl_id        => l_tpl_id
    , pi_tpl_name      => l_tpl_name
    , pi_per_id        => l_per_id
    , pi_per_firstname => l_per_firstname
    , pi_per_lastname  => l_per_lastname
    , pi_invalid       => true
    );

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end regenerate_invalid_rows;

end excel_gen;
/