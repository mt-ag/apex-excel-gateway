CREATE OR REPLACE FORCE VIEW "P01014_VW" ("TPA_ID","TPA_TPL_ID","TPA_DAYS","TPA_ENABLED","TPA_CREATED_ON","TPA_CREATED_BY","TPA_MODIFIED_ON","TPA_MODIFIED_BY") AS 
SELECT 
    tpa_id,
    tpa_tpl_id,
    tpa_days,
    tpa_enabled,
    tpa_created_on,
    tpa_created_by,
    tpa_modified_on,
    tpa_modified_by
FROM 
    template_automations;
/

