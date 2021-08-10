CREATE OR REPLACE FORCE VIEW "P01005_VW" ("PER_ID", "PER_EMAIL", "PER_FIRSTNAME", "PER_LASTNAME", "PER_CREATED_ON", "PER_CREATED_BY", "PER_MODIFIED_ON", "PER_MODIFIED_BY") AS 
  SELECT
    per_id,
    per_email,
    per_firstname,
    per_lastname,
    per_created_on,
    per_created_by,
    per_modified_on,
    per_modified_by
FROM
    r_person;
/
