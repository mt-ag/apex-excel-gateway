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
