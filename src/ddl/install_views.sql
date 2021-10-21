CREATE OR REPLACE FORCE VIEW "P00020_VW" ("FIL_ID", "FIL_FILENAME", "FIL_CREATED_ON", "FIL_SESSION", "FILE_LENGTH") AS 
  select fil_id
      , fil_filename
      , fil_created_on
      , fil_session
      , dbms_lob.getlength(fil_file) as file_length
    from files
   where fil_import_export = 0
     and fil_import_completed = 1;
/

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

CREATE OR REPLACE FORCE VIEW "P00042_VW" ("IER_ID", "IER_SESSION", "IER_MESSAGE", "IER_FILENAME", "IER_ROW_ID", "IER_HEADER", "IER_TIMESTAMP") AS 
  select ier_id
       , ier_session
       , ier_message
       , ier_filename
       , ier_row_id
       , ier_header
       , ier_timestamp
    from import_errors;
/

CREATE OR REPLACE FORCE VIEW "P00051_VW" ("TEXT", "TIS_ID") AS 
  SELECT
    SUBSTR(hea_text, 0, 245) AS text, tis_id
FROM
    template_import_status,
    template_header,
    r_header
WHERE
    tis_tpl_id = tph_tpl_id
AND
    tph_hea_id = hea_id
AND
    hea_id not in (9996,9998,9999)
ORDER BY
    tph_sort_order;
/

CREATE OR REPLACE FORCE VIEW "P00060_VW" ("TEXT", "TPL_ID") AS 
  SELECT
    SUBSTR(hea_text, 0, 245) AS text, tpl_id
FROM
    r_templates,
    template_header,
    r_header
WHERE
    tpl_id = tph_tpl_id
AND
    tph_hea_id = hea_id
AND
    hea_id not in (9996,9998,9999)
ORDER BY
    tph_sort_order;
/

CREATE OR REPLACE FORCE VIEW "P01002_VW" ("FIL_ID", "FIL_FILENAME", "FIL_IMPORT_EXPORT", "FIL_IMPORT_COMPLETED", "FIL_CREATED_ON", "FIL_CREATED_BY", "FIL_MODIFIED_ON", "FIL_MODIFIED_BY") AS 
  SELECT
    fil_id,
    fil_filename,
    fil_import_export,
    fil_import_completed,
    fil_created_on,
    fil_created_by,
    fil_modified_on,
    fil_modified_by
FROM
    files;
/

CREATE OR REPLACE FORCE VIEW "P01003_VW" ("HEA_ID", "HEA_TEXT", "HEA_XLSX_WIDTH", "HEA_VAL_ID", "HEA_CREATED_ON", "HEA_CREATED_BY", "HEA_MODIFIED_ON", "HEA_MODIFIED_BY") AS 
  SELECT
    hea_id,
    hea_text,
    hea_xlsx_width,
    hea_val_id,
    hea_created_on,
    hea_created_by,
    hea_modified_on,
    hea_modified_by
FROM
    r_header;
/

CREATE OR REPLACE FORCE VIEW "P01004_VW" ("TIS_ID", "TIS_TPL_ID", "TIS_PER_ID", "TIS_STS_ID", "TIS_FIL_ID", "TIS_ANNOTATION", "TIS_DEADLINE", "TIS_SHIPPING_STATUS", "TIS_INTERNAL_NOTE", "TIS_CREATED_ON", "TIS_CREATED_BY", "TIS_MODIFIED_ON", "TIS_MODIFIED_BY") AS 
  SELECT
    tis_id,
    tis_tpl_id,
    tis_per_id,
    tis_sts_id,
    tis_fil_id,
    tis_annotation,
    tis_deadline,
    tis_shipping_status,
    tis_internal_note,
    tis_created_on,
    tis_created_by,
    tis_modified_on,
    tis_modified_by
FROM
    template_import_status;
/

CREATE OR REPLACE FORCE VIEW "P01005_VW" ("PER_ID", "PER_EMAIL", "PER_FIRSTNAME", "PER_LASTNAME", "PER_CREATED_ON", "PER_CREATED_BY", "PER_MODIFIED_ON", "PER_MODIFIED_BY") AS 
  SELECT
    per_id,
    per_email,
    per_firstname,
    per_lastname,
    per_created_on,
    per_created_by,
    per_modified_on,
    per_modified_by
FROM
    r_person;
/

