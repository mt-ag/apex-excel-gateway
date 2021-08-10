create or replace package body p00051_api
as
  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';
  function format_colnr (
    pi_colnr in pls_integer
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'format_colnr';
    l_params logger.tab_param;

    l_colnr varchar2(100 char);
  begin
    logger.append_param(l_params, 'pi_colnr', pi_colnr);
    logger.log('START', l_scope, null, l_params);

    l_colnr := 'col' || lpad(pi_colnr, 2, '0');

    logger.log('END', l_scope);
    return l_colnr;
    exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end format_colnr;


  function fill_columns (
    pi_count in pls_integer
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'fill_columns';
    l_params logger.tab_param;
    l_fill_columns varchar2(700 char);
  begin
    logger.append_param(l_params, 'pi_count', pi_count);
    logger.log('START', l_scope, null, l_params);

    for i in pi_count..45
    loop
      l_fill_columns := l_fill_columns || 'null as ' || format_colnr(i) || ', ';
    end loop;

    logger.log('END', l_scope);
    return l_fill_columns;
    exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end fill_columns;


  function get_pivot_columns (
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  as
    c_annotation constant varchar2(30 char) := 'Annotation';    
    c_faulty constant varchar2(11 char) := 'Faulty';
    c_validation constant varchar2(11 char) := 'Validation';

    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_pivot_columns';
    l_params logger.tab_param;

    l_annotation_id  r_header.hea_id%type;
    l_faulty_id r_header.hea_id%type;
    l_validation_id r_header.hea_id%type;

    l_count pls_integer := 0;
    l_tpl_id r_templates.tpl_id%type;

    l_new_col varchar2(100 char);
    l_pivot_columns varchar2(1000 char) := '';
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    select hea_id
      into l_annotation_id
      from r_header
     where hea_text = c_annotation
    ;

    select hea_id
      into l_faulty_id
      from r_header
     where hea_text = c_faulty
    ;

    select hea_id
      into l_validation_id
      from r_header
     where hea_text = c_validation
    ;

    select tpl_id
      into l_tpl_id
      from r_templates
      join template_import_status
        on tis_tpl_id = tpl_id
     where tis_id = pi_tis_id
    ;

    for rec in (
      select tph_hea_id, rownum
        from (
          select tph_hea_id
            from template_header
            join r_header
              on tph_hea_id = hea_id
           where tph_tpl_id = l_tpl_id
             and hea_id not in (l_faulty_id, l_annotation_id, l_validation_id)
           order by tph_sort_order
        )
    )
    loop
      l_count         := l_count + 1;
      l_new_col       := rec.tph_hea_id || rec.rownum || ' as ' || format_colnr(rec.rownum);
      l_pivot_columns := l_pivot_columns || l_new_col  || ', ';
    end loop;

    -- fill columns to static col count
    l_pivot_columns := l_pivot_columns || fill_columns(l_count + 1);

    -- add column_nr to identify the column and sort_order
    for rec in (
      select distinct tph_hea_id
        from (
          select tph_hea_id
            from template_header
            join r_header
              on tph_hea_id = hea_id
            join template_import_data
              on tid_tph_id = tph_id
           where tph_tpl_id = l_tpl_id
             and hea_id in (l_faulty_id, l_annotation_id,l_validation_id)
        ) order by tph_hea_id
    )
    loop
    if rec.tph_hea_id = l_annotation_id then  
        l_annotation_id      := l_annotation_id || (l_count+1) || 00;        
    elsif rec.tph_hea_id = l_faulty_id then  
        l_faulty_id     := l_faulty_id || (l_count+2) || 00;  
    elsif rec.tph_hea_id = l_validation_id then  
        l_validation_id     := l_validation_id || (l_count+3) || 00;      
    end if;    
    end loop;

    -- add faulty, annotation
    l_pivot_columns := l_pivot_columns || l_faulty_id || ' as faulty, ' || l_annotation_id || ' as annotation, ' || l_validation_id || ' as validation ';

    logger.log('END', l_scope);
    return l_pivot_columns ;
     exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end get_pivot_columns;


  function get_grid_query (
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_grid_query';
    l_params logger.tab_param;

    l_pivot_columns varchar2(1000 char);
    l_sql varchar2(32000 char);
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    l_pivot_columns := get_pivot_columns(pi_tis_id);

    l_sql :=
    ' select  tid_row_id
            , col01
            , col02
            , col03
            , col04
            , col05
            , col06
            , col07
            , col08
            , col09
            , col10
            , col11
            , col12
            , col13
            , col14
            , col15
            , col16
            , col17
            , col18
            , col19
            , col20
            , col21
            , col22
            , col23
            , col24
            , col25
            , col26
            , col27
            , col28
            , col29
            , col30
            , col31
            , col32
            , col33
            , col34
            , col35
            , col36
            , col37
            , col38
            , col39
            , col40
            , col41
            , col42
            , col43
            , col44
            , col45
            , nvl(faulty,0) as faulty
            , annotation
            , validation
        from (
        select tid_text
             , tid_row_id 
             , case when tph_hea_id not in (9998,9999,9996)  then
                tph_hea_id || ROW_NUMBER() OVER (PARTITION BY tid_row_id ORDER BY tid_id)
                else
                tph_hea_id || ROW_NUMBER() OVER (PARTITION BY tid_row_id ORDER BY tph_sort_order, tid_id) || 00
                end as tph_hea_id
          from template_import_status
          join template_import_data
            on tis_id = tid_tis_id
          join template_header
            on tid_tph_id = tph_id
         where tis_id =  ' || pi_tis_id || '
      ) pivot (
        max(tid_text)
        for tph_hea_id in ( ' || l_pivot_columns || ' )
      ) 
      order by tid_row_id';

    logger.log('SQL: '|| l_sql, l_scope, null, l_params);

    logger.log('END', l_scope);
    return l_sql;
        exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end get_grid_query;


  function get_grid_data (
    pi_tis_id in template_import_status.tis_id%type
  ) return t_grid_tab pipelined
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_grid_data';
    l_params logger.tab_param;

    l_query varchar2(4000 char);

    l_grid_tab t_grid_tab;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    l_query := get_grid_query(pi_tis_id);
    logger.log_info(l_query, l_scope, null, l_params);

    execute immediate l_query
    bulk collect into l_grid_tab;

    for i in 1..l_grid_tab.count
    loop
      pipe row(l_grid_tab(i));
    end loop;

    logger.log('END', l_scope);
  end get_grid_data;


  procedure update_answer_status (
    pi_tis_id         in template_import_status.tis_id%type
  , pi_tid_row_id     in template_import_data.tid_row_id%type
  , pi_annotation     in template_import_data.tid_text%type
  , pi_faulty         in template_import_data.tid_text%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'update_answer_status';
    l_params logger.tab_param;

    l_tpl_id r_templates.tpl_id%type;

    l_count             pls_integer;
    l_annotation_id     r_header.hea_id%type := 9998;
    l_faulty_id         r_header.hea_id%type := 9999;
    l_validation_id     r_header.hea_id%type := 9996;

    l_annotation_tph_id  template_header.tph_id%type;
    l_faulty_tph_id      template_header.tph_id%type;
    l_validation_tph_id  template_header.tph_id%type;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.append_param(l_params, 'pi_tid_row_id', pi_tid_row_id);
    logger.append_param(l_params, 'pi_annotation', pi_annotation);
    logger.append_param(l_params, 'pi_faulty', pi_faulty);
    logger.log('START', l_scope, null, l_params);

    select tis_tpl_id
      into l_tpl_id
      from template_import_status
     where tis_id = pi_tis_id
    ;

    -- check if annotation and faulty are already in abfrage
    select count(*)
      into l_count
      from template_header
     where tph_hea_id = l_annotation_id
       and tph_tpl_id = l_tpl_id
    ;

    if l_count = 0 then
      insert into template_header
        (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
      values
        (l_tpl_id, l_annotation_id, 'ff4000', 'ff000000', 280)
      returning tph_id into l_annotation_tph_id;
    else
      select tph_id
        into l_annotation_tph_id
        from template_header
       where tph_hea_id = l_annotation_id
         and tph_tpl_id = l_tpl_id
      ;
    end if;

    select count(*)
      into l_count
      from template_header
     where tph_hea_id = l_faulty_id
       and tph_tpl_id = l_tpl_id
    ;

    if l_count = 0 then
      insert into template_header
        (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
      values
        (l_tpl_id, l_faulty_id, 'ff4000', 'ff000000', 281)
      returning tph_id into l_faulty_tph_id;
    else
      select tph_id
        into l_faulty_tph_id
        from template_header
       where tph_hea_id = l_faulty_id
         and tph_tpl_id = l_tpl_id
       ;
    end if;

    select count(*)
      into l_count
      from template_header
     where tph_hea_id = l_validation_id
       and tph_tpl_id = l_tpl_id
    ;

    if l_count = 0 then
      insert into template_header
        (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
      values
        (l_tpl_id, l_validation_id, 'ff4000', 'ff000000', 281)
      returning tph_id into l_validation_tph_id;
    else
      select tph_id
        into l_validation_tph_id
        from template_header
       where tph_hea_id = l_validation_id
         and tph_tpl_id = l_tpl_id
       ;
    end if;

    -- merge annotation
    -- merge because it's unknown if there already exists an answer for that
    merge into template_import_data dest
      using (
        select pi_annotation       as tid_text
             , pi_tis_id          as tid_tis_id
             , l_annotation_tph_id as tid_tph_id
             , pi_tid_row_id      as tid_row_id
          from dual
      ) src
      on (
            dest.tid_tis_id = src.tid_tis_id
        and dest.tid_row_id = src.tid_row_id
        and dest.tid_tph_id = src.tid_tph_id
      )
      when matched then
        update
          set dest.tid_text = src.tid_text
      when not matched then
         insert (dest.tid_tis_id, dest.tid_row_id, dest.tid_tph_id, dest.tid_text)
         values (src.tid_tis_id, src.tid_row_id, src.tid_tph_id, src.tid_text)
      ;

    -- merge faulty
    -- merge because it's unknown if there already exists an answer for that
    merge into template_import_data dest
      using (
        select pi_faulty       as tid_text              
             , pi_tis_id           as tid_tis_id
             , l_faulty_tph_id as tid_tph_id
             , pi_tid_row_id       as tid_row_id
          from dual
      ) src
      on (
            dest.tid_tis_id = src.tid_tis_id
        and dest.tid_row_id = src.tid_row_id
        and dest.tid_tph_id = src.tid_tph_id
      )
      when matched then
        update
          set dest.tid_text = src.tid_text 
      when not matched then
         insert (dest.tid_tis_id, dest.tid_row_id, dest.tid_tph_id, dest.tid_text)
         values (src.tid_tis_id, src.tid_row_id, src.tid_tph_id, src.tid_text)
      ;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end update_answer_status;

  procedure update_answer(
    pi_tid_text_array in t_tid_text_array
  , pi_tid_row_id     in template_import_data.tid_row_id%type
  , pi_tis_id         in template_import_data.tid_tis_id%type
  )
  as
    l_tpl_id r_templates.tpl_id%type;
    l_hea_id r_header.hea_id%type; 
    l_tph_id template_header.tph_id%type;

    l_hea_text_array t_hea_text_array;

    l_scope  logger_logs.scope%type := gc_scope_prefix || 'update_answer';
    l_params logger.tab_param;

    l_rownum pls_integer := 0; 
  begin
    logger.append_param(l_params, 'pi_tid_row_id', pi_tid_row_id);
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    -- get umfrage
    select tis_tpl_id
      into l_tpl_id
      from template_import_status
     where tis_id = pi_tis_id;

    -- get headers
    select text bulk collect
    into l_hea_text_array
    from
    (
      select hea_text as text, tis_id
      from template_import_status
      join template_header
      on tis_tpl_id = tph_tpl_id
      join r_header
      on tph_hea_id = hea_id
      order by tph_sort_order
    )
    where tis_id = pi_tis_id;

    -- update columns
    for counter in 1..l_hea_text_array.count
    loop
      l_rownum := l_rownum +1;
      -- get abfrage
      select hea_id  
      into l_hea_id
      from r_header
      where hea_text = l_hea_text_array(counter);

      if l_hea_id not in (9999, 9998, 9996)
      then
          -- get umfrage_abfrage
          select tph_id
          into l_tph_id
          from template_header
          where tph_tpl_id = l_tpl_id
          and tph_hea_id = l_hea_id
          and tph_sort_order = l_rownum;

          -- update row
          update template_import_data
          set  tid_text = pi_tid_text_array(counter)
          where tid_row_id = pi_tid_row_id
          and tid_tph_id = l_tph_id;

      end if;

    end loop;

  end update_answer;

  procedure insert_answer(
    pi_tid_text_array in t_tid_text_array
  , pi_annotation     in template_import_data.tid_text%type
  , pi_faulty         in template_import_data.tid_text%type
  , pi_tis_id         in template_import_data.tid_tis_id%type
  )
  as
    l_tid_row_id     template_import_data.tid_row_id%type;

    l_tpl_id r_templates.tpl_id%type;
    l_hea_id r_header.hea_id%type; 
    l_tph_id template_header.tph_id%type;

    l_hea_text_array t_hea_text_array;

    l_rownum pls_integer := 0; 
  begin

    -- get umfrage
    select tis_tpl_id
    into l_tpl_id
    from template_import_status
    where tis_id = pi_tis_id;

    -- get headers
    select text bulk collect
    into l_hea_text_array
    from
    (
      select hea_text as text, tis_id
      from template_import_status
      join template_header
      on tis_tpl_id = tph_tpl_id
      join r_header
      on tph_hea_id = hea_id
      order by tph_sort_order
    )
    where tis_id = pi_tis_id;

    l_tid_row_id := tid_row_seq.nextval;

    -- insert columns
    for counter in 1..l_hea_text_array.count
    loop
      l_rownum := l_rownum +1;

      -- get abfrage
      select hea_id
      into l_hea_id
      from r_header
      where hea_text = l_hea_text_array(counter);

      if l_hea_id not in (9999,9998,9996)
      then
        -- get umfrage_abfrage
        select tph_id
        into l_tph_id
        from template_header
        where tph_tpl_id = l_tpl_id
        and tph_hea_id = l_hea_id
        and tph_sort_order = l_rownum;

        -- insert row
        insert into template_import_data (tid_tph_id, tid_text, tid_tis_id, tid_row_id)
        values (l_tph_id, pi_tid_text_array(counter), pi_tis_id, l_tid_row_id);          
      end if;

      -- insert annotation column
      if l_hea_id = 9998 and pi_annotation is not null
      then
          -- get umfrage_abfrage
          select tph_id
          into l_tph_id
          from template_header
          where tph_tpl_id = l_tpl_id
          and tph_hea_id = l_hea_id;

          -- insert row
          insert into template_import_data (tid_tph_id, tid_text, tid_tis_id, tid_row_id)
          values (l_tph_id, pi_annotation, pi_tis_id, l_tid_row_id);     
      end if;

      -- insert faulty column
      if l_hea_id = 9999 and pi_faulty is not null
      then
        -- get umfrage_abfrage
        select tph_id
        into l_tph_id
        from template_header
        where tph_tpl_id = l_tpl_id
        and tph_hea_id = l_hea_id;

        -- insert row
        insert into template_import_data (tid_tph_id, tid_text, tid_tis_id, tid_row_id)
          values (l_tph_id, pi_faulty, pi_tis_id, l_tid_row_id);      
      end if;   

  end loop;

  end insert_answer;

  procedure delete_answer (
    pi_tis_id     in template_import_status.tis_id%type
  , pi_tid_row_id in template_import_data.tid_row_id%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'delete_answer';
    l_params logger.tab_param;
    type NumberArray is table of number index by binary_integer;
    tid_array NumberArray;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.append_param(l_params, 'pi_tid_row_id', pi_tid_row_id);
    logger.log('START', l_scope, null, l_params);

    Select tid_id bulk collect
      into tid_array 
      from template_import_data
     where tid_tis_id = pi_tis_id
       and tid_row_id = pi_tid_row_id;

    FOR i IN tid_array.FIRST..tid_array.LAST LOOP
       delete from template_import_data where tid_id = tid_array(i);
    END LOOP;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end delete_answer;

  function get_column_count(
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_column_count';
    l_params logger.tab_param;

    l_tph_tpl_id template_header.tph_tpl_id%type;
    l_count number;

    l_annotation_id  r_header.hea_id%type := 9998;
    l_faulty_id r_header.hea_id%type := 9999;
    l_validation_id r_header.hea_id%type := 9996;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    select count(*)
      into l_count
      from template_header
      join template_import_status
        on tph_tpl_id = tis_tpl_id
     where tis_id = pi_tis_id
       and tph_hea_id not in (l_annotation_id, l_faulty_id, l_validation_id);

    logger.log('END', l_scope);
    return l_count;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_column_count;

end p00051_api;
/