CREATE OR REPLACE FORCE VIEW "P01001_VW" ("USR_ID", "USR_NAME", "USR_CREATED_ON", "USR_CREATED_BY", "USR_MODIFIED_ON", "USR_MODIFIED_BY") AS 
  SELECT
    usr_id,
    usr_name,
    usr_created_on,
    usr_created_by,
    usr_modified_on,
    usr_modified_by
FROM
    app_user;
/
