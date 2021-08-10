CREATE OR REPLACE FORCE VIEW "P00030_VW" ("TIS_ID", "TPL_ID", "PER_ID", "PER_NAME", "PER_EMAIL", "TIS_STS_ID", "FIL_ID", "FIL_FILENAME", "FIL_MIMETYPE", "FILE_LENGTH", "TIS_DEADLINE", "TIS_ANNOTATION", "TIS_FIL_ID", "TIS_SHIPPING_STATUS") AS 
  select tis_id
       , tpl_id
       , per_id
       , per_firstname || ' ' || per_lastname as per_name
       , per_email
       , tis_sts_id
       , fil_id
       , fil_filename
       , fil_mimetype
       , dbms_lob.getlength(fil_file) as file_length
       , tis_deadline
       , tis_annotation
       , tis_fil_id
       , tis_shipping_status
    from template_import_status
    join r_person
      on tis_per_id = per_id
    join r_templates
      on tis_tpl_id = tpl_id
    left join files
      on tis_fil_id = fil_id;
/