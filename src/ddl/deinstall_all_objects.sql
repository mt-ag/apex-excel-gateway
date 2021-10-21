PROMPT >> Removing APEX-EXCEL-GATEWAY Database Objects
PROMPT >> ====================================

PROMPT >> Packages
drop package email_pkg;
drop package excel_gen;
drop package file_import;
drop package p00025_api;
drop package p00027_api;
drop package p00028_api;
drop package p00030_api;
drop package p00031_api;
drop package p00032_api;
drop package p00041_api;
drop package p00051_api;
drop package p00060_api;
drop package validation_api;
drop package xlsx_builder_pkg;
drop package zip_util_pkg;

PROMPT >> Views
drop view p00020_vw;
drop view p00030_vw;
drop view p00042_vw;
drop view p00051_vw;
drop view p00060_vw;
drop view p01002_vw;
drop view p01003_vw;
drop view p01004_vw;
drop view p01005_vw;
drop view p01006_vw;
drop view p01007_vw;
drop view p01008_vw;
drop view p01009_vw;
drop view p01010_vw;
drop view p01011_vw;
drop view p01012_vw;
drop view p01013_vw;

PROMPT >> Tables
drop table template_import_data;
drop table template_import_status;
drop table template_header_validations;
drop table template_header_group;
drop table template_header;
drop table template_automations;
drop table r_templates;
drop table r_dropdowns;
drop table r_header;
drop table r_person;
drop table r_shippingstatus;
drop table r_status;
drop table r_validation;
drop table files;
drop table import_errors;

PROMPT >> SEQUENCES
DROP SEQUENCE dds_seq;
DROP SEQUENCE fil_seq;
DROP SEQUENCE hea_seq;
DROP SEQUENCE ier_seq;
DROP SEQUENCE per_seq;
DROP SEQUENCE sps_seq;
DROP SEQUENCE sts_seq;
DROP SEQUENCE thg_seq;
DROP SEQUENCE thv_seq;
DROP SEQUENCE tid_seq;
DROP SEQUENCE tid_row_seq;
DROP SEQUENCE tis_seq;
DROP SEQUENCE tpa_seq;
DROP SEQUENCE tph_seq;
DROP SEQUENCE tpl_seq;
DROP SEQUENCE val_seq;

PROMPT >> Finished Removal of APEX-EXCEL-GATEWAY Database Objects
PROMPT >> ===============================================