create or replace package body validation_api
as 

    gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

 function validate_data(
    p_tid_text      template_import_data.tid_text%type,
    p_val_text      r_validation.val_text%type
 ) return boolean
 as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'validate_data';
    l_params logger.tab_param;
    
    l_validate_data boolean default false;
    l_email_count   pls_integer;
 begin
    logger.append_param(l_params, 'p_tid_text', p_tid_text);
    logger.append_param(l_params, 'p_val_text', p_val_text);
    logger.log('START', l_scope, null, l_params);
       
    -- check number validation
    if VALIDATE_CONVERSION(p_tid_text AS NUMBER) = 0 and p_val_text = 'number' then            
        l_validate_data := true;               
    -- check date validation
    elsif VALIDATE_CONVERSION(p_tid_text AS DATE, 'yyyy-mm-dd') = 0 and p_val_text = 'date' then            
        l_validate_data := true;
    -- check email validation
    elsif p_val_text = 'email' then           
        select count(column_value) 
          into l_email_count
          from table(apex_string_util.find_email_addresses(p_tid_text));

        if l_email_count = 0 then                  
            l_validate_data := true;
        end if;
    end if;
    
    logger.log('Return -> ' || logger.tochar(l_validate_data), l_scope);
    return l_validate_data;
    
    logger.log('END', l_scope);
 exception
   when others then
     logger.log_error('Unhandled Exception', l_scope, null, l_params);
     raise;
 end validate_data;   
 
 procedure validation (
      p_tis_id in template_import_status.tis_id%type
 )
 as
        l_scope  logger_logs.scope%type := gc_scope_prefix || 'validation';
        l_params logger.tab_param;

        l_count                  pls_integer;
        l_email_count            pls_integer;
        l_is_unique              pls_integer;
        l_validate_data          boolean;
        l_tis_tpl_id             template_import_status.tis_tpl_id%type;

        l_annotation_id          r_header.hea_id%type := 9998;
        l_faulty_id              r_header.hea_id%type := 9999;
        l_validation_id          r_header.hea_id%type := 9996;

        l_annotation_tph_id      template_header.tph_id%type;
        l_faulty_tph_id          template_header.tph_id%type;
        l_validation_tph_id      template_header.tph_id%type;         
 begin
        logger.append_param(l_params, 'p_tis_id', p_tis_id);
        logger.log('START', l_scope, null, l_params);

        select tis_tpl_id 
          into l_tis_tpl_id
          from template_import_status
         where tis_id = p_tis_id; 

        -- Set Faulty to 0 where is no annotation
        for rec in (
            select tid_row_id, tid_tph_id, tid_text  
              from template_import_data sva
             where tid_tis_id = p_tis_id 
               and tid_row_id in (select tid_row_id from template_import_data where tid_val_id > 0)
               and tid_tph_id in (select tph_id from template_header where tph_hea_id in (l_faulty_id, l_annotation_id) and tph_tpl_id = l_tis_tpl_id)
               and trim(both from tid_text) is null
        )
        loop
            update template_import_data
               set tid_text = 0
             where tid_row_id = rec.tid_row_id
               and tid_tph_id = (select tph_id from template_header where tph_hea_id in (l_faulty_id) and tph_tpl_id = l_tis_tpl_id);
        end loop;   

        -- Set Validation to 0
        update template_import_data
           set tid_val_id = 0
         where tid_tis_id = p_tis_id;

        -- reset validation
        for i in ( 
            select distinct tid_tph_id
              from template_import_data 
             where tid_tis_id = p_tis_id 
               and tid_tph_id in (select tph_id from template_header where tph_hea_id in (l_validation_id) and tph_tpl_id = l_tis_tpl_id)
        )
        loop

        update template_import_data
           set tid_text = ''
         where tid_tis_id = p_tis_id
           and tid_tph_id = i.tid_tph_id;

        end loop;

        --Step 1 select data which have to validate
        for i in (
          select  c.tpl_id, e.tid_id, e.tid_text, a.hea_val_id, b.val_text, b.val_message,e.tid_tis_id, d.tph_id, d.tph_hea_id, e.tid_row_id
            from  r_header a,
                  r_validation b,
                  r_templates c,
                  template_header d,
                  template_import_data e         
           where  a.hea_id = d.tph_hea_id 
             and  a.hea_val_id = b.val_id
             and  c.tpl_id = d.tph_tpl_id
             and  d.tph_id = e.tid_tph_id
             and  a.hea_val_id is not null
             and  d.tph_tpl_id = l_tis_tpl_id
        )
        loop
            l_validate_data := false;
            
            -- Check if template header for annotation, faulty and validation exists        
            select count(*)
              into l_count
              from template_header
             where tph_hea_id = l_annotation_id
               and tph_tpl_id = i.tpl_id;

            if l_count = 0 then
              insert into template_header
                (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
              values
                (i.tpl_id, l_annotation_id, 'ff4000', 'ff000000', 280)
              returning tph_id into l_annotation_tph_id;
            else
              select tph_id
                into l_annotation_tph_id
                from template_header
               where tph_hea_id = l_annotation_id
                 and tph_tpl_id = i.tpl_id
              ;
            end if;

            select count(*)
              into l_count
              from template_header
             where tph_hea_id = l_faulty_id
               and tph_tpl_id = i.tpl_id
            ;

            if l_count = 0 then
              insert into template_header
                (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
              values
                (i.tpl_id, l_faulty_id, 'ff4000', 'ff000000', 281)
              returning tph_id into l_faulty_tph_id;
            else
              select tph_id
                into l_faulty_tph_id
                from template_header
               where tph_hea_id = l_faulty_id
                 and tph_tpl_id = i.tpl_id
               ;
            end if; 

            select count(*)
              into l_count
              from template_header
             where tph_hea_id = l_validation_id
               and tph_tpl_id = i.tpl_id
            ;

            if l_count = 0 then
              insert into template_header
                (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
              values
                (i.tpl_id, l_validation_id, 'ff4000', 'ff000000', 282)
              returning tph_id into l_validation_tph_id;
            else
              select tph_id
                into l_validation_tph_id
                from template_header
               where tph_hea_id = l_validation_id
                 and tph_tpl_id = i.tpl_id
               ;
            end if; 

            -- get true if text data is invalid
            l_validate_data := validate_data(i.tid_text, i.val_text);
            
            -- set faulty, annotation and validation data for invalid data
            if l_validate_data = true then

              update template_import_data
                 set tid_val_id = i.hea_val_id
               where tid_tis_id = i.tid_tis_id
                 and tid_row_id = i.tid_row_id
                 and tid_tph_id = i.tph_id;

              select count(distinct template_header.tph_tpl_id)
                into l_count
                from template_header join template_import_data on tph_id = tid_tph_id
               where tph_hea_id = l_faulty_tph_id
                 and tph_hea_id = l_validation_tph_id
                 and tph_hea_id = l_annotation_tph_id
                 and tph_tpl_id = i.tpl_id
                 and tid_tis_id = i.tid_tis_id
                 and tid_row_id = i.tid_row_id
               ;

              if l_count = 0 then

                  select count(*)  
                  into l_is_unique
                  from template_import_data 
                  where tid_tis_id = i.tid_tis_id
                  and   tid_tph_id = l_annotation_tph_id
                  and   tid_row_id = i.tid_row_id;

                  if l_is_unique = 0 then

                  insert into template_import_data (
                    tid_tph_id
                   ,tid_text
                   ,tid_tis_id
                   ,tid_row_id
                   ) values (
                    l_annotation_tph_id
                   ,' '
                   ,i.tid_tis_id
                   ,i.tid_row_id);

                  end if;

                  select count(*)  
                  into l_is_unique
                  from template_import_data 
                  where tid_tis_id = i.tid_tis_id
                  and   tid_tph_id = l_faulty_tph_id
                  and   tid_row_id = i.tid_row_id;

                  if l_is_unique = 0 then

                  insert into template_import_data (
                    tid_tph_id
                   ,tid_text
                   ,tid_tis_id
                   ,tid_row_id
                   ) values (
                    l_faulty_tph_id
                   ,'1'
                   ,i.tid_tis_id
                   ,i.tid_row_id);

                  else

                  update template_import_data 
                  set    tid_text = 1
                  where  tid_tph_id = l_faulty_tph_id
                  and tid_tis_id = i.tid_tis_id
                  and tid_row_id = i.tid_row_id;

                  end if;

                  select count(*)  
                  into l_is_unique
                  from template_import_data 
                  where tid_tis_id = i.tid_tis_id
                  and   tid_tph_id = l_validation_tph_id
                  and   tid_row_id = i.tid_row_id;

                  if l_is_unique = 0 then

                  insert into template_import_data (
                    tid_tph_id
                   ,tid_text
                   ,tid_tis_id
                   ,tid_row_id  
                   ) values (
                    l_validation_tph_id
                   ,i.val_message
                   ,i.tid_tis_id
                   ,i.tid_row_id);

                  else

                  update template_import_data 
                  set    tid_text = tid_text || case when tid_text not like '%' || i.val_message || '%' or tid_text is null then case when tid_text is not null then ', ' end || i.val_message end
                  where  tid_tph_id = l_validation_tph_id
                  and tid_tis_id = i.tid_tis_id
                  and tid_row_id = i.tid_row_id;

                  end if;

              -- Step 1.2.2 Retoure & Anmerkung Antwort aktualisieren
              else 
               for rec2 in (
                 select tid_tph_id 
                   from r_templates c,
                        template_header d,
                        template_import_data e
                  where c.tpl_id = d.tph_tpl_id
                    and d.tph_id = e.tid_tph_id
                    and e.tid_tis_id = i.tid_tis_id
                    and e.tid_row_id = i.tid_row_id
                    and (e.tid_tph_id in (select tph_id from template_header where tph_tpl_id = l_tis_tpl_id and tph_hea_id in (l_validation_id)))
                )
                loop
                    -- Systempruefung schreiben
                    update template_import_data 
                       set tid_text = tid_text || case when tid_text not like '%' || i.val_message || '%' or tid_text is null then case when tid_text is not null then ', ' end || i.val_message end
                     where tid_tph_id = l_validation_tph_id
                       and tid_tis_id = i.tid_tis_id
                       and tid_row_id = i.tid_row_id;
                end loop;
              end if;
            end if;
        end loop;
        
        logger.log('END', l_scope);
    exception
    when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
          raise;
    end validation;

end validation_api;
/