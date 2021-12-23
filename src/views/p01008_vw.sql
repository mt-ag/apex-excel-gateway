CREATE OR REPLACE FORCE VIEW "P01008_VW" ("TPL_ID", "TPL_NAME", "TPL_DEADLINE", "TPL_NUMBER_OF_ROWS", "TPL_SSP_ID", "TPL_CREATED_ON", "TPL_CREATED_BY", "TPL_MODIFIED_ON", "TPL_MODIFIED_BY") AS 
  SELECT
    tpl_id,
    tpl_name,
    tpl_deadline,
    tpl_number_of_rows,
    tpl_ssp_id,
    tpl_created_on,
    tpl_created_by,
    tpl_modified_on,
    tpl_modified_by
FROM
    r_templates;
/