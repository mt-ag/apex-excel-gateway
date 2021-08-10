CREATE OR REPLACE FORCE VIEW "P00042_VW" ("IER_ID", "IER_SESSION", "IER_MESSAGE", "IER_FILENAME", "IER_ROW_ID", "IER_HEADER", "IER_TIMESTAMP") AS 
  select ier_id
       , ier_session
       , ier_message
       , ier_filename
       , ier_row_id
       , ier_header
       , ier_timestamp
    from import_errors;
/
