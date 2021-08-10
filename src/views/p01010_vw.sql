CREATE OR REPLACE FORCE VIEW "P01010_VW" ("TPH_ID", "TPH_TPL_ID", "TPH_HEA_ID", "TPH_XLSX_BACKGROUND_COLOR", "TPH_XLSX_FONT_COLOR", "TPH_SORT_ORDER", "TPH_THG_ID", "TPH_CREATED_ON", "TPH_CREATED_BY", "TPH_MODIFIED_ON", "TPH_MODIFIED_BY") AS 
  SELECT
    tph_id,
    tph_tpl_id,
    tph_hea_id,
    tph_xlsx_background_color,
    tph_xlsx_font_color,
    tph_sort_order,
    tph_thg_id,
    tph_created_on,
    tph_created_by,
    tph_modified_on,
    tph_modified_by
FROM
    template_header;
/
