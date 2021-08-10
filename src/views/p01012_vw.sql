CREATE OR REPLACE FORCE VIEW "P01012_VW" ("THG_ID", "THG_TEXT", "THG_XLSX_BACKGROUND_COLOR", "THG_XLSX_FONT_COLOR", "THG_CREATED_ON", "THG_CREATED_BY", "THG_MODIFIED_ON", "THG_MODIFIED_BY") AS 
  SELECT
    thg_id,
    thg_text,
    thg_xlsx_background_color,
    thg_xlsx_font_color,
    thg_created_on,
    thg_created_by,
    thg_modified_on,
    thg_modified_by
FROM
    template_header_group;
/
