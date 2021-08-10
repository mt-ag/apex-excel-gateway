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
