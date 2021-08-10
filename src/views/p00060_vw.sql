CREATE OR REPLACE FORCE VIEW "P00060_VW" ("TEXT", "TPL_ID") AS 
  SELECT
    SUBSTR(hea_text, 0, 245) AS text, tpl_id
FROM
    r_templates,
    template_header,
    r_header
WHERE
    tpl_id = tph_tpl_id
AND
    tph_hea_id = hea_id
AND
    hea_id not in (9996,9998,9999)
ORDER BY
    tph_sort_order;
/
