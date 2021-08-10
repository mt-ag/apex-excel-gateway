create or replace package p00028_api as 

  procedure save_header_group(
    pi_thg_text                   in template_header_group.thg_text%type
  , pi_thg_xlsx_background_color  in template_header_group.thg_xlsx_background_color%type
  , pi_thg_xlsx_font_color        in template_header_group.thg_xlsx_font_color%type
  );

end p00028_api;
/