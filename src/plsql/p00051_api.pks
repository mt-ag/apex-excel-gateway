create or replace package p00051_api
as

 type t_grid_row is record (
    tid_row_id template_import_data.tid_row_id%type
  , col01      template_import_data.tid_text%type
  , col02      template_import_data.tid_text%type
  , col03      template_import_data.tid_text%type
  , col04      template_import_data.tid_text%type
  , col05      template_import_data.tid_text%type
  , col06      template_import_data.tid_text%type
  , col07      template_import_data.tid_text%type
  , col08      template_import_data.tid_text%type
  , col09      template_import_data.tid_text%type
  , col10      template_import_data.tid_text%type
  , col11      template_import_data.tid_text%type
  , col12      template_import_data.tid_text%type
  , col13      template_import_data.tid_text%type
  , col14      template_import_data.tid_text%type
  , col15      template_import_data.tid_text%type
  , col16      template_import_data.tid_text%type
  , col17      template_import_data.tid_text%type
  , col18      template_import_data.tid_text%type
  , col19      template_import_data.tid_text%type
  , col20      template_import_data.tid_text%type
  , col21      template_import_data.tid_text%type
  , col22      template_import_data.tid_text%type
  , col23      template_import_data.tid_text%type
  , col24      template_import_data.tid_text%type
  , col25      template_import_data.tid_text%type
  , col26      template_import_data.tid_text%type
  , col27      template_import_data.tid_text%type
  , col28      template_import_data.tid_text%type
  , col29      template_import_data.tid_text%type
  , col30      template_import_data.tid_text%type
  , col31      template_import_data.tid_text%type
  , col32      template_import_data.tid_text%type
  , col33      template_import_data.tid_text%type
  , col34      template_import_data.tid_text%type
  , col35      template_import_data.tid_text%type
  , col36      template_import_data.tid_text%type
  , col37      template_import_data.tid_text%type
  , col38      template_import_data.tid_text%type
  , col39      template_import_data.tid_text%type
  , col40      template_import_data.tid_text%type
  , col41      template_import_data.tid_text%type
  , col42      template_import_data.tid_text%type
  , col43      template_import_data.tid_text%type
  , col44      template_import_data.tid_text%type
  , col45      template_import_data.tid_text%type
  , faulty     template_import_data.tid_text%type   
  , annotation template_import_data.tid_text%type
  , validation template_import_data.tid_text%type
  );

  type t_grid_tab is table of t_grid_row;

  type t_tid_text_array is varray(45) of template_import_data.tid_text%type;

  type t_hea_text_array is varray(45) of r_header.hea_text%type;

  function get_grid_query (
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  ;

  function get_grid_data (
    pi_tis_id in template_import_status.tis_id%type
  ) return t_grid_tab pipelined
  ;

  procedure update_answer_status(
    pi_tis_id       in template_import_status.tis_id%type
  , pi_tid_row_id   in template_import_data.tid_row_id%type
  , pi_annotation   in template_import_data.tid_text%type
  , pi_faulty       in template_import_data.tid_text%type   
  );

  procedure update_answer(
    pi_tid_text_array in t_tid_text_array
  , pi_tid_row_id     in template_import_data.tid_row_id%type
  , pi_tis_id         in template_import_data.tid_tis_id%type
  );

  procedure insert_answer(
    pi_tid_text_array in t_tid_text_array
  , pi_annotation     in template_import_data.tid_text%type
  , pi_faulty         in template_import_data.tid_text%type --number  
  , pi_tis_id         in template_import_data.tid_tis_id%type
  );

  procedure delete_answer (
    pi_tis_id     in template_import_status.tis_id%type
  , pi_tid_row_id in template_import_data.tid_row_id%type

  );
  function get_column_count (
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  ;
end p00051_api;
/