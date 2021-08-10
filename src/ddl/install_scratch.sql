-- Generiert von Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   am/um:        2021-08-09 12:52:11 MESZ
--   Site:      Oracle Database 12cR2
--   Typ:      Oracle Database 12cR2

CREATE SEQUENCE dds_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE fil_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE hea_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE ier_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE per_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE sps_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE sts_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE thg_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE thv_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE tid_row_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE tid_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE tis_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE tpa_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE tph_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE tpl_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE val_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE TABLE files (
    fil_id                NUMBER DEFAULT ON NULL "FIL_SEQ"."NEXTVAL" NOT NULL,
    fil_file              BLOB NOT NULL,
    fil_filename          VARCHAR2(200 CHAR) NOT NULL,
    fil_mimetype          VARCHAR2(200 CHAR) NOT NULL,
    fil_session           NUMBER NOT NULL,
    fil_import_export     NUMBER(1) DEFAULT 1 NOT NULL,
    fil_import_completed  NUMBER,
    fil_created_on        DATE,
    fil_created_by        VARCHAR2(200 CHAR),
    fil_modified_on       DATE,
    fil_modified_by       VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX fil_pk ON
    files (
        fil_id
    ASC );

ALTER TABLE files
    ADD CONSTRAINT fil_pk PRIMARY KEY ( fil_id )
        USING INDEX fil_pk;

CREATE TABLE import_errors (
    ier_id         NUMBER DEFAULT ON NULL "IER_SEQ"."NEXTVAL" NOT NULL,
    ier_session    NUMBER NOT NULL,
    ier_message    VARCHAR2(1000 CHAR) NOT NULL,
    ier_filename   VARCHAR2(200 CHAR) NOT NULL,
    ier_row_id     NUMBER,
    ier_header     VARCHAR2(2000 CHAR),
    ier_timestamp  TIMESTAMP DEFAULT systimestamp
)
;

CREATE UNIQUE INDEX ier_pk ON
    import_errors (
        ier_id
    ASC );

ALTER TABLE import_errors
    ADD CONSTRAINT ier_pk PRIMARY KEY ( ier_id )
        USING INDEX ier_pk;

CREATE TABLE r_dropdowns (
    dds_id           NUMBER DEFAULT ON NULL "DDS_SEQ"."NEXTVAL" NOT NULL,
    dds_hea_id       NUMBER NOT NULL,
    dds_text         VARCHAR2(2000 CHAR) NOT NULL,
    dds_created_on   DATE,
    dds_created_by   VARCHAR2(200 CHAR),
    dds_modified_on  DATE,
    dds_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX dds_pk ON
    r_dropdowns (
        dds_id
    ASC );

CREATE UNIQUE INDEX dds_uk ON
    r_dropdowns (
        dds_hea_id
    ASC,
        dds_text
    ASC );

ALTER TABLE r_dropdowns
    ADD CONSTRAINT dds_pk PRIMARY KEY ( dds_id )
        USING INDEX dds_pk;

ALTER TABLE r_dropdowns
    ADD CONSTRAINT dds_uk UNIQUE ( dds_hea_id,
                                   dds_text )
        USING INDEX dds_uk;

CREATE TABLE r_header (
    hea_id           NUMBER DEFAULT ON NULL "HEA_SEQ"."NEXTVAL" NOT NULL,
    hea_text         VARCHAR2(2000 CHAR) NOT NULL,
    hea_xlsx_width   NUMBER(12, 2) DEFAULT ON NULL 12 NOT NULL,
    hea_val_id       NUMBER NOT NULL,
    hea_created_on   DATE,
    hea_created_by   VARCHAR2(200 CHAR),
    hea_modified_on  DATE,
    hea_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX hea_pk ON
    r_header (
        hea_id
    ASC );

CREATE UNIQUE INDEX hea_uk ON
    r_header (
        hea_text
    ASC );

ALTER TABLE r_header
    ADD CONSTRAINT hea_pk PRIMARY KEY ( hea_id )
        USING INDEX hea_pk;

ALTER TABLE r_header ADD CONSTRAINT hea_uk UNIQUE ( hea_text )
    USING INDEX hea_uk;

CREATE TABLE r_person (
    per_id           NUMBER DEFAULT ON NULL "PER_SEQ"."NEXTVAL" NOT NULL,
    per_email        VARCHAR2(200 CHAR) NOT NULL,
    per_firstname    VARCHAR2(200 CHAR),
    per_lastname     VARCHAR2(200 CHAR),
    per_created_on   DATE,
    per_created_by   VARCHAR2(200 CHAR),
    per_modified_on  DATE,
    per_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX per_pk ON
    r_person (
        per_id
    ASC );

ALTER TABLE r_person
    ADD CONSTRAINT per_pk PRIMARY KEY ( per_id )
        USING INDEX per_pk;

CREATE TABLE r_shippingstatus (
    sps_id           NUMBER DEFAULT ON NULL "SPS_SEQ"."NEXTVAL" NOT NULL,
    sps_name         VARCHAR2(200 CHAR) NOT NULL,
    sps_created_on   DATE,
    sps_created_by   VARCHAR2(200 CHAR),
    sps_modified_on  DATE,
    sps_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX sps_pk ON
    r_shippingstatus (
        sps_id
    ASC );

CREATE UNIQUE INDEX sps_uk ON
    r_shippingstatus (
        sps_name
    ASC );

ALTER TABLE r_shippingstatus
    ADD CONSTRAINT sps_pk PRIMARY KEY ( sps_id )
        USING INDEX sps_pk;

ALTER TABLE r_shippingstatus ADD CONSTRAINT sps_uk UNIQUE ( sps_name )
    USING INDEX sps_uk;

CREATE TABLE r_status (
    sts_id           NUMBER DEFAULT ON NULL "STS_SEQ"."NEXTVAL" NOT NULL,
    sts_name         VARCHAR2(200 CHAR) NOT NULL,
    sts_created_on   DATE,
    sts_created_by   VARCHAR2(200 CHAR),
    sts_modified_on  DATE,
    sts_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX sts_pk ON
    r_status (
        sts_id
    ASC );

CREATE UNIQUE INDEX sts_uk ON
    r_status (
        sts_name
    ASC );

ALTER TABLE r_status
    ADD CONSTRAINT sts_pk PRIMARY KEY ( sts_id )
        USING INDEX sts_pk;

ALTER TABLE r_status ADD CONSTRAINT sts_uk UNIQUE ( sts_name )
    USING INDEX sts_uk;

CREATE TABLE r_templates (
    tpl_id              NUMBER DEFAULT ON NULL "TPL_SEQ"."NEXTVAL" NOT NULL,
    tpl_name            VARCHAR2(200 CHAR) NOT NULL,
    tpl_created_on      DATE,
    tpl_created_by      VARCHAR2(200 CHAR),
    tpl_modified_on     DATE,
    tpl_modified_by     VARCHAR2(200 CHAR),
    tpl_deadline        NUMBER,
    tpl_number_of_rows  NUMBER
)
;

CREATE UNIQUE INDEX tpl_pk ON
    r_templates (
        tpl_id
    ASC );

CREATE UNIQUE INDEX tpl_uk ON
    r_templates (
        tpl_name
    ASC );

ALTER TABLE r_templates
    ADD CONSTRAINT tpl_pk PRIMARY KEY ( tpl_id )
        USING INDEX tpl_pk;

ALTER TABLE r_templates ADD CONSTRAINT tpl_uk UNIQUE ( tpl_name )
    USING INDEX tpl_uk;

CREATE TABLE r_validation (
    val_id           NUMBER DEFAULT ON NULL "VAL_SEQ"."NEXTVAL" NOT NULL,
    val_text         VARCHAR2(2000 CHAR) NOT NULL,
    val_message      VARCHAR2(2000 CHAR) NOT NULL,
    val_created_on   DATE,
    val_created_by   VARCHAR2(200 CHAR),
    val_modified_on  DATE,
    val_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX val_pk ON
    r_validation (
        val_id
    ASC );

CREATE UNIQUE INDEX val_uk ON
    r_validation (
        val_text
    ASC );

ALTER TABLE r_validation
    ADD CONSTRAINT val_pk PRIMARY KEY ( val_id )
        USING INDEX val_pk;

ALTER TABLE r_validation ADD CONSTRAINT val_uk UNIQUE ( val_text )
    USING INDEX val_uk;

CREATE TABLE template_automations (
    tpa_id           NUMBER DEFAULT ON NULL "TPA_SEQ"."NEXTVAL" NOT NULL,
    tpa_tpl_id       NUMBER NOT NULL,
    tpa_days         VARCHAR2(100 CHAR),
    tpa_enabled      NUMBER NOT NULL,
    tpa_created_on   DATE,
    tpa_created_by   VARCHAR2(200 CHAR),
    tpa_modified_on  DATE,
    tpa_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX tpa_pk ON
    template_automations (
        tpa_id
    ASC );

CREATE UNIQUE INDEX tpa_uk ON
    template_automations (
        tpa_tpl_id
    ASC );

ALTER TABLE template_automations
    ADD CONSTRAINT tpa_pk PRIMARY KEY ( tpa_id )
        USING INDEX tpa_pk;

ALTER TABLE template_automations ADD CONSTRAINT tpa_uk UNIQUE ( tpa_tpl_id )
    USING INDEX tpa_uk;

CREATE TABLE template_header (
    tph_id                     NUMBER DEFAULT ON NULL "TPH_SEQ"."NEXTVAL" NOT NULL,
    tph_tpl_id                 NUMBER NOT NULL,
    tph_hea_id                 NUMBER NOT NULL,
    tph_xlsx_background_color  VARCHAR2(8 CHAR) NOT NULL,
    tph_xlsx_font_color        VARCHAR2(8 CHAR) NOT NULL,
    tph_sort_order             NUMBER NOT NULL,
    tph_created_on             DATE,
    tph_created_by             VARCHAR2(200 CHAR),
    tph_modified_on            DATE,
    tph_modified_by            VARCHAR2(200 CHAR),
    tph_thg_id                 NUMBER
)
;

CREATE UNIQUE INDEX tph_pk ON
    template_header (
        tph_id
    ASC );

CREATE UNIQUE INDEX tph_uk ON
    template_header (
        tph_tpl_id
    ASC,
        tph_hea_id
    ASC,
        tph_sort_order
    ASC );

ALTER TABLE template_header
    ADD CONSTRAINT tph_pk PRIMARY KEY ( tph_id )
        USING INDEX tph_pk;

ALTER TABLE template_header
    ADD CONSTRAINT tph_uk UNIQUE ( tph_tpl_id,
                                   tph_hea_id,
                                   tph_sort_order )
        USING INDEX tph_uk;

CREATE TABLE template_header_group (
    thg_id                     NUMBER DEFAULT ON NULL "THG_SEQ"."NEXTVAL" NOT NULL,
    thg_text                   VARCHAR2(400 CHAR) NOT NULL,
    thg_xlsx_background_color  VARCHAR2(8 CHAR) NOT NULL,
    thg_xlsx_font_color        VARCHAR2(8 CHAR) NOT NULL,
    thg_created_on             DATE,
    thg_created_by             VARCHAR2(200 CHAR),
    thg_modified_on            DATE,
    thg_modified_by            VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX thg_pk ON
    template_header_group (
        thg_id
    ASC );

ALTER TABLE template_header_group
    ADD CONSTRAINT thg_pk PRIMARY KEY ( thg_id )
        USING INDEX thg_pk;

CREATE TABLE template_header_validations (
    thv_id           NUMBER DEFAULT ON NULL "THV_SEQ"."NEXTVAL" NOT NULL,
    thv_tph_id       NUMBER NOT NULL,
    thv_formula1     VARCHAR2(2000 CHAR),
    thv_formula2     VARCHAR2(2000 CHAR),
    thv_created_on   DATE,
    thv_created_by   VARCHAR2(200 CHAR),
    thv_modified_on  DATE,
    thv_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX thv_pk ON
    template_header_validations (
        thv_id
    ASC );

CREATE UNIQUE INDEX thv_uk ON
    template_header_validations (
        thv_tph_id
    ASC );

ALTER TABLE template_header_validations
    ADD CONSTRAINT thv_pk PRIMARY KEY ( thv_id )
        USING INDEX thv_pk;

ALTER TABLE template_header_validations ADD CONSTRAINT thv_uk UNIQUE ( thv_tph_id )
    USING INDEX thv_uk;

CREATE TABLE template_import_data (
    tid_id           NUMBER DEFAULT ON NULL "TID_SEQ"."NEXTVAL" NOT NULL,
    tid_tph_id       NUMBER NOT NULL,
    tid_text         VARCHAR2(2000 CHAR),
    tid_tis_id       NUMBER NOT NULL,
    tid_row_id       NUMBER NOT NULL,
    tid_val_id       NUMBER,
    tid_created_on   DATE,
    tid_created_by   VARCHAR2(200 CHAR),
    tid_modified_on  DATE,
    tid_modified_by  VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX tid_pk ON
    template_import_data (
        tid_id
    ASC );

CREATE UNIQUE INDEX tid_uk ON
    template_import_data (
        tid_tis_id
    ASC,
        tid_tph_id
    ASC,
        tid_row_id
    ASC );

ALTER TABLE template_import_data
    ADD CONSTRAINT tid_pk PRIMARY KEY ( tid_id )
        USING INDEX tid_pk;

ALTER TABLE template_import_data
    ADD CONSTRAINT tid_uk UNIQUE ( tid_tis_id,
                                   tid_tph_id,
                                   tid_row_id )
        USING INDEX tid_uk;

CREATE TABLE template_import_status (
    tis_id               NUMBER DEFAULT ON NULL "TIS_SEQ"."NEXTVAL" NOT NULL,
    tis_tpl_id           NUMBER NOT NULL,
    tis_per_id           NUMBER NOT NULL,
    tis_sts_id           NUMBER NOT NULL,
    tis_fil_id           NUMBER NOT NULL,
    tis_annotation       VARCHAR2(2000 CHAR),
    tis_deadline         DATE,
    tis_shipping_status  NUMBER DEFAULT 0,
    tis_internal_note    VARCHAR2(2000 BYTE),
    tis_created_on       DATE,
    tis_created_by       VARCHAR2(200 CHAR),
    tis_modified_on      DATE,
    tis_modified_by      VARCHAR2(200 CHAR)
)
;

CREATE UNIQUE INDEX tis_fil_uk ON
    template_import_status (
        tis_fil_id
    ASC );

CREATE UNIQUE INDEX tis_pk ON
    template_import_status (
        tis_id
    ASC );

CREATE UNIQUE INDEX tis_uk ON
    template_import_status (
        tis_tpl_id
    ASC,
        tis_per_id
    ASC );

ALTER TABLE template_import_status
    ADD CONSTRAINT tis_pk PRIMARY KEY ( tis_id )
        USING INDEX tis_pk;

ALTER TABLE template_import_status ADD CONSTRAINT tis_fil_uk UNIQUE ( tis_fil_id )
    USING INDEX tis_fil_uk;

ALTER TABLE template_import_status
    ADD CONSTRAINT tis_uk UNIQUE ( tis_tpl_id,
                                   tis_per_id )
        USING INDEX tis_uk;

ALTER TABLE r_dropdowns
    ADD CONSTRAINT dds_hea_fk FOREIGN KEY ( dds_hea_id )
        REFERENCES r_header ( hea_id );

ALTER TABLE r_header
    ADD CONSTRAINT hea_val_fk FOREIGN KEY ( hea_val_id )
        REFERENCES r_validation ( val_id );

ALTER TABLE template_header_validations
    ADD CONSTRAINT thv_tph_fk FOREIGN KEY ( thv_tph_id )
        REFERENCES template_header ( tph_id );

ALTER TABLE template_import_data
    ADD CONSTRAINT tid_tis_fk FOREIGN KEY ( tid_tis_id )
        REFERENCES template_import_status ( tis_id );

ALTER TABLE template_import_status
    ADD CONSTRAINT tis_fil_fk FOREIGN KEY ( tis_fil_id )
        REFERENCES files ( fil_id );

ALTER TABLE template_import_status
    ADD CONSTRAINT tis_per_fk FOREIGN KEY ( tis_per_id )
        REFERENCES r_person ( per_id );

ALTER TABLE template_import_status
    ADD CONSTRAINT tis_sts_fk FOREIGN KEY ( tis_sts_id )
        REFERENCES r_status ( sts_id );

ALTER TABLE template_import_status
    ADD CONSTRAINT tis_tpl_fk FOREIGN KEY ( tis_tpl_id )
        REFERENCES r_templates ( tpl_id );

ALTER TABLE template_automations
    ADD CONSTRAINT tpa_tpl_fk FOREIGN KEY ( tpa_tpl_id )
        REFERENCES r_templates ( tpl_id );

ALTER TABLE template_header
    ADD CONSTRAINT tph_hea_fk FOREIGN KEY ( tph_hea_id )
        REFERENCES r_header ( hea_id );

ALTER TABLE template_header
    ADD CONSTRAINT tph_tpl_fk FOREIGN KEY ( tph_tpl_id )
        REFERENCES r_templates ( tpl_id );

CREATE OR REPLACE TRIGGER DDS_BIU_TRG 
    BEFORE INSERT OR UPDATE ON R_DROPDOWNS 
    FOR EACH ROW 
begin
  if :new.dds_id is null
  then
    :new.dds_id := dds_seq.nextval;
  end if;

  if inserting
  then
    :new.dds_created_on  := sysdate;
    :new.dds_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.dds_modified_on  := sysdate;
  :new.dds_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end dds_biu_trg; 
/

CREATE OR REPLACE TRIGGER FIL_BIU_TRG 
    BEFORE INSERT OR UPDATE ON FILES 
    FOR EACH ROW 
begin
  if :new.fil_id is null
  then
    :new.fil_id := fil_seq.nextval;
  end if;

  if inserting
  then
    :new.fil_created_on  := sysdate;
    :new.fil_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.fil_modified_on  := sysdate;
  :new.fil_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end fil_biu_trg; 
/

CREATE OR REPLACE TRIGGER HEA_BIU_TRG 
    BEFORE INSERT OR UPDATE ON R_HEADER 
    FOR EACH ROW 
begin
  if :new.hea_id is null
  then
    :new.hea_id := hea_seq.nextval;
  end if;

  if inserting
  then
    :new.hea_created_on  := sysdate;
    :new.hea_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.hea_modified_on  := sysdate;
  :new.hea_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end hea_biu_trg; 
/

CREATE OR REPLACE TRIGGER PER_BIU_TRG 
    BEFORE INSERT OR UPDATE ON R_PERSON 
    FOR EACH ROW 
begin
  if :new.per_id is null
  then
    :new.per_id := per_seq.nextval;
  end if;

  if inserting
  then
    :new.per_created_on  := sysdate;
    :new.per_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.per_modified_on  := sysdate;
  :new.per_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end per_biu_trg; 
/

CREATE OR REPLACE TRIGGER SPS_BIU_TRG 
    BEFORE INSERT OR UPDATE ON R_SHIPPINGSTATUS 
    FOR EACH ROW 
begin
  if :new.sps_id is null
  then
    :new.sps_id := sps_seq.nextval;
  end if;

  if inserting
  then
    :new.sps_created_on  := sysdate;
    :new.sps_created_by := coalesce(sys_context('apex$session','app_user'), user);
  end if;

  :new.sps_modified_on  := sysdate;
  :new.sps_modified_by := coalesce(sys_context('apex$session','app_user'), user);
end sps_biu_trg; 
/

CREATE OR REPLACE TRIGGER STS_BIU_TRG 
    BEFORE INSERT OR UPDATE ON R_STATUS 
    FOR EACH ROW 
begin
  if :new.sts_id is null
  then
    :new.sts_id := sts_seq.nextval;
  end if;

  if inserting
  then
    :new.sts_created_on  := sysdate;
    :new.sts_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.sts_modified_on  := sysdate;
  :new.sts_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end sts_biu_trg; 
/

CREATE OR REPLACE TRIGGER THG_BIU_TRG 
    BEFORE INSERT OR UPDATE ON TEMPLATE_HEADER_GROUP 
    FOR EACH ROW 
begin
  if :new.thg_id is null
  then
    :new.thg_id := thg_seq.nextval;
  end if;

  if inserting
  then
    :new.thg_created_on  := sysdate;
    :new.thg_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.thg_modified_on  := sysdate;
  :new.thg_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end thg_biu_trg; 
/

CREATE OR REPLACE TRIGGER THV_BIU_TRG 
    BEFORE INSERT OR UPDATE ON TEMPLATE_HEADER_VALIDATIONS 
    FOR EACH ROW 
begin
  if :new.thv_id is null
  then
    :new.thv_id := thv_seq.nextval;
  end if;

  if inserting
  then
    :new.thv_created_on  := sysdate;
    :new.thv_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.thv_modified_on  := sysdate;
  :new.thv_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end thv_biu_trg; 
/

CREATE OR REPLACE TRIGGER TID_BIU_TRG 
    BEFORE INSERT OR UPDATE ON TEMPLATE_IMPORT_DATA 
    FOR EACH ROW 
begin
  if :new.tid_id is null
  then
    :new.tid_id := tid_seq.nextval;
  end if;

  if inserting
  then
    :new.tid_created_on  := sysdate;
    :new.tid_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.tid_modified_on  := sysdate;
  :new.tid_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end tid_biu_trg; 
/

CREATE OR REPLACE TRIGGER TIS_BIU_TRG 
    BEFORE INSERT OR UPDATE ON TEMPLATE_IMPORT_STATUS 
    FOR EACH ROW 
begin
  if :new.tis_id is null
  then
    :new.tis_id := tis_seq.nextval;
  end if;

  if inserting
  then
    :new.tis_created_on  := sysdate;
    :new.tis_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.tis_modified_on  := sysdate;
  :new.tis_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end tis_biu_trg; 
/

CREATE OR REPLACE TRIGGER TPA_BIU_TRG 
    BEFORE INSERT OR UPDATE ON TEMPLATE_AUTOMATIONS 
    FOR EACH ROW 
begin
  if :new.tpa_id is null
  then
    :new.tpa_id := tpa_seq.nextval;
  end if;

  if inserting
  then
    :new.tpa_created_on  := sysdate;
    :new.tpa_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.tpa_modified_on  := sysdate;
  :new.tpa_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end tpa_biu_trg; 
/

CREATE OR REPLACE TRIGGER TPH_BIU_TRG 
    BEFORE INSERT OR UPDATE ON TEMPLATE_HEADER 
    FOR EACH ROW 
begin
  if :new.tph_id is null
  then
    :new.tph_id := tph_seq.nextval;
  end if;

  if inserting
  then
    :new.tph_created_on  := sysdate;
    :new.tph_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.tph_modified_on  := sysdate;
  :new.tph_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end tph_biu_trg; 
/

CREATE OR REPLACE TRIGGER TPL_BIU_TRG 
    BEFORE INSERT OR UPDATE ON R_TEMPLATES 
    FOR EACH ROW 
begin
  if :new.tpl_id is null
  then
    :new.tpl_id := tpl_seq.nextval;
  end if;

  if inserting
  then
    :new.tpl_created_on  := sysdate;
    :new.tpl_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.tpl_modified_on  := sysdate;
  :new.tpl_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end tpl_biu_trg; 
/

CREATE OR REPLACE TRIGGER VAL_BIU_TRG 
    BEFORE INSERT OR UPDATE ON R_VALIDATION 
    FOR EACH ROW 
begin
  if :new.val_id is null
  then
    :new.val_id := val_seq.nextval;
  end if;

  if inserting
  then
    :new.val_created_on  := sysdate;
    :new.val_created_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
  end if;

  :new.val_modified_on  := sysdate;
  :new.val_modified_by := coalesce(sys_context('APEX$SESSION','APP_USER'), user);
end val_biu_trg; 
/



-- Zusammenfassungsbericht für Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                            29
-- ALTER TABLE                             40
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          14
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          16
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0


REM INSERTING into R_SHIPPINGSTATUS
Insert into R_SHIPPINGSTATUS (SPS_NAME) values ('Survey not sent');
Insert into R_SHIPPINGSTATUS (SPS_NAME) values ('Survey sent');
Insert into R_SHIPPINGSTATUS (SPS_NAME) values ('Correction sent');
Insert into R_SHIPPINGSTATUS (SPS_NAME) values ('Reminder sent');
commit;

REM INSERTING into R_STATUS
Insert into R_STATUS (STS_NAME) values ('Not edited');
Insert into R_STATUS (STS_NAME) values ('In processing');
Insert into R_STATUS (STS_NAME) values ('Completed');
commit;

REM INSERTING into R_VALIDATION
Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values ('email','Invalid email address');
Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values ('number','Invalid number');
Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values ('date','Invalid date');
Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values ('formula','formula');
commit;