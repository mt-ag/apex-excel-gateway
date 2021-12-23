CREATE OR REPLACE FORCE VIEW "P01015_VW" ("SSP_ID","SSP_NAME","SSP_HASH_VALUE","SSP_SALT_VALUE","SSP_CREATED_ON","SSP_CREATED_BY","SSP_MODIFIED_ON","SSP_MODIFIED_BY") AS 
SELECT 
    ssp_id,
    ssp_name,
    ssp_hash_value,
    ssp_salt_value,
    ssp_created_on,
    ssp_created_by,
    ssp_modified_on,
    ssp_modified_by
FROM
    r_spreadsheet_protection;
/