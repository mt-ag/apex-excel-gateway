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