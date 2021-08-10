create or replace package p00027_api as 

  procedure save_header(
    pi_hea_text         in r_header.hea_text%type
  , pi_hea_xlsx_width   in r_header.hea_xlsx_width%type
  , pi_hea_val_id       in r_header.hea_val_id%type
  , pi_dropdown_values  in varchar2 
  );

end p00027_api;
/