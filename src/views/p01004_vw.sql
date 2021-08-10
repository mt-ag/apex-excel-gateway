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
