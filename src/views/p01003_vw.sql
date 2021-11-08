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
    r_header
WHERE 
    hea_id not between 9996 and 9999;
/
