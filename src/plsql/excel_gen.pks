create or replace package excel_gen
as

  gc_headergroup_row constant pls_integer := 4;
  gc_header_row      constant pls_integer := 5;
  gc_data_row        constant pls_integer := 6;

  gc_ids_col1 constant pls_integer := 299;
  gc_ids_col2 constant pls_integer := 300;

  procedure regenerate_invalid_rows (
    pi_tis_id in template_import_status.tis_id%type
  );
 
  procedure generate_single_file (
    pi_tis_id        in template_import_status.tis_id%type
  , pi_tpl_id        in r_templates.tpl_id%type
  , pi_tpl_name      in r_templates.tpl_name%type
  , pi_per_id        in r_person.per_id%type
  , pi_per_firstname in r_person.per_firstname%type
  , pi_per_lastname  in r_person.per_lastname%type
  , pi_invalid       in boolean default false 
  );

  function getExcelColumnName(
    p_column_count pls_integer
  ) return varchar2;

end excel_gen;
/