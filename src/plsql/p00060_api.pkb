create or replace package body p00060_api
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
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
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

    l_new_col varchar2(100 char);
    l_pivot_columns varchar2(1000 char) := '';
  begin
    logger.append_param(l_params, 'pi_tis_tpl_id', pi_tis_tpl_id);
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

    for rec in (
      select tph_hea_id, rownum
        from (
          select tph_hea_id
            from template_header
            join r_header
              on tph_hea_id = hea_id
           where tph_tpl_id = pi_tis_tpl_id
             and hea_id not in (l_faulty_id, l_annotation_id, l_validation_id)
           order by tph_sort_order
        )
    )
    loop      
      l_count         := l_count + 1;
      logger.log('l_count: ' || l_count);
      l_new_col       := rec.tph_hea_id || ' as ' || format_colnr(rec.rownum);
      l_pivot_columns := l_pivot_columns || l_new_col  || ', ';
      logger.log('l_pivot_columns: ' || l_pivot_columns);
    end loop;

    -- fill columns to static col count
    l_pivot_columns := l_pivot_columns || fill_columns(l_count + 1);
    
    -- delete last comma
    l_pivot_columns := substr(l_pivot_columns,0,length(l_pivot_columns)-2);

    logger.log('END', l_scope);
    return l_pivot_columns ;
     exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end get_pivot_columns;


  function get_grid_query (
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_grid_query';
    l_params logger.tab_param;

    l_pivot_columns varchar2(1000 char);
    l_sql varchar2(32000 char);
  begin
    logger.append_param(l_params, 'pi_tis_tpl_id', pi_tis_tpl_id);
    logger.log('START', l_scope, null, l_params);

    l_pivot_columns := get_pivot_columns(pi_tis_tpl_id);

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
        from (
        select tid_text
             , tid_row_id 
             , tph_hea_id
          from template_import_status
          join template_import_data
            on tis_id = tid_tis_id
          join template_header
            on tid_tph_id = tph_id
         where tis_sts_id = 3
           and tis_tpl_id =  ' || pi_tis_tpl_id || '
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
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  ) return t_grid_tab pipelined
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_grid_data';
    l_params logger.tab_param;

    l_query varchar2(4000 char);

    l_grid_tab t_grid_tab;
  begin
    logger.append_param(l_params, 'pi_tis_tpl_id', pi_tis_tpl_id);
    logger.log('START', l_scope, null, l_params);

    l_query := get_grid_query(pi_tis_tpl_id);
    logger.log_info(l_query, l_scope, null, l_params);

    execute immediate l_query
    bulk collect into l_grid_tab;

    for i in 1..l_grid_tab.count
    loop
      pipe row(l_grid_tab(i));
    end loop;

    logger.log('END', l_scope);
  end get_grid_data;


  function get_column_count(
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_column_count';
    l_params logger.tab_param;

    l_tph_tpl_id template_header.tph_tpl_id%type;
    l_count number;

    l_annotation_id  r_header.hea_id%type := master_api.get_annotation_id;
    l_faulty_id r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id r_header.hea_id%type := master_api.get_validation_id;
  begin
    logger.append_param(l_params, 'pi_tis_tpl_id', pi_tis_tpl_id);
    logger.log('START', l_scope, null, l_params);

    select count(*)
      into l_count
      from template_header
      join r_templates
        on tph_tpl_id = tpl_id
     where tpl_id = pi_tis_tpl_id
       and tph_hea_id not in (l_annotation_id, l_faulty_id, l_validation_id);

    logger.log('END', l_scope);
    return l_count;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_column_count;

end p00060_api;
/