set define '^'
set concat '.'

PROMPT >> Database Objects Installation
PROMPT >> =============================

PROMPT >> Installing Tables
@ddl/install_scratch.sql
@ddl/install_logger.sql

PROMPT >> Installing Package Specifications
@plsql/email_pkg.pks
@plsql/excel_gen.pks
@plsql/file_import.pks
@plsql/master_api.pks
@plsql/p00025_api.pks
@plsql/p00027_api.pks
@plsql/p00028_api.pks
@plsql/p00030_api.pks
@plsql/p00031_api.pks
@plsql/p00032_api.pks
@plsql/p00041_api.pks
@plsql/p00051_api.pks
@plsql/p00060_api.pks
@plsql/p00085_api.pks
@plsql/p00090_api.pks
@plsql/validation_api.pks
@plsql/xlsx_builder_pkg.pks
@plsql/zip_util_pkg.pks

PROMPT >> Installing Views
@views/p00020_vw.sql
@views/p00030_vw.sql
@views/p00042_vw.sql
@views/p00051_vw.sql
@views/p00060_vw.sql
@views/p01002_vw.sql
@views/p01003_vw.sql
@views/p01004_vw.sql
@views/p01005_vw.sql
@views/p01006_vw.sql
@views/p01007_vw.sql
@views/p01008_vw.sql
@views/p01009_vw.sql
@views/p01010_vw.sql
@views/p01011_vw.sql
@views/p01012_vw.sql
@views/p01013_vw.sql
@views/p01014_vw.sql
@views/p01015_vw.sql

PROMPT >> Installing Package Bodies
@plsql/email_pkg.pkb
@plsql/excel_gen.pkb
@plsql/file_import.pkb
@plsql/master_api.pkb
@plsql/p00025_api.pkb
@plsql/p00027_api.pkb
@plsql/p00028_api.pkb
@plsql/p00030_api.pkb
@plsql/p00031_api.pkb
@plsql/p00032_api.pkb
@plsql/p00041_api.pkb
@plsql/p00051_api.pkb
@plsql/p00060_api.pkb
@plsql/p00085_api.pkb
@plsql/p00090_api.pkb
@plsql/validation_api.pkb
@plsql/xlsx_builder_pkg.pkb
@plsql/zip_util_pkg.pkb


PROMPT >> Checking for invalid Objects
  select object_type || ': ' || object_name as invalid_object
    from user_objects
   where status = 'INVALID'
order by object_type
       , object_name
;

PROMPT >> =====================
PROMPT >> Installation Finished
PROMPT >> =====================