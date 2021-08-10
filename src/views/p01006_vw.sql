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
