CREATE OR REPLACE FORCE VIEW "P00051_VW" ("TEXT", "TIS_ID") AS 
  SELECT
    SUBSTR(hea_text, 0, 245) AS text, tis_id
FROM
    template_import_status,
    template_header,
    r_header
WHERE
    tis_tpl_id = tph_tpl_id
AND
    tph_hea_id = hea_id
AND
    hea_id not in (9996,9998,9999)
ORDER BY
    tph_sort_order;
/
