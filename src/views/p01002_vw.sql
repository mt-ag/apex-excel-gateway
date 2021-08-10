CREATE OR REPLACE FORCE VIEW "P01002_VW" ("FIL_ID", "FIL_FILENAME", "FIL_IMPORT_EXPORT", "FIL_IMPORT_COMPLETED", "FIL_CREATED_ON", "FIL_CREATED_BY", "FIL_MODIFIED_ON", "FIL_MODIFIED_BY") AS 
  SELECT
    fil_id,
    fil_filename,
    fil_import_export,
    fil_import_completed,
    fil_created_on,
    fil_created_by,
    fil_modified_on,
    fil_modified_by
FROM
    files;
/
