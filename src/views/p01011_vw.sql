CREATE OR REPLACE FORCE VIEW "P01011_VW" ("DDS_ID", "DDS_HEA_ID", "DDS_TEXT", "DDS_CREATED_ON", "DDS_CREATED_BY", "DDS_MODIFIED_ON", "DDS_MODIFIED_BY") AS 
  SELECT
    dds_id,
    dds_hea_id,
    dds_text,
    dds_created_on,
    dds_created_by,
    dds_modified_on,
    dds_modified_by
FROM
    r_dropdowns;
/
