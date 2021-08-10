CREATE OR REPLACE FORCE VIEW "P00020_VW" ("FIL_ID", "FIL_FILENAME", "FIL_CREATED_ON", "FIL_SESSION", "FILE_LENGTH") AS 
  select fil_id
      , fil_filename
      , fil_created_on
      , fil_session
      , dbms_lob.getlength(fil_file) as file_length
    from files
   where fil_import_export = 0
     and fil_import_completed = 1;
/