CREATE OR REPLACE FORCE VIEW "P01006_VW" ("SPS_ID", "SPS_NAME", "SPS_CREATED_ON", "SPS_CREATED_BY", "SPS_MODIFIED_ON", "SPS_MODIFIED_BY") AS 
  SELECT
    sps_id,
    sps_name,
    sps_created_on,
    sps_created_by,
    sps_modified_on,
    sps_modified_by
FROM
    r_shippingstatus;
/

CREATE OR REPLACE FORCE VIEW "P01007_VW" ("STS_ID", "STS_NAME", "STS_CREATED_ON", "STS_CREATED_BY", "STS_MODIFIED_ON", "STS_MODIFIED_BY") AS 
  SELECT
    sts_id,
    sts_name,
    sts_created_on,
    sts_created_by,
    sts_modified_on,
    sts_modified_by
FROM
    r_status;
/

CREATE OR REPLACE FORCE VIEW "P01008_VW" ("TPL_ID", "TPL_NAME", "TPL_DEADLINE", "TPL_NUMBER_OF_ROWS", "TPL_CREATED_ON", "TPL_CREATED_BY", "TPL_MODIFIED_ON", "TPL_MODIFIED_BY") AS 
  SELECT
    tpl_id,
    tpl_name,
    tpl_deadline,
    tpl_number_of_rows,
    tpl_created_on,
    tpl_created_by,
    tpl_modified_on,
    tpl_modified_by
FROM
    r_templates;
/

CREATE OR REPLACE FORCE VIEW "P01009_VW" ("TID_ID", "TID_TPH_ID", "TID_TEXT", "TID_TIS_ID", "TID_ROW_ID", "TID_CREATED_ON", "TID_CREATED_BY", "TID_MODIFIED_ON", "TID_MODIFIED_BY") AS 
  SELECT
    tid_id,
    tid_tph_id,
    tid_text,
    tid_tis_id,
    tid_row_id,
    tid_created_on,
    tid_created_by,
    tid_modified_on,
    tid_modified_by
FROM
    template_import_data;
/

CREATE OR REPLACE FORCE VIEW "P01010_VW" ("TPH_ID", "TPH_TPL_ID", "TPH_HEA_ID", "TPH_XLSX_BACKGROUND_COLOR", "TPH_XLSX_FONT_COLOR", "TPH_SORT_ORDER", "TPH_THG_ID", "TPH_CREATED_ON", "TPH_CREATED_BY", "TPH_MODIFIED_ON", "TPH_MODIFIED_BY") AS 
  SELECT
    tph_id,
    tph_tpl_id,
    tph_hea_id,
    tph_xlsx_background_color,
    tph_xlsx_font_color,
    tph_sort_order,
    tph_thg_id,
    tph_created_on,
    tph_created_by,
    tph_modified_on,
    tph_modified_by
FROM
    template_header;
/

CREATE OR REPLACE FORCE VIEW "P01011_VW" ("DDS_ID", "DDS_HEA_ID", "DDS_TEXT", "DDS_CREATED_ON", "DDS_CREATED_BY", "DDS_MODIFIED_ON", "DDS_MODIFIED_BY") AS 
  SELECT
    dds_id,
    dds_hea_id,
    dds_text,
    dds_created_on,
    dds_created_by,
    dds_modified_on,
    dds_modified_by
FROM
    r_dropdowns;
/

CREATE OR REPLACE FORCE VIEW "P01012_VW" ("THG_ID", "THG_TEXT", "THG_XLSX_BACKGROUND_COLOR", "THG_XLSX_FONT_COLOR", "THG_CREATED_ON", "THG_CREATED_BY", "THG_MODIFIED_ON", "THG_MODIFIED_BY") AS 
  SELECT
    thg_id,
    thg_text,
    thg_xlsx_background_color,
    thg_xlsx_font_color,
    thg_created_on,
    thg_created_by,
    thg_modified_on,
    thg_modified_by
FROM
    template_header_group;
/

CREATE OR REPLACE FORCE VIEW "P01013_VW" ("THV_ID", "THV_TPH_ID", "THV_FORMULA1", "THV_FORMULA2", "THV_CREATED_ON", "THV_CREATED_BY", "THV_MODIFIED_ON", "THV_MODIFIED_BY") AS 
  SELECT
    thv_id,
    thv_tph_id,
    thv_formula1,
    thv_formula2,
    thv_created_on,
    thv_created_by,
    thv_modified_on,
    thv_modified_by
FROM
    template_header_validations;
/