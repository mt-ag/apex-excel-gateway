create or replace package body email_pkg
as

 gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';
 
  procedure new_template(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'new_template';
    l_params      logger.tab_param;

    l_id          number;
    l_context      apex_exec.t_context;    
    l_emails_idx   pls_integer;
    l_names_ids    pls_integer;
    l_deadline_ids pls_integer;
    l_note_ids     pls_integer;
    l_status_ids   pls_integer;
    l_tpl_ids      pls_integer;
    l_tis_ids      pls_integer;
    l_per_ids      pls_integer;
    l_region_id    number;    
    l_deadline     varchar2(20 char);

    l_count_recipient number := 0;
  begin
      logger.log('START', l_scope, null, l_params);

      -- Get the region id for the CUSTOMERS IR region
      select region_id
        into l_region_id
        from apex_application_page_regions
       where application_id = p_App_ID
         and page_id        = p_Page_ID
         and static_id      = p_static_id;

      -- Get the query context for the New Contracts IG Region
      l_context := apex_region.open_query_context (
                          p_page_id => p_Page_ID,
                          p_region_id => l_region_id );

      -- Get the column positions for columns
      l_emails_idx    := apex_exec.get_column_position( l_context, 'PER_EMAIL' );
      l_names_ids     := apex_exec.get_column_position( l_context, 'PER_NAME' );
      l_deadline_ids  := apex_exec.get_column_position( l_context, 'TIS_DEADLINE' );
      l_note_ids      := apex_exec.get_column_position( l_context, 'TIS_ANNOTATION' );
      l_status_ids    := apex_exec.get_column_position( l_context, 'TIS_STS_ID' );
      l_tpl_ids       := apex_exec.get_column_position( l_context, 'TPL_ID' );
      l_per_ids       := apex_exec.get_column_position( l_context, 'PER_ID' );
      l_tis_ids       := apex_exec.get_column_position( l_context, 'TIS_ID' );

      -- Loop throught the query of the context
      while apex_exec.next_row( l_context ) loop        

          -- generate Excel template
          p00030_api.generate_excel_file ( 
            pi_tpl_id => apex_exec.get_number( l_context, l_tpl_ids )
          , pi_per_id => apex_exec.get_number( l_context, l_per_ids )
          );          

          select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
            into l_deadline
            from r_templates 
           where tpl_id = apex_exec.get_number( l_context, l_tpl_ids );
         
          -- prepare Email
          l_id := apex_mail.send (
          p_to                 => apex_exec.get_varchar2( l_context, l_emails_idx ),
          p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
          p_template_static_id => 'NEWTEMPLATE',
          p_placeholders       => '{' ||
          '    "CONTACT_PERSON":'      || apex_json.stringify( apex_exec.get_varchar2( l_context, l_names_ids )) ||
          '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
          '   ,"NOTES":'               || apex_json.stringify( case when apex_exec.get_varchar2( l_context, l_note_ids ) is null then 'No comments' else apex_exec.get_varchar2( l_context, l_note_ids ) end ) ||
          '}' 
          );

          -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
          for rec in (
            select fil_file, fil_filename, fil_mimetype from files
              join template_import_status on fil_id = tis_fil_id
             where tis_id = apex_exec.get_number( l_context, l_tis_ids ))
          loop

          apex_mail.add_attachment(
            p_mail_id    => l_id,
            p_attachment => rec.fil_file,
            p_filename   => rec.fil_filename,
            p_mime_type  => rec.fil_mimetype);

          -- set new deadline
          update (
              select tis_deadline from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) tis
          set tis.tis_deadline = sysdate + (select tpl_deadline from r_templates where tpl_id = apex_exec.get_number( l_context, l_tpl_ids ));
          
          -- Versandstatus setzen - Umfrage versandt
          update (
              select tis_shipping_status from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) pss
          set pss.tis_shipping_status = 2;

          --Excel-Sheet leeren
          update (
                select fil_file from files
                join template_import_status on fil_id = tis_fil_id
                where tis_id = apex_exec.get_number( l_context, l_tis_ids )) fil
          set fil.fil_file = empty_blob();

          end loop;

          -- Logo hinzufügen
          FOR img IN(
              SELECT
                  filename
                  ,blob_content
                  ,mime_type
              FROM
                  apex_application_files
              WHERE
                  filename = 'Logo.png'
                  AND flow_id = p_App_ID
          )LOOP
              apex_mail.add_attachment(
                  p_mail_id      => l_id
                  ,p_attachment   => img.blob_content
                  ,p_filename     => img.filename
                  ,p_mime_type    => img.mime_type
              );
          END LOOP;  

        -- Mail senden
        apex_mail.push_queue;     

        -- Anzahl Empfänger zählen
        l_count_recipient := l_count_recipient+1;
      end loop;

      apex_exec.close( l_context );      

      if l_count_recipient = 0 then
        raise value_error;
      end if;

  exception
      when value_error then
      if l_count_recipient = 0 then
          raise_application_error(-20000,'No email recipients found!');
      end if; 
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
          apex_exec.close( l_context );
      raise; 
  end new_template;
  
  procedure new_template_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type   
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'new_template_automation';
    l_params      logger.tab_param;
    l_deadline    varchar2(20 char);    
    l_id          number;  
  begin
      logger.append_param(l_params, 'p_tis_id', p_tis_id);
      logger.append_param(l_params, 'p_tis_annotation', p_tis_annotation);
      logger.append_param(l_params, 'p_per_id', p_per_id);
      logger.append_param(l_params, 'p_per_name', p_per_name);
      logger.append_param(l_params, 'p_per_email', p_per_email);
      logger.append_param(l_params, 'p_tpl_id', p_tpl_id);
      logger.log('START', l_scope, null, l_params);

      -- generate Excel template
      p00030_api.generate_excel_file ( 
        pi_tpl_id => p_tpl_id
      , pi_per_id => p_per_id
      );          

      select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
        into l_deadline
        from r_templates 
       where tpl_id = p_tpl_id;
      
      -- prepare Email
      l_id := apex_mail.send (
      p_to                 => p_per_email,
      p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
      p_template_static_id => 'NEWTEMPLATE',
      p_placeholders       => '{' ||
      '    "CONTACT_PERSON":'      || apex_json.stringify( p_per_name ) ||
      '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
      '   ,"NOTES":'               || apex_json.stringify( case when p_tis_annotation is null then 'No comments' else p_tis_annotation end ) ||
      '}' 
      );

      -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
      for rec in (
        select fil_file, fil_filename, fil_mimetype from files
          join template_import_status on fil_id = tis_fil_id
         where tis_id = p_tis_id)
      loop

      apex_mail.add_attachment(
        p_mail_id    => l_id,
        p_attachment => rec.fil_file,
        p_filename   => rec.fil_filename,
        p_mime_type  => rec.fil_mimetype);
      
      logger.log('HIER 1');  
      -- set new deadline
      update template_import_status  
         set tis_deadline = l_deadline
       where tis_id = p_tis_id;
      logger.log('HIER 2');
      -- Versandstatus setzen - Umfrage versandt
      update template_import_status
         set tis_shipping_status = 2
       where tis_id = p_tis_id;
      logger.log('HIER 3');  
      --Excel-Sheet leeren
      update (
            select fil_file from files
            join template_import_status on fil_id = tis_fil_id
            where tis_id = p_tis_id) fil
      set fil.fil_file = empty_blob();

      end loop;

      -- Logo hinzufügen
      FOR img IN(
          SELECT
              filename
              ,blob_content
              ,mime_type
          FROM
              apex_application_files
          WHERE
              filename = 'Logo.png'
              AND flow_id = v('APP_ID')
      )LOOP
          apex_mail.add_attachment(
              p_mail_id      => l_id
              ,p_attachment   => img.blob_content
              ,p_filename     => img.filename
              ,p_mime_type    => img.mime_type
          );
      END LOOP;  

      -- Mail senden
      apex_mail.push_queue;    

  exception
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise; 
  end new_template_automation;

  PROCEDURE corrected_template(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'corrected_template';
    l_params      logger.tab_param;

    l_id          number;
    l_context     apex_exec.t_context;    
    l_emails_idx   pls_integer;
    l_names_ids    pls_integer;
    l_deadline_ids pls_integer;
    l_note_ids     pls_integer;
    l_status_ids   pls_integer;
    l_tpl_ids      pls_integer;
    l_tis_ids      pls_integer;
    l_per_ids      pls_integer;
    l_region_id    number;    
    l_deadline     varchar2(20 char);

    l_count_recipient number := 0;
  begin
      logger.log('START', l_scope, null, l_params);

      -- Get the region id for the CUSTOMERS IR region
      select region_id
        into l_region_id
        from apex_application_page_regions
       where application_id = p_App_ID
         and page_id        = p_Page_ID
         and static_id      = p_static_id;

      -- Get the query context for the New Contracts IG Region
      l_context := apex_region.open_query_context (
                          p_page_id => p_Page_ID,
                          p_region_id => l_region_id );

      -- Get the column positions for columns
      l_emails_idx    := apex_exec.get_column_position( l_context, 'PER_EMAIL' );
      l_names_ids     := apex_exec.get_column_position( l_context, 'PER_NAME' );
      l_deadline_ids  := apex_exec.get_column_position( l_context, 'TIS_DEADLINE' );
      l_note_ids      := apex_exec.get_column_position( l_context, 'TIS_ANNOTATION' );
      l_status_ids    := apex_exec.get_column_position( l_context, 'TIS_STS_ID' );
      l_tpl_ids       := apex_exec.get_column_position( l_context, 'TPL_ID' );
      l_per_ids       := apex_exec.get_column_position( l_context, 'PER_ID' );
      l_tis_ids       := apex_exec.get_column_position( l_context, 'TIS_ID' );

      -- Loop throught the query of the context
      while apex_exec.next_row( l_context ) loop        
          --l_deadline := apex_exec.get_varchar2( l_context, l_deadline_ids );
          --l_deadline := to_char(to_date(l_deadline)+14,'dd.mm.yyyy');
          
          select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
            into l_deadline
            from r_templates 
           where tpl_id = apex_exec.get_number( l_context, l_tpl_ids );

          -- Mail vorbereiten
          l_id := apex_mail.send (
          p_to                 => apex_exec.get_varchar2( l_context, l_emails_idx ),
          p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
          p_template_static_id => 'CORRECTION',
          p_placeholders       => '{' ||
          '    "CONTACT_PERSON":'      || apex_json.stringify( apex_exec.get_varchar2( l_context, l_names_ids )) ||
          '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
          '   ,"NOTES":'               || apex_json.stringify( case when apex_exec.get_varchar2( l_context, l_note_ids ) is null then 'No comments' else apex_exec.get_varchar2( l_context, l_note_ids ) end ) ||
          '}' 
          );

          -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
          for rec in (
            select fil_file, fil_filename, fil_mimetype from files
              join template_import_status on fil_id = tis_fil_id
             where tis_id = apex_exec.get_number( l_context, l_tis_ids )) 
          loop

          apex_mail.add_attachment(
            p_mail_id    => l_id,
            p_attachment => rec.fil_file,
            p_filename   => rec.fil_filename,
            p_mime_type  => rec.fil_mimetype);


          -- set new deadline
          update (
              select tis_deadline from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) tis
          set tis.tis_deadline = sysdate + (select tpl_deadline from r_templates where tpl_id = apex_exec.get_number( l_context, l_tpl_ids ));  


          -- Versandstatus setzen - Umfrage versandt
          update (
              select tis_shipping_status from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) pss
          set pss.tis_shipping_status = 3;

          --Excel-Sheet leeren
          update (
                select fil_file from files
                join template_import_status on fil_id = tis_fil_id
                where tis_id = apex_exec.get_number( l_context, l_tis_ids )) fil
          set fil.fil_file = empty_blob();

          end loop;
          
          -- Logo hinzufügen
          FOR img IN(
              SELECT
                  filename
                  ,blob_content
                  ,mime_type
              FROM
                  apex_application_files
              WHERE
                  filename = 'Logo.png'
                  AND flow_id = p_App_ID
          )LOOP
              apex_mail.add_attachment(
                  p_mail_id      => l_id
                  ,p_attachment   => img.blob_content
                  ,p_filename     => img.filename
                  ,p_mime_type    => img.mime_type
              );
          END LOOP; 

        -- Mail senden
        apex_mail.push_queue;        

        -- Anzahl Empfänger zählen
        l_count_recipient := l_count_recipient+1;
      end loop;

      apex_exec.close( l_context );      

      if l_count_recipient = 0 then
        raise value_error;
      end if;

  exception
      when value_error then
      if l_count_recipient = 0 then
          raise_application_error(-20000,'No email recipients found!');
      end if; 
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
          apex_exec.close( l_context );
      raise; 
  end corrected_template;
  
  procedure corrected_template_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type   
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'corrected_template_automation';
    l_params      logger.tab_param;
    l_deadline    varchar2(20 char);    
    l_id          number;  
  begin
      logger.append_param(l_params, 'p_tis_id', p_tis_id);
      logger.append_param(l_params, 'p_tis_annotation', p_tis_annotation);
      logger.append_param(l_params, 'p_per_id', p_per_id);
      logger.append_param(l_params, 'p_per_name', p_per_name);
      logger.append_param(l_params, 'p_per_email', p_per_email);
      logger.append_param(l_params, 'p_tpl_id', p_tpl_id);
      logger.log('START', l_scope, null, l_params);

      select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
        into l_deadline
        from r_templates 
       where tpl_id = p_tpl_id;
      
      -- prepare Email
      l_id := apex_mail.send (
      p_to                 => p_per_email,
      p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
      p_template_static_id => 'CORRECTION',
      p_placeholders       => '{' ||
      '    "CONTACT_PERSON":'      || apex_json.stringify( p_per_name ) ||
      '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
      '   ,"NOTES":'               || apex_json.stringify( case when p_tis_annotation is null then 'No comments' else p_tis_annotation end ) ||
      '}' 
      );

      -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
      for rec in (
        select fil_file, fil_filename, fil_mimetype from files
          join template_import_status on fil_id = tis_fil_id
         where tis_id = p_tis_id)
      loop

      apex_mail.add_attachment(
        p_mail_id    => l_id,
        p_attachment => rec.fil_file,
        p_filename   => rec.fil_filename,
        p_mime_type  => rec.fil_mimetype);
      
      -- set new deadline
      update template_import_status  
         set tis_deadline = l_deadline
       where tis_id = p_tis_id;

      -- Versandstatus setzen - Umfrage versandt
      update template_import_status
         set tis_shipping_status = 3
       where tis_id = p_tis_id;
 
      --Excel-Sheet leeren
      update (
            select fil_file from files
            join template_import_status on fil_id = tis_fil_id
            where tis_id = p_tis_id) fil
      set fil.fil_file = empty_blob();

      end loop;

      -- Logo hinzufügen
      FOR img IN(
          SELECT
              filename
              ,blob_content
              ,mime_type
          FROM
              apex_application_files
          WHERE
              filename = 'Logo.png'
              AND flow_id = v('APP_ID')
      )LOOP
          apex_mail.add_attachment(
              p_mail_id      => l_id
              ,p_attachment   => img.blob_content
              ,p_filename     => img.filename
              ,p_mime_type    => img.mime_type
          );
      END LOOP;  

      -- Mail senden
      apex_mail.push_queue;    

  exception
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise; 
  end corrected_template_automation;

procedure reminder(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'reminder';
    l_params      logger.tab_param;

    l_id          number;
    l_context     apex_exec.t_context;    
    l_emails_idx   pls_integer;
    l_names_ids    pls_integer;
    l_deadline_ids pls_integer;
    l_note_ids     pls_integer;
    l_status_ids   pls_integer;
    l_tpl_ids      pls_integer;
    l_tis_ids      pls_integer;
    l_per_ids      pls_integer;
    l_aspkvids     pls_integer;
    l_region_id    number;    
    l_deadline     varchar2(20 char);

    l_count_recipient number := 0;
  begin
      logger.log('START', l_scope, null, l_params);

      -- Get the region id for the CUSTOMERS IR region
      select region_id
        into l_region_id
        from apex_application_page_regions
       where application_id = p_App_ID
         and page_id        = p_Page_ID
         and static_id      = p_static_id;

      -- Get the query context for the New Contracts IG Region
      l_context := apex_region.open_query_context (
                          p_page_id => p_Page_ID,
                          p_region_id => l_region_id );

      -- Get the column positions for columns
      l_emails_idx    := apex_exec.get_column_position( l_context, 'PER_EMAIL' );
      l_names_ids     := apex_exec.get_column_position( l_context, 'PER_NAME' );
      l_deadline_ids  := apex_exec.get_column_position( l_context, 'TIS_DEADLINE' );
      l_note_ids      := apex_exec.get_column_position( l_context, 'TIS_ANNOTATION' );
      l_status_ids    := apex_exec.get_column_position( l_context, 'TIS_STS_ID' );
      l_tpl_ids       := apex_exec.get_column_position( l_context, 'TPL_ID' );
      l_per_ids       := apex_exec.get_column_position( l_context, 'PER_ID' );
      l_tis_ids       := apex_exec.get_column_position( l_context, 'TIS_ID' );

      -- Loop throught the query of the context
      while apex_exec.next_row( l_context ) loop        

          -- Excel Umfragen erstellen          
          p00030_api.generate_excel_file ( 
            pi_tpl_id => apex_exec.get_number( l_context, l_tpl_ids )
          , pi_per_id => apex_exec.get_number( l_context, l_per_ids )
          ); 

          select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
            into l_deadline
            from r_templates 
           where tpl_id = apex_exec.get_number( l_context, l_tpl_ids );

          -- Mail vorbereiten
          l_id := apex_mail.send (
          p_to                 => apex_exec.get_varchar2( l_context, l_emails_idx ),
          p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
          p_template_static_id => 'REMINDER',
          p_placeholders       => '{' ||
          '    "CONTACT_PERSON":'      || apex_json.stringify( apex_exec.get_varchar2( l_context, l_names_ids )) ||
          '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
          '   ,"NOTES":'               || apex_json.stringify( case when apex_exec.get_varchar2( l_context, l_note_ids ) is null then 'No comments' else apex_exec.get_varchar2( l_context, l_note_ids ) end ) ||
          '}' 
          );

          -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
          for rec in (
            select fil_file, fil_filename, fil_mimetype from files
              join template_import_status on fil_id = tis_fil_id
             where tis_id = apex_exec.get_number( l_context, l_tis_ids ))
          loop

          apex_mail.add_attachment(
            p_mail_id    => l_id,
            p_attachment => rec.fil_file,
            p_filename   => rec.fil_filename,
            p_mime_type  => rec.fil_mimetype);


          -- set new deadline
          update (
              select tis_deadline from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) tis
          set tis.tis_deadline = sysdate + (select tpl_deadline from r_templates where tpl_id = apex_exec.get_number( l_context, l_tpl_ids ));


          -- Versandstatus setzen - Umfrage versandt
          update (
              select tis_shipping_status from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) pss
          set pss.tis_shipping_status = 4;

          --Excel-Sheet leeren
          update (
                select fil_file from files
                join template_import_status on fil_id = tis_fil_id
                where tis_id = apex_exec.get_number( l_context, l_tis_ids )) fil
          set fil.fil_file = empty_blob();

          end loop;
          
          -- Logo hinzufügen
          FOR img IN(
              SELECT
                  filename
                  ,blob_content
                  ,mime_type
              FROM
                  apex_application_files
              WHERE
                  filename = 'Logo.png'
                  AND flow_id = v('APP_ID')
          )LOOP
              apex_mail.add_attachment(
                  p_mail_id      => l_id
                  ,p_attachment   => img.blob_content
                  ,p_filename     => img.filename
                  ,p_mime_type    => img.mime_type
              );
          END LOOP;

        -- Mail senden
        apex_mail.push_queue;        

        -- Anzahl Empfänger zählen
        l_count_recipient := l_count_recipient+1;
      end loop;

      apex_exec.close( l_context );      

      if l_count_recipient = 0 then
        raise value_error;
      end if;

  exception
      when value_error then
      if l_count_recipient = 0 then
          raise_application_error(-20000,'No email recipients found!');
      end if; 
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
          apex_exec.close( l_context );
      raise; 
  end reminder;
  
  procedure reminder_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type   
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'reminder_automation';
    l_params      logger.tab_param;
    l_deadline    varchar2(20 char);    
    l_id          number;  
  begin
      logger.append_param(l_params, 'p_tis_id', p_tis_id);
      logger.append_param(l_params, 'p_tis_annotation', p_tis_annotation);
      logger.append_param(l_params, 'p_per_id', p_per_id);
      logger.append_param(l_params, 'p_per_name', p_per_name);
      logger.append_param(l_params, 'p_per_email', p_per_email);
      logger.append_param(l_params, 'p_tpl_id', p_tpl_id);
      logger.log('START', l_scope, null, l_params);

      -- generate Excel template
      p00030_api.generate_excel_file ( 
        pi_tpl_id => p_tpl_id
      , pi_per_id => p_per_id
      );          

      select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
        into l_deadline
        from r_templates 
       where tpl_id = p_tpl_id;
      
      -- prepare Email
      l_id := apex_mail.send (
      p_to                 => p_per_email,
      p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
      p_template_static_id => 'REMINDER',
      p_placeholders       => '{' ||
      '    "CONTACT_PERSON":'      || apex_json.stringify( p_per_name ) ||
      '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
      '   ,"NOTES":'               || apex_json.stringify( case when p_tis_annotation is null then 'No comments' else p_tis_annotation end ) ||
      '}' 
      );

      -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
      for rec in (
        select fil_file, fil_filename, fil_mimetype from files
          join template_import_status on fil_id = tis_fil_id
         where tis_id = p_tis_id)
      loop

      apex_mail.add_attachment(
        p_mail_id    => l_id,
        p_attachment => rec.fil_file,
        p_filename   => rec.fil_filename,
        p_mime_type  => rec.fil_mimetype);
      
      -- set new deadline
      update template_import_status  
         set tis_deadline = l_deadline
       where tis_id = p_tis_id;
      
      -- Versandstatus setzen - Umfrage versandt
      update template_import_status
         set tis_shipping_status = 4
       where tis_id = p_tis_id;
      
      --Excel-Sheet leeren
      update (
            select fil_file from files
            join template_import_status on fil_id = tis_fil_id
            where tis_id = p_tis_id) fil
      set fil.fil_file = empty_blob();

      end loop;

      -- Logo hinzufügen
      FOR img IN(
          SELECT
              filename
              ,blob_content
              ,mime_type
          FROM
              apex_application_files
          WHERE
              filename = 'Logo.png'
              AND flow_id = v('APP_ID')
      )LOOP
          apex_mail.add_attachment(
              p_mail_id      => l_id
              ,p_attachment   => img.blob_content
              ,p_filename     => img.filename
              ,p_mime_type    => img.mime_type
          );
      END LOOP;  

      -- Mail senden
      apex_mail.push_queue;    

  exception
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise; 
  end reminder_automation;

end email_pkg;
/