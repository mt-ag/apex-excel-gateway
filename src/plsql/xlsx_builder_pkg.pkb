create or replace PACKAGE BODY xlsx_builder_pkg
IS
   /* Some Naming-conventions
   Prefixes for Datatypes in defined Records-Type-Elements
   vc   VARCHAR2
   nv   NVARCHAR2
   ch   CHAR
   nc   NCHAR
   nn   NUMBER
   pi   PLS_INTEGER
   bi   BINARY_INTEGER
   dt   DATE
   bo   BOOLEAN
   bf   BFILE
   bl   BLOB
   cl   CLOB
   nl   NCLOB
   lo   LONG
   tl   TIMESTAMP (fractional_seconds_precision) WITH LOCAL TIME ZONE
   ts   TIMESTAMP (fractional_seconds_precision)
   tz   TIMESTAMP (fractional_seconds_precision) WITH TIME ZONE
   iv   INTERVAL
        Sample: vc_name VARCHAR2 (10)
   Types-Prefixes
   t_... TYPE
   Types-Suffixes
   ..._rec record
   ..._tab PL/SQL-Table
   */

   /* Types */
   TYPE t_xf_fmt_rec IS RECORD
   (
      pi_numfmtid     PLS_INTEGER,
      pi_fontid       PLS_INTEGER,
      pi_fillid       PLS_INTEGER,
      pi_borderid     PLS_INTEGER,
      alignment_rec   t_alignment_rec
   );

   TYPE t_col_fmts_tab IS TABLE OF t_xf_fmt_rec
      INDEX BY PLS_INTEGER;

   TYPE t_row_fmts_tab IS TABLE OF t_xf_fmt_rec
      INDEX BY PLS_INTEGER;

   TYPE t_widths_tab IS TABLE OF NUMBER
      INDEX BY PLS_INTEGER;

   TYPE t_cell_rec IS RECORD
   (
      nn_value_id    NUMBER,
      vc_style_def   VARCHAR2 (50),
      formula        VARCHAR2 (32767 CHAR) := NULL
   );

   TYPE t_cells_tab IS TABLE OF t_cell_rec
      INDEX BY PLS_INTEGER;

   TYPE t_rows_tab IS TABLE OF t_cells_tab
      INDEX BY PLS_INTEGER;

   TYPE t_autofilter_rec IS RECORD
   (
      pi_column_start   PLS_INTEGER,
      pi_column_end     PLS_INTEGER,
      pi_row_start      PLS_INTEGER,
      pi_row_end        PLS_INTEGER
   );

   TYPE t_autofilters_tab IS TABLE OF t_autofilter_rec
      INDEX BY PLS_INTEGER;

   TYPE t_hyperlink_rec IS RECORD
   (
      vc_cell   VARCHAR2 (10),
      vc_url    VARCHAR2 (1000)
   );

   TYPE t_hyperlinks_tab IS TABLE OF t_hyperlink_rec
      INDEX BY PLS_INTEGER;

   SUBTYPE st_author IS VARCHAR2 (32767 CHAR);

   TYPE t_authors_tab IS TABLE OF PLS_INTEGER
      INDEX BY st_author;

   gv_authors_tab                         t_authors_tab;

   TYPE t_comment_rec IS RECORD
   (
      vc_text        VARCHAR2 (32767 CHAR),
      vc_author      st_author,
      pi_row_nr      PLS_INTEGER,
      pi_column_nr   PLS_INTEGER,
      pi_width       PLS_INTEGER,
      pi_height      PLS_INTEGER
   );

   TYPE t_comments_tab IS TABLE OF t_comment_rec
      INDEX BY PLS_INTEGER;

   TYPE t_mergecells_tab IS TABLE OF VARCHAR2 (21)
      INDEX BY PLS_INTEGER;

   TYPE t_validation_rec IS RECORD
   (
      vc_validation_type    VARCHAR2 (10),
      vc_errorstyle         VARCHAR2 (32),
      bo_showinputmessage   BOOLEAN,
      vc_prompt             VARCHAR2 (32767 CHAR),
      vc_title              VARCHAR2 (32767 CHAR),
      vc_error_title        VARCHAR2 (32767 CHAR),
      vc_error_txt          VARCHAR2 (32767 CHAR),
      bo_showerrormessage   BOOLEAN,
      vc_formula1           VARCHAR2 (32767 CHAR),
      vc_formula2           VARCHAR2 (32767 CHAR),
      bo_allowblank         BOOLEAN,
      vc_sqref              VARCHAR2 (32767 CHAR)
   );

   TYPE t_validations_tab IS TABLE OF t_validation_rec
      INDEX BY PLS_INTEGER;

   TYPE t_protection_rec IS RECORD
   (
      vc_name               VARCHAR2 (200 CHAR),
      vc_tl_col             VARCHAR2 (20 CHAR),
      vc_tl_row             VARCHAR2 (20 CHAR), 
      vc_br_col             VARCHAR2 (20 CHAR),
      vc_br_row             VARCHAR2 (20 CHAR) 
   );

   TYPE t_protection_tab IS TABLE OF t_protection_rec
      INDEX BY PLS_INTEGER;   

   TYPE t_sheet_rec IS RECORD
   (
      sheet_rows_tab    t_rows_tab,
      widths_tab_tab    t_widths_tab,
      vc_sheet_name     VARCHAR2 (31 CHAR),
      pi_freeze_rows    PLS_INTEGER,
      pi_freeze_cols    PLS_INTEGER,
      autofilters_tab   t_autofilters_tab,
      hyperlinks_tab    t_hyperlinks_tab,
      col_fmts_tab      t_col_fmts_tab,
      row_fmts_tab      t_row_fmts_tab,
      comments_tab      t_comments_tab,
      mergecells_tab    t_mergecells_tab,
      validations_tab   t_validations_tab,
      protection_tab    t_protection_tab,
      hidden            boolean,
      hash_value        VARCHAR2(200 CHAR),
      salt_value        VARCHAR2(200 CHAR)
   );

   TYPE t_sheets_tab IS TABLE OF t_sheet_rec
      INDEX BY PLS_INTEGER;

   TYPE t_numfmt_rec IS RECORD
   (
      pi_numfmtid     PLS_INTEGER,
      vc_formatcode   VARCHAR2 (100)
   );

   TYPE t_numfmts_tab IS TABLE OF t_numfmt_rec
      INDEX BY PLS_INTEGER;

   TYPE t_fill_rec IS RECORD
   (
      vc_patterntype   VARCHAR2 (30),
      vc_fgrgb         VARCHAR2 (8)
   );

   TYPE t_fills_tab IS TABLE OF t_fill_rec
      INDEX BY PLS_INTEGER;

   TYPE t_cellxfs_tab IS TABLE OF t_xf_fmt_rec
      INDEX BY PLS_INTEGER;

   TYPE t_font_rec IS RECORD
   (
      vc_font_name   VARCHAR2 (100),
      pi_family      PLS_INTEGER,
      nn_fontsize    NUMBER,
      pi_theme       PLS_INTEGER,
      vc_rgb         VARCHAR2 (8),
      bo_underline   BOOLEAN,
      bo_italic      BOOLEAN,
      bo_bold        BOOLEAN
   );

   TYPE t_fonts_tab IS TABLE OF t_font_rec
      INDEX BY PLS_INTEGER;

   TYPE t_border_rec IS RECORD
   (
      vc_top_border      VARCHAR2 (17),
      vc_bottom_border   VARCHAR2 (17),
      vc_left_border     VARCHAR2 (17),
      vc_right_border    VARCHAR2 (17)
   );

   TYPE t_borders_tab IS TABLE OF t_border_rec
      INDEX BY PLS_INTEGER;

   TYPE t_numfmtindexes_tab IS TABLE OF PLS_INTEGER
      INDEX BY PLS_INTEGER;

   TYPE t_strings_tab IS TABLE OF PLS_INTEGER
      INDEX BY VARCHAR2 (32767 CHAR);

   TYPE t_str_ind_tab IS TABLE OF VARCHAR2 (32767 CHAR)
      INDEX BY PLS_INTEGER;

   TYPE t_defined_name_rec IS RECORD
   (
      vc_defined_name   VARCHAR2 (32767 CHAR),
      vc_defined_ref    VARCHAR2 (32767 CHAR),
      pi_sheet          PLS_INTEGER
   );

   TYPE t_defined_names_tab IS TABLE OF t_defined_name_rec
      INDEX BY PLS_INTEGER;

   TYPE t_book_rec IS RECORD
   (
      sheets_tab          t_sheets_tab,
      strings_tab         t_strings_tab,
      str_ind_tab         t_str_ind_tab,
      pi_str_cnt          PLS_INTEGER:= 0,
      fonts_tab           t_fonts_tab,
      fills_tab           t_fills_tab,
      borders_tab         t_borders_tab,
      numfmts_tab         t_numfmts_tab,
      cellxfs_tab         t_cellxfs_tab,
      numfmtindexes_tab   t_numfmtindexes_tab,
      defined_names_tab   t_defined_names_tab
   );

   /* Globals */
   -- the only global variable (objekt) without prefix and suffix
   workbook                               t_book_rec;

   --
   FUNCTION get_workbook
      RETURN t_book_rec
   AS
   BEGIN
      RETURN workbook;
   END get_workbook;

   /* Private API */
   /**
   * Procedure concatenates a VARCHAR2 to an CLOB.
   * It uses another VARCHAR2 as a buffer until it reaches 32767 characters.
   * Then it flushes the current buffer to the CLOB and resets the buffer using
   * the actual VARCHAR2 to add.
   * Your final call needs to be done setting p_eof to TRUE in order to
   * flush everything to the CLOB.
   *
   * @param p_clob        The CLOB you want to append to.
   * @param p_vc_buffer   The intermediate VARCHAR2 buffer. (must be VARCHAR2(32767))
   * @param p_vc_addition The VARCHAR2 value you want to append.
   * @param p_eof         Indicates if complete buffer should be flushed to CLOB.
   */
   PROCEDURE clob_vc_concat( p_clob IN OUT NOCOPY CLOB
                           , p_vc_buffer IN OUT NOCOPY VARCHAR2
                           , p_vc_addition IN VARCHAR2
                           , p_eof IN BOOLEAN DEFAULT FALSE
                           )
   AS
   BEGIN 
     -- Standard Flow
     IF NVL(LENGTHB(p_vc_buffer), 0) + NVL(LENGTHB(p_vc_addition), 0) < 32767 THEN
       p_vc_buffer := p_vc_buffer || p_vc_addition;
     ELSE
       IF p_clob IS NULL THEN
         dbms_lob.createtemporary(p_clob, TRUE);
       END IF;
       dbms_lob.writeappend(p_clob, LENGTH(p_vc_buffer), p_vc_buffer);
       p_vc_buffer := p_vc_addition;
     END IF;

     -- Full Flush requested
     IF p_eof THEN
       IF p_clob IS NULL THEN
         p_clob := p_vc_buffer;
       ELSE
         dbms_lob.writeappend(p_clob, LENGTH(p_vc_buffer), p_vc_buffer);
       END IF;
     p_vc_buffer := NULL;
     END IF;
   END clob_vc_concat;

   FUNCTION get_sheet_id (p_sheet IN PLS_INTEGER)
      RETURN PLS_INTEGER
   AS
   BEGIN
      RETURN NVL (p_sheet, workbook.sheets_tab.COUNT);
   END get_sheet_id;


   FUNCTION alfan_col (p_col PLS_INTEGER)
      RETURN VARCHAR2
   AS
   BEGIN
      RETURN CASE
                WHEN p_col > 702
                THEN
                      CHR (64 + TRUNC ( (p_col - 27) / 676))
                   || CHR (65 + MOD (TRUNC ( (p_col - 1) / 26) - 1, 26))
                   || CHR (65 + MOD (p_col - 1, 26))
                WHEN p_col > 26
                THEN
                   CHR (64 + TRUNC ( (p_col - 1) / 26)) || CHR (65 + MOD (p_col - 1, 26))
                ELSE
                   CHR (64 + p_col)
             END;
   END alfan_col;

   FUNCTION col_alfan (p_col VARCHAR2)
      RETURN PLS_INTEGER
   AS
   BEGIN
      RETURN   ASCII (SUBSTR (p_col, -1))
             - 64
             + NVL ( (ASCII (SUBSTR (p_col, -2, 1)) - 64) * 26, 0)
             + NVL ( (ASCII (SUBSTR (p_col, -3, 1)) - 64) * 676, 0);
   END col_alfan;

   -- EMORKLE (2014/02/24): Moved to top, allowing usage in new_sheet
   FUNCTION add_string (p_string VARCHAR2)
      RETURN PLS_INTEGER
   AS
      t_cnt   PLS_INTEGER;
   BEGIN
      -- MKLEIN (2014/02/24): Fix to handle NULL values
      IF p_string IS NULL AND workbook.strings_tab.COUNT > 0
      THEN
         RETURN 0;
      END IF;

      -- END Fix
      IF workbook.strings_tab.EXISTS (p_string)
      THEN
         t_cnt := workbook.strings_tab (p_string);
      ELSE
         t_cnt := workbook.strings_tab.COUNT;
         workbook.str_ind_tab (t_cnt) := p_string;
         workbook.strings_tab (NVL (p_string, '')) := t_cnt;
      END IF;

      workbook.pi_str_cnt := workbook.pi_str_cnt + 1;
      RETURN t_cnt;
   END add_string;

   PROCEDURE clear_workbook
   IS
      t_row_ind   PLS_INTEGER;
   BEGIN
      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.FIRST;

         WHILE t_row_ind IS NOT NULL
         LOOP
            workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).delete;
            t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.NEXT (t_row_ind);
         END LOOP;

         workbook.sheets_tab (s).sheet_rows_tab.delete;
         workbook.sheets_tab (s).widths_tab_tab.delete;
         workbook.sheets_tab (s).autofilters_tab.delete;
         workbook.sheets_tab (s).hyperlinks_tab.delete;
         workbook.sheets_tab (s).col_fmts_tab.delete;
         workbook.sheets_tab (s).row_fmts_tab.delete;
         workbook.sheets_tab (s).comments_tab.delete;
         workbook.sheets_tab (s).mergecells_tab.delete;
         workbook.sheets_tab (s).validations_tab.delete;
         workbook.sheets_tab (s).protection_tab.delete;
      END LOOP;

      workbook.strings_tab.delete;
      workbook.str_ind_tab.delete;
      workbook.fonts_tab.delete;
      workbook.fills_tab.delete;
      workbook.borders_tab.delete;
      workbook.numfmts_tab.delete;
      workbook.cellxfs_tab.delete;
      workbook.defined_names_tab.delete;
      workbook := NULL;
   END;

   --
   FUNCTION new_sheet (p_sheetname VARCHAR2 := NULL, p_hidden BOOLEAN := FALSE)
      RETURN PLS_INTEGER
   AS
      t_nr    PLS_INTEGER := workbook.sheets_tab.COUNT + 1;
      t_ind   PLS_INTEGER;
   BEGIN
      workbook.sheets_tab (t_nr).vc_sheet_name :=
         -- PHARTENFELLER(2019/09/18): Cut sheetname when too long (max 31 chars)
         COALESCE (
            SUBSTR( DBMS_XMLGEN.CONVERT (TRANSLATE (p_sheetname, 'a/\[]*:?', 'a')), 1, 31 )
         , 'Sheet' || TO_CHAR (t_nr)
         );

      workbook.sheets_tab (t_nr).hidden := p_hidden;

      IF workbook.strings_tab.COUNT = 0
      THEN
         workbook.pi_str_cnt := 0;
         -- MKLEIN (2014/02/24): Insert NULL into strings on known position
         t_ind := add_string (NULL);
      END IF;

      IF workbook.fonts_tab.COUNT = 0
      THEN
         t_ind := get_font ('Arial');
      END IF;

      IF workbook.fills_tab.COUNT = 0
      THEN
         t_ind := get_fill ('none');
         t_ind := get_fill ('gray125');
      END IF;

      IF workbook.borders_tab.COUNT = 0
      THEN
         t_ind :=
            get_border ('',
                        '',
                        '',
                        '');
      END IF;

      RETURN t_nr;
   END new_sheet;

   PROCEDURE sheet_protection (p_ssp_hash_value VARCHAR2, 
                               p_ssp_salt_value VARCHAR2,
                               p_sheet          PLS_INTEGER)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).hash_value := p_ssp_hash_value;
      workbook.sheets_tab (t_sheet).salt_value := p_ssp_salt_value;
   END sheet_protection;  

   PROCEDURE protected_range (p_name      VARCHAR2,
                              p_tl_col    PLS_INTEGER, -- top left
                              p_tl_row    PLS_INTEGER, 
                              p_br_col    PLS_INTEGER, -- bottom right
                              p_br_row    PLS_INTEGER, 
                              p_sheet     PLS_INTEGER)
   AS                            
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet); 
      t_ind := workbook.sheets_tab (t_sheet).protection_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_name   := p_name;
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_tl_col := alfan_col(p_tl_col);
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_tl_row := to_char(p_tl_row);
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_br_col := alfan_col(p_br_col);
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_br_row := to_char(p_br_row); 
   END protected_range;

   PROCEDURE set_col_width (p_sheet PLS_INTEGER, p_col PLS_INTEGER, p_format VARCHAR2)
   AS
      t_width    NUMBER;
      t_nr_chr   PLS_INTEGER;
   BEGIN
      IF p_format IS NULL
      THEN
         RETURN;
      END IF;

      IF INSTR (p_format, ';') > 0
      THEN
         t_nr_chr := LENGTH (TRANSLATE (SUBSTR (p_format, 1, INSTR (p_format, ';') - 1), 'a\"', 'a'));
      ELSE
         t_nr_chr := LENGTH (TRANSLATE (p_format, 'a\"', 'a'));
      END IF;

      t_width := TRUNC ( (t_nr_chr * 7 + 5) / 7 * 256) / 256;                                             -- assume default 11 point Calibri

      IF workbook.sheets_tab (p_sheet).widths_tab_tab.EXISTS (p_col)
      THEN
         workbook.sheets_tab (p_sheet).widths_tab_tab (p_col) := GREATEST (workbook.sheets_tab (p_sheet).widths_tab_tab (p_col), t_width);
      ELSE
         workbook.sheets_tab (p_sheet).widths_tab_tab (p_col) := GREATEST (t_width, 8.43);
      END IF;
   END set_col_width;


   FUNCTION orafmt2excel (p_format VARCHAR2 := NULL)
      RETURN VARCHAR2
   AS
      t_format   VARCHAR2 (1000) := LOWER (SUBSTR (p_format, 1, 1000));
   BEGIN
      t_format := REPLACE (REPLACE (REPLACE (t_format, 'HH', 'hh'), 'hh24', 'hh'), 'hh12', 'hh');
      t_format := REPLACE (REPLACE (t_format, 'MI', 'mi'), 'mi', 'mm');
      t_format := REPLACE (REPLACE (REPLACE (t_format, 'AM', '~~'), 'PM', '~~'), '~~', 'AM/PM');
      t_format := REPLACE (REPLACE (REPLACE (t_format, 'am', '~~'), 'pm', '~~'), '~~', 'AM/PM');
      t_format := REPLACE (REPLACE (t_format, 'day', 'DAY'), 'DAY', 'dddd');
      t_format := REPLACE (REPLACE (t_format, 'dy', 'DY'), 'DAY', 'ddd');
      t_format := REPLACE (REPLACE (t_format, 'rr', 'RR'), 'RR', 'YY');
      t_format := REPLACE (REPLACE (t_format, 'month', 'MONTH'), 'MONTH', 'mmmm');
      t_format := REPLACE (REPLACE (t_format, 'mon', 'MON'), 'MON', 'mmm');
      RETURN t_format;
   END orafmt2excel;

   FUNCTION oradatetoexcel (p_value IN DATE)
      RETURN NUMBER
   AS
      l_date_diff   NUMBER := 0;
   BEGIN
      IF TRUNC (p_value) >= TO_DATE ('01-01-1900', 'MM-DD-YYYY')
      THEN
         l_date_diff := 2;
      END IF;

      RETURN ( ( p_value - TO_DATE ('01-01-1900', 'MM-DD-YYYY') ) + l_date_diff );
   END oradatetoexcel;

   FUNCTION oranumfmt2excel (p_format VARCHAR2)
      RETURN VARCHAR2
   AS
      l_mso_fmt   VARCHAR2 (255);
   BEGIN
      IF INSTR (p_format, 'D') > 0
      THEN
         l_mso_fmt := '.' || REPLACE (SUBSTR (p_format, INSTR (p_format, 'D') + 1), '9', '0');
      END IF;

      IF INSTR (p_format, 'G') > 0
      THEN
         l_mso_fmt := '#,##0' || l_mso_fmt;
      ELSE
         l_mso_fmt := '0' || l_mso_fmt;
      END IF;

      RETURN l_mso_fmt;
   END oranumfmt2excel;

   FUNCTION get_numfmt (p_format VARCHAR2 := NULL)
      RETURN PLS_INTEGER
   AS
      t_cnt        PLS_INTEGER;
      t_numfmtid   PLS_INTEGER;
   BEGIN
      IF p_format IS NULL
      THEN
         RETURN 0;
      END IF;

      t_cnt := workbook.numfmts_tab.COUNT;

      FOR i IN 1 .. t_cnt
      LOOP
         IF workbook.numfmts_tab (i).vc_formatcode = p_format
         THEN
            t_numfmtid := workbook.numfmts_tab (i).pi_numfmtid;
            EXIT;
         END IF;
      END LOOP;

      IF t_numfmtid IS NULL
      THEN
         t_numfmtid := CASE WHEN t_cnt = 0 THEN 164 ELSE workbook.numfmts_tab (t_cnt).pi_numfmtid + 1 END;
         t_cnt := t_cnt + 1;
         workbook.numfmts_tab (t_cnt).pi_numfmtid := t_numfmtid;
         workbook.numfmts_tab (t_cnt).vc_formatcode := p_format;
         workbook.numfmtindexes_tab (t_numfmtid) := t_cnt;
      END IF;

      RETURN t_numfmtid;
   END get_numfmt;


   FUNCTION get_font (p_name         VARCHAR2,
                      p_family       PLS_INTEGER := 2,
                      p_fontsize     NUMBER := 8,
                      p_theme        PLS_INTEGER := 1,
                      p_underline    BOOLEAN := FALSE,
                      p_italic       BOOLEAN := FALSE,
                      p_bold         BOOLEAN := FALSE,
                      p_rgb          VARCHAR2 := NULL                                            -- this is a hex ALPHA Red Green Blue value
                                                     )
      RETURN PLS_INTEGER
   AS
      t_ind   PLS_INTEGER;
   BEGIN
      IF workbook.fonts_tab.COUNT > 0
      THEN
         FOR f IN 0 .. workbook.fonts_tab.COUNT - 1
         LOOP
            IF (    workbook.fonts_tab (f).vc_font_name = p_name
                AND workbook.fonts_tab (f).pi_family = p_family
                AND workbook.fonts_tab (f).nn_fontsize = p_fontsize
                AND workbook.fonts_tab (f).pi_theme = p_theme
                AND workbook.fonts_tab (f).bo_underline = p_underline
                AND workbook.fonts_tab (f).bo_italic = p_italic
                AND workbook.fonts_tab (f).bo_bold = p_bold
                AND (workbook.fonts_tab (f).vc_rgb = p_rgb OR (workbook.fonts_tab (f).vc_rgb IS NULL AND p_rgb IS NULL)))
            THEN
               RETURN f;
            END IF;
         END LOOP;
      END IF;

      t_ind := workbook.fonts_tab.COUNT;
      workbook.fonts_tab (t_ind).vc_font_name := p_name;
      workbook.fonts_tab (t_ind).pi_family := p_family;
      workbook.fonts_tab (t_ind).nn_fontsize := p_fontsize;
      workbook.fonts_tab (t_ind).pi_theme := p_theme;
      workbook.fonts_tab (t_ind).bo_underline := p_underline;
      workbook.fonts_tab (t_ind).bo_italic := p_italic;
      workbook.fonts_tab (t_ind).bo_bold := p_bold;
      workbook.fonts_tab (t_ind).vc_rgb := p_rgb;
      RETURN t_ind;
   END get_font;

   FUNCTION get_fill (p_patterntype VARCHAR2, p_fgrgb VARCHAR2 := NULL)
      RETURN PLS_INTEGER
   AS
      t_ind   PLS_INTEGER;
   BEGIN
      IF workbook.fills_tab.COUNT > 0
      THEN
         FOR f IN 0 .. workbook.fills_tab.COUNT - 1
         LOOP
            IF (    workbook.fills_tab (f).vc_patterntype = p_patterntype
                AND NVL (workbook.fills_tab (f).vc_fgrgb, 'x') = NVL (UPPER (p_fgrgb), 'x'))
            THEN
               RETURN f;
            END IF;
         END LOOP;
      END IF;

      t_ind := workbook.fills_tab.COUNT;
      workbook.fills_tab (t_ind).vc_patterntype := p_patterntype;
      workbook.fills_tab (t_ind).vc_fgrgb := UPPER (p_fgrgb);
      RETURN t_ind;
   END get_fill;

   FUNCTION get_border (p_top       VARCHAR2 := 'thin',
                        p_bottom    VARCHAR2 := 'thin',
                        p_left      VARCHAR2 := 'thin',
                        p_right     VARCHAR2 := 'thin')
      RETURN PLS_INTEGER
   AS
      t_ind   PLS_INTEGER;
   BEGIN
      IF workbook.borders_tab.COUNT > 0
      THEN
         FOR b IN 0 .. workbook.borders_tab.COUNT - 1
         LOOP
            IF (    NVL (workbook.borders_tab (b).vc_top_border, 'x') = NVL (p_top, 'x')
                AND NVL (workbook.borders_tab (b).vc_bottom_border, 'x') = NVL (p_bottom, 'x')
                AND NVL (workbook.borders_tab (b).vc_left_border, 'x') = NVL (p_left, 'x')
                AND NVL (workbook.borders_tab (b).vc_right_border, 'x') = NVL (p_right, 'x'))
            THEN
               RETURN b;
            END IF;
         END LOOP;
      END IF;

      t_ind := workbook.borders_tab.COUNT;
      workbook.borders_tab (t_ind).vc_top_border := p_top;
      workbook.borders_tab (t_ind).vc_bottom_border := p_bottom;
      workbook.borders_tab (t_ind).vc_left_border := p_left;
      workbook.borders_tab (t_ind).vc_right_border := p_right;
      RETURN t_ind;
   END get_border;

   FUNCTION get_alignment (p_vertical VARCHAR2 := NULL, p_horizontal VARCHAR2 := NULL, p_wraptext BOOLEAN := NULL)
      RETURN t_alignment_rec
   AS
      t_rv   t_alignment_rec;
   BEGIN
      t_rv.vc_vertical := p_vertical;
      t_rv.vc_horizontal := p_horizontal;
      t_rv.bo_wraptext := p_wraptext;
      RETURN t_rv;
   END get_alignment;

   FUNCTION get_xfid (p_sheet        PLS_INTEGER,
                      p_col          PLS_INTEGER,
                      p_row          PLS_INTEGER,
                      p_numfmtid     PLS_INTEGER := NULL,
                      p_fontid       PLS_INTEGER := NULL,
                      p_fillid       PLS_INTEGER := NULL,
                      p_borderid     PLS_INTEGER := NULL,
                      p_alignment    t_alignment_rec := NULL)
      RETURN VARCHAR2
   AS
      t_cnt      PLS_INTEGER;
      t_xfid     PLS_INTEGER;
      t_xf       t_xf_fmt_rec;
      t_col_xf   t_xf_fmt_rec;
      t_row_xf   t_xf_fmt_rec;
   BEGIN

      IF workbook.sheets_tab (p_sheet).col_fmts_tab.EXISTS (p_col)
      THEN
         t_col_xf := workbook.sheets_tab (p_sheet).col_fmts_tab (p_col);
      END IF;

      IF workbook.sheets_tab (p_sheet).row_fmts_tab.EXISTS (p_row)
      THEN
         t_row_xf := workbook.sheets_tab (p_sheet).row_fmts_tab (p_row);
      END IF;

      --apex_debug.info('col: ' || p_col || ' row: ' || p_row || ' p_numfmtid: ' || p_numfmtid || ' col_numfmtid: ' ||  t_col_xf.pi_numfmtid);

      t_xf.pi_numfmtid :=
         COALESCE (p_numfmtid,
                   t_col_xf.pi_numfmtid,
                   t_row_xf.pi_numfmtid,
                   0);
      t_xf.pi_fontid :=
         COALESCE (p_fontid,
                   t_col_xf.pi_fontid,
                   t_row_xf.pi_fontid,
                   0);
      t_xf.pi_fillid :=
         COALESCE (p_fillid,
                   t_col_xf.pi_fillid,
                   t_row_xf.pi_fillid,
                   0);
      t_xf.pi_borderid :=
         COALESCE (p_borderid,
                   t_col_xf.pi_borderid,
                   t_row_xf.pi_borderid,
                   0);
      t_xf.alignment_rec := COALESCE (p_alignment, t_col_xf.alignment_rec, t_row_xf.alignment_rec);

      IF (    t_xf.pi_numfmtid + t_xf.pi_fontid + t_xf.pi_fillid + t_xf.pi_borderid = 0
          AND t_xf.alignment_rec.vc_vertical IS NULL
          AND t_xf.alignment_rec.vc_horizontal IS NULL
          AND NOT NVL (t_xf.alignment_rec.bo_wraptext, FALSE))
      THEN
         RETURN '';
      END IF;

      IF t_xf.pi_numfmtid > 0
      THEN
         set_col_width (p_sheet, p_col, workbook.numfmts_tab (workbook.numfmtindexes_tab (t_xf.pi_numfmtid)).vc_formatcode);
      END IF;

      t_cnt := workbook.cellxfs_tab.COUNT;

      FOR i IN 1 .. t_cnt
      LOOP
         IF (    workbook.cellxfs_tab (i).pi_numfmtid = t_xf.pi_numfmtid
             AND workbook.cellxfs_tab (i).pi_fontid = t_xf.pi_fontid
             AND workbook.cellxfs_tab (i).pi_fillid = t_xf.pi_fillid
             AND workbook.cellxfs_tab (i).pi_borderid = t_xf.pi_borderid
             AND NVL (workbook.cellxfs_tab (i).alignment_rec.vc_vertical, 'x') = NVL (t_xf.alignment_rec.vc_vertical, 'x')
             AND NVL (workbook.cellxfs_tab (i).alignment_rec.vc_horizontal, 'x') = NVL (t_xf.alignment_rec.vc_horizontal, 'x')
             AND NVL (workbook.cellxfs_tab (i).alignment_rec.bo_wraptext, FALSE) = NVL (t_xf.alignment_rec.bo_wraptext, FALSE))
         THEN
            t_xfid := i;
            EXIT;
         END IF;
      END LOOP;

      IF t_xfid IS NULL
      THEN
         t_cnt := t_cnt + 1;
         t_xfid := t_cnt;
         workbook.cellxfs_tab (t_cnt) := t_xf;
      END IF;

      RETURN 's="' || TO_CHAR (t_xfid) || '"';
   END get_xfid;

   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        NUMBER,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).nn_value_id := p_value;
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def := NULL;
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def :=
         get_xfid (t_sheet,
                   p_col,
                   p_row,
                   p_numfmtid,
                   p_fontid,
                   p_fillid,
                   p_borderid,
                   p_alignment);
   END cell;

   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        VARCHAR2,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL,
                   p_formula      VARCHAR2 := NULL)
   AS
      t_sheet       PLS_INTEGER;
      t_alignment   t_alignment_rec := p_alignment;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).nn_value_id := add_string (p_value);
      
      --THERWIX(2020/07/06): Allow to add Formulas into a cell
      IF p_formula IS NOT NULL 
      THEN
         workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).formula :=  (p_formula);
      END IF; 

      IF t_alignment.bo_wraptext IS NULL AND INSTR (p_value, CHR (13)) > 0
      THEN
         t_alignment.bo_wraptext := TRUE;
      END IF;

      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def :=
            't="s" '
         || get_xfid (t_sheet,
                      p_col,
                      p_row,
                      p_numfmtid,
                      p_fontid,
                      p_fillid,
                      p_borderid,
                      t_alignment);
   END cell;

   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        DATE,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL)
   AS
      t_numfmtid   PLS_INTEGER := p_numfmtid;
      t_sheet      PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);

      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).nn_value_id := oradatetoexcel (p_value);

      IF     t_numfmtid IS NULL
         AND NOT (    workbook.sheets_tab (t_sheet).col_fmts_tab.EXISTS (p_col)
                  AND workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_numfmtid IS NOT NULL)
         AND NOT (    workbook.sheets_tab (t_sheet).row_fmts_tab.EXISTS (p_row)
                  AND workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).pi_numfmtid IS NOT NULL)
      THEN
         t_numfmtid := get_numfmt ('dd/mm/yyyy');
      END IF;

      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def :=
         get_xfid (t_sheet,
                   p_col,
                   p_row,
                   t_numfmtid,
                   p_fontid,
                   p_fillid,
                   p_borderid,
                   p_alignment);
   END cell;

   PROCEDURE hyperlink (p_col      PLS_INTEGER,
                        p_row      PLS_INTEGER,
                        p_url      VARCHAR2,
                        p_value    VARCHAR2 := NULL,
                        p_sheet    PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);

      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).nn_value_id := add_string (NVL (p_value, p_url));
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def :=
            't="s" '
         || get_xfid (t_sheet,
                      p_col,
                      p_row,
                      '',
                      get_font ('Calibri', p_theme => 10, p_underline => TRUE));
      t_ind := workbook.sheets_tab (t_sheet).hyperlinks_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).hyperlinks_tab (t_ind).vc_cell := alfan_col (p_col) || TO_CHAR (p_row);
      workbook.sheets_tab (t_sheet).hyperlinks_tab (t_ind).vc_url := p_url;
   END hyperlink;

   PROCEDURE comment (p_col       PLS_INTEGER,
                      p_row       PLS_INTEGER,
                      p_text      VARCHAR2,
                      p_author    VARCHAR2 := NULL,
                      p_width     PLS_INTEGER := 150,
                      p_height    PLS_INTEGER := 100,
                      p_sheet     PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := workbook.sheets_tab (t_sheet).comments_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).pi_row_nr := p_row;
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).pi_column_nr := p_col;
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).vc_text := DBMS_XMLGEN.CONVERT (p_text);
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).vc_author := DBMS_XMLGEN.CONVERT (p_author);
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).pi_width := p_width;
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).pi_height := p_height;
   END comment;

   PROCEDURE mergecells (p_tl_col    PLS_INTEGER                                                                                 -- top left
                                                ,
                         p_tl_row    PLS_INTEGER,
                         p_br_col    PLS_INTEGER                                                                             -- bottom right
                                                ,
                         p_br_row    PLS_INTEGER,
                         p_sheet     PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := workbook.sheets_tab (t_sheet).mergecells_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).mergecells_tab (t_ind) :=
         alfan_col (p_tl_col) || TO_CHAR (p_tl_row) || ':' || alfan_col (p_br_col) || TO_CHAR (p_br_row);
   END mergecells;

   PROCEDURE add_validation (p_type           VARCHAR2,
                             p_sqref          VARCHAR2,
                             p_style          VARCHAR2 := 'stop'                                               -- stop, warning, information
                                                                ,
                             p_formula1       VARCHAR2 := NULL,
                             p_formula2       VARCHAR2 := NULL,
                             p_title          VARCHAR2 := NULL,
                             p_prompt         VARCHAR2 := NULL,
                             p_show_error     BOOLEAN := FALSE,
                             p_error_title    VARCHAR2 := NULL,
                             p_error_txt      VARCHAR2 := NULL,
                             p_sheet          PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := workbook.sheets_tab (t_sheet).validations_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_validation_type := p_type;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_errorstyle := p_style;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_sqref := p_sqref;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_formula1 := p_formula1;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_formula2 := p_formula2;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_error_title := p_error_title;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_error_txt := p_error_txt;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_title := p_title;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_prompt := p_prompt;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).bo_showerrormessage := p_show_error;
   END add_validation;

   PROCEDURE list_validation (p_sqref_col      PLS_INTEGER,
                              p_sqref_row      PLS_INTEGER,
                              p_tl_col         PLS_INTEGER                                                                       -- top left
                                                          ,
                              p_tl_row         PLS_INTEGER,
                              p_br_col         PLS_INTEGER                                                                   -- bottom right
                                                          ,
                              p_br_row         PLS_INTEGER,
                              p_style          VARCHAR2 := 'stop'                                              -- stop, warning, information
                                                                 ,
                              p_title          VARCHAR2 := NULL,
                              p_prompt         VARCHAR2 := NULL,
                              p_show_error     BOOLEAN := FALSE,
                              p_error_title    VARCHAR2 := NULL,
                              p_error_txt      VARCHAR2 := NULL,
                              p_sheet          PLS_INTEGER := NULL,
                              p_sheet_datasource PLS_INTEGER := NULL)
   AS
      c_single_quote constant varchar2(1) := '''';
   BEGIN
      -- PHARTENFELLER(2019/09/24): Allow listvalidations with data from a different sheet
      IF p_sheet_datasource IS NULL THEN
         add_validation (
            'list',
            alfan_col (p_sqref_col) || TO_CHAR (p_sqref_row),
            p_style         => LOWER (p_style),
            p_formula1      =>    '$'
                              || alfan_col (p_tl_col)
                              || '$'
                              || TO_CHAR (p_tl_row)
                              || ':$'
                              || alfan_col (p_br_col)
                              || '$'
                              || TO_CHAR (p_br_row),
            p_title         => p_title,
            p_prompt        => p_prompt,
            p_show_error    => p_show_error,
            p_error_title   => p_error_title,
            p_error_txt     => p_error_txt,
            p_sheet         => p_sheet);
      ELSE
         add_validation (
            'list',
            alfan_col (p_sqref_col) || TO_CHAR (p_sqref_row),
            p_style         => LOWER (p_style),
            p_formula1      =>   c_single_quote
                              || workbook.sheets_tab(p_sheet_datasource).vc_sheet_name
                              || c_single_quote
                              || '!$'
                              || alfan_col (p_tl_col)
                              || '$'
                              || TO_CHAR (p_tl_row)
                              || ':$'
                              || alfan_col (p_br_col)
                              || '$'
                              || TO_CHAR (p_br_row),
            p_title         => p_title,
            p_prompt        => p_prompt,
            p_show_error    => p_show_error,
            p_error_title   => p_error_title,
            p_error_txt     => p_error_txt,
            p_sheet         => p_sheet);
      END IF;
   END list_validation;

   PROCEDURE list_validation (p_sqref_col       PLS_INTEGER,
                              p_sqref_row       PLS_INTEGER,
                              p_defined_name    VARCHAR2,
                              p_style           VARCHAR2 := 'stop'                                             -- stop, warning, information
                                                                  ,
                              p_title           VARCHAR2 := NULL,
                              p_prompt          VARCHAR2 := NULL,
                              p_show_error      BOOLEAN := FALSE,
                              p_error_title     VARCHAR2 := NULL,
                              p_error_txt       VARCHAR2 := NULL,
                              p_sheet           PLS_INTEGER := NULL)
   AS
   BEGIN
      add_validation ('list',
                      alfan_col (p_sqref_col) || TO_CHAR (p_sqref_row),
                      p_style         => LOWER (p_style),
                      p_formula1      => p_defined_name,
                      p_title         => p_title,
                      p_prompt        => p_prompt,
                      p_show_error    => p_show_error,
                      p_error_title   => p_error_title,
                      p_error_txt     => p_error_txt,
                      p_sheet         => TO_CHAR (p_sheet));
   END list_validation;

   PROCEDURE defined_name (p_tl_col        PLS_INTEGER                                                                           -- top left
                                                      ,
                           p_tl_row        PLS_INTEGER,
                           p_br_col        PLS_INTEGER                                                                       -- bottom right
                                                      ,
                           p_br_row        PLS_INTEGER,
                           p_name          VARCHAR2,
                           p_sheet         PLS_INTEGER := NULL,
                           p_localsheet    PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := workbook.defined_names_tab.COUNT + 1;
      workbook.defined_names_tab (t_ind).vc_defined_name := p_name;
      workbook.defined_names_tab (t_ind).vc_defined_ref :=
            'Sheet'
         || TO_CHAR (t_sheet)
         || '!$'
         || alfan_col (p_tl_col)
         || '$'
         || TO_CHAR (p_tl_row)
         || ':$'
         || alfan_col (p_br_col)
         || '$'
         || TO_CHAR (p_br_row);
      workbook.defined_names_tab (t_ind).pi_sheet := p_localsheet;
   END defined_name;

   PROCEDURE set_column_width (p_col PLS_INTEGER, p_width NUMBER, p_sheet PLS_INTEGER := NULL)
   AS
   BEGIN
      workbook.sheets_tab (NVL (p_sheet, workbook.sheets_tab.COUNT)).widths_tab_tab (p_col) := p_width;
   END set_column_width;

   PROCEDURE set_column (p_col          PLS_INTEGER,
                         p_numfmtid     PLS_INTEGER := NULL,
                         p_fontid       PLS_INTEGER := NULL,
                         p_fillid       PLS_INTEGER := NULL,
                         p_borderid     PLS_INTEGER := NULL,
                         p_alignment    t_alignment_rec := NULL,
                         p_sheet        PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
      returnVal VARCHAR2(20);

   BEGIN
      t_sheet := get_sheet_id (p_sheet);     
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_numfmtid := p_numfmtid;
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_fontid := p_fontid;
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_fillid := p_fillid;
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_borderid := p_borderid;
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).alignment_rec := p_alignment;

   END set_column;

   PROCEDURE set_row (p_row          PLS_INTEGER,
                      p_numfmtid     PLS_INTEGER := NULL,
                      p_fontid       PLS_INTEGER := NULL,
                      p_fillid       PLS_INTEGER := NULL,
                      p_borderid     PLS_INTEGER := NULL,
                      p_alignment    t_alignment_rec := NULL,
                      p_sheet        PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab(t_sheet).row_fmts_tab(p_row).pi_numfmtid := p_numfmtid;
      workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).pi_fontid := p_fontid;
      workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).pi_fillid := p_fillid;
      workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).pi_borderid := p_borderid;
      workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).alignment_rec := p_alignment;
   END set_row;

   PROCEDURE freeze_rows (p_nr_rows PLS_INTEGER := 1, p_sheet PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).pi_freeze_cols := NULL;
      workbook.sheets_tab (t_sheet).pi_freeze_rows := p_nr_rows;
   END freeze_rows;

   PROCEDURE freeze_cols (p_nr_cols PLS_INTEGER := 1, p_sheet PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).pi_freeze_rows := NULL;
      workbook.sheets_tab (t_sheet).pi_freeze_cols := p_nr_cols;
   END freeze_cols;

   PROCEDURE freeze_pane (p_col PLS_INTEGER, p_row PLS_INTEGER, p_sheet PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).pi_freeze_rows := p_row;
      workbook.sheets_tab (t_sheet).pi_freeze_cols := p_col;
   END freeze_pane;

   PROCEDURE set_autofilter (p_column_start    PLS_INTEGER := NULL,
                             p_column_end      PLS_INTEGER := NULL,
                             p_row_start       PLS_INTEGER := NULL,
                             p_row_end         PLS_INTEGER := NULL,
                             p_sheet           PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := 1;
      workbook.sheets_tab (t_sheet).autofilters_tab (t_ind).pi_column_start := p_column_start;
      workbook.sheets_tab (t_sheet).autofilters_tab (t_ind).pi_column_end := p_column_end;
      workbook.sheets_tab (t_sheet).autofilters_tab (t_ind).pi_row_start := p_row_start;
      workbook.sheets_tab (t_sheet).autofilters_tab (t_ind).pi_row_end := p_row_end;
      defined_name (p_column_start,
                    p_row_start,
                    p_column_end,
                    p_row_end,
                    '_xlnm._FilterDatabase',
                    t_sheet,
                    t_sheet - 1);
   END set_autofilter;

   FUNCTION finish 
      RETURN BLOB
   AS
      t_excel                      BLOB;
      t_xxx                        CLOB;
      t_tmp                        VARCHAR2 (32767 CHAR);
      t_str                        VARCHAR2 (32767 CHAR);
      t_c                          NUMBER;
      t_h                          NUMBER;
      t_w                          NUMBER;
      t_cw                         NUMBER;
      t_cell                       VARCHAR2 (1000 CHAR);
      t_row_ind                    PLS_INTEGER;
      t_col_min                    PLS_INTEGER;
      t_col_max                    PLS_INTEGER;
      t_col_ind                    PLS_INTEGER;
      t_len                        PLS_INTEGER;
   BEGIN
      DBMS_LOB.createtemporary (t_excel, TRUE);
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
<Default Extension="xml" ContentType="application/xml"/>
<Default Extension="vml" ContentType="application/vnd.openxmlformats-officedocument.vmlDrawing"/>
<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<Override PartName="/xl/worksheets/sheet'
                          || TO_CHAR (s)
                          || '.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '
<Override PartName="/xl/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>
<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
<Override PartName="/xl/sharedStrings.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml"/>
<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         IF workbook.sheets_tab (s).comments_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<Override PartName="/xl/comments'
                             || TO_CHAR (s)
                             || '.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.comments+xml"/>');
         END IF;
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</Types>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, '[Content_Types].xml', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<dc:creator>'
                       || SYS_CONTEXT ('userenv', 'os_user')
                       || '</dc:creator>
<cp:lastModifiedBy>'
                       || SYS_CONTEXT ('userenv', 'os_user')
                       || '</cp:lastModifiedBy>
<dcterms:created xsi:type="dcterms:W3CDTF">'
                       || TO_CHAR (CURRENT_TIMESTAMP, 'yyyy-mm-dd"T"hh24:mi:ssTZH:TZM')
                       || '</dcterms:created>
<dcterms:modified xsi:type="dcterms:W3CDTF">'
                       || TO_CHAR (CURRENT_TIMESTAMP, 'yyyy-mm-dd"T"hh24:mi:ssTZH:TZM')
                       || '</dcterms:modified>
</cp:coreProperties>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'docProps/core.xml', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
<Application>Microsoft Excel</Application>
<DocSecurity>0</DocSecurity>
<HeadingPairs>
<vt:vector size="2" baseType="variant">
<vt:variant>
<vt:lpstr>Worksheets</vt:lpstr>
</vt:variant>
<vt:variant>
<vt:i4>'
                       || TO_CHAR (workbook.sheets_tab.COUNT)
                       || '</vt:i4>  
</vt:variant>
</vt:vector>
</HeadingPairs>
<TitlesOfParts>
<vt:vector size="'
                       || TO_CHAR (workbook.sheets_tab.COUNT)
                       || '" baseType="lpstr">');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<vt:lpstr>' || workbook.sheets_tab (s).vc_sheet_name || '</vt:lpstr>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</vt:vector>
</TitlesOfParts>
<AppVersion>14.0300</AppVersion>
</Properties>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'docProps/app.xml', t_xxx);
      t_xxx := NULL;
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>
<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>
<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>
</Relationships>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, '_rels/.rels', t_xxx);
      t_xxx := NULL;
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                       || chr(13) || chr(10) 
                       || '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">');

      IF workbook.numfmts_tab.COUNT > 0
      THEN
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<numFmts count="' || TO_CHAR (workbook.numfmts_tab.COUNT) || '">');

         FOR n IN 1 .. workbook.numfmts_tab.COUNT
         LOOP
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<numFmt numFmtId="'
                             || TO_CHAR (workbook.numfmts_tab (n).pi_numfmtid)
                             || '" formatCode="'
                             || workbook.numfmts_tab (n).vc_formatcode
                             || '"/>');
         END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</numFmts>');
      END IF;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<fonts count="' || TO_CHAR (workbook.fonts_tab.COUNT) || '" x14ac:knownFonts="1">');

      FOR f IN 0 .. workbook.fonts_tab.COUNT - 1
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<font>'
                          || CASE WHEN workbook.fonts_tab (f).bo_bold THEN '<b/>' END
                          || CASE WHEN workbook.fonts_tab (f).bo_italic THEN '<i/>' END
                          || CASE WHEN workbook.fonts_tab (f).bo_underline THEN '<u/>' END
                          || '<sz val="'
                          || TO_CHAR (workbook.fonts_tab (f).nn_fontsize, 'TM9', 'NLS_NUMERIC_CHARACTERS=.,')
                          || '"/>
                             <color '
                          || CASE
                                WHEN workbook.fonts_tab (f).vc_rgb IS NOT NULL THEN 'rgb="' || workbook.fonts_tab (f).vc_rgb
                                ELSE 'theme="' || TO_CHAR (workbook.fonts_tab (f).pi_theme)
                             END
                          || '"/>
                             <name val="'
                          || workbook.fonts_tab (f).vc_font_name
                          || '"/>
                             <family val="'
                          || TO_CHAR (workbook.fonts_tab (f).pi_family)
                          || '"/>
                             <scheme val="none"/>
                             </font>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</fonts><fills count="' || TO_CHAR (workbook.fills_tab.COUNT) || '">');

      FOR f IN 0 .. workbook.fills_tab.COUNT - 1
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<fill><patternFill patternType="'
                          || workbook.fills_tab (f).vc_patterntype
                          || '">'
                          || CASE WHEN workbook.fills_tab (f).vc_fgrgb IS NOT NULL THEN '<fgColor rgb="' || workbook.fills_tab (f).vc_fgrgb || '"/>' END
                          || '</patternFill></fill>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</fills>
<borders count="' || TO_CHAR (workbook.borders_tab.COUNT) || '">');

      FOR b IN 0 .. workbook.borders_tab.COUNT - 1
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<border>'
                          || CASE
                                WHEN workbook.borders_tab (b).vc_left_border IS NULL THEN '<left/>'
                                ELSE '<left style="' || workbook.borders_tab (b).vc_left_border || '"/>'
                             END
                          || CASE
                                WHEN workbook.borders_tab (b).vc_right_border IS NULL THEN '<right/>'
                                ELSE '<right style="' || workbook.borders_tab (b).vc_right_border || '"/>'
                             END
                          || CASE
                                WHEN workbook.borders_tab (b).vc_top_border IS NULL THEN '<top/>'
                                ELSE '<top style="' || workbook.borders_tab (b).vc_top_border || '"/>'
                             END
                          || CASE
                                WHEN workbook.borders_tab (b).vc_bottom_border IS NULL THEN '<bottom/>'
                                ELSE '<bottom style="' || workbook.borders_tab (b).vc_bottom_border || '"/>'
                             END
                          || '</border>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</borders>

<cellStyleXfs count="1">
<xf numFmtId="0" fontId="0" fillId="0" borderId="0" />
</cellStyleXfs>
<cellXfs count="' || (workbook.cellxfs_tab.COUNT() + 1) || '">
<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="1" />');
      FOR x IN 1 .. workbook.cellxfs_tab.COUNT
      LOOP
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<xf numFmtId="'
                       --|| '0' --TO_CHAR (workbook.cellxfs_tab (x).pi_numfmtid)
                       || TO_CHAR (workbook.cellxfs_tab (x).pi_numfmtid)
                       || '" fontId="'
                       || TO_CHAR (workbook.cellxfs_tab (x).pi_fontid)
                       || '" fillId="'
                       || TO_CHAR (workbook.cellxfs_tab (x).pi_fillid)
                       || '" borderId="'
                       || TO_CHAR (workbook.cellxfs_tab (x).pi_borderid)
                       || '">');                    

       IF (   workbook.cellxfs_tab (x).alignment_rec.vc_horizontal IS NOT NULL
             OR workbook.cellxfs_tab (x).alignment_rec.vc_vertical IS NOT NULL
             OR workbook.cellxfs_tab (x).alignment_rec.bo_wraptext)
         THEN
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<alignment'
                       || CASE
                             WHEN workbook.cellxfs_tab (x).alignment_rec.vc_horizontal IS NOT NULL
                             THEN ' horizontal="' || workbook.cellxfs_tab (x).alignment_rec.vc_horizontal || '"'
                          END
                       || CASE
                             WHEN workbook.cellxfs_tab (x).alignment_rec.vc_vertical IS NOT NULL
                             THEN ' vertical="' || workbook.cellxfs_tab (x).alignment_rec.vc_vertical || '"'
                          END
                       || CASE WHEN workbook.cellxfs_tab (x).alignment_rec.bo_wraptext
                               THEN ' wrapText="true"'
                          END
                       || '/>');
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '</xf>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</cellXfs>
<cellStyles count="1">
<cellStyle name="Normal" xfId="0" builtinId="0"/>
</cellStyles>                      
<dxfs count="0"/>
<tableStyles count="0" defaultTableStyle="TableStyleMedium2" defaultPivotStyle="PivotStyleLight16"/>
<extLst>
<ext uri="{EB79DEF2-80B8-43e5-95BD-54CBDDF9020C}" xmlns:x14="http://schemas.microsoft.com/office/spreadsheetml/2009/9/main">
<x14:slicerStyles defaultSlicerStyle="SlicerStyleLight1"/>
</ext>
</extLst>
</styleSheet>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/styles.xml', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<fileVersion appName="xl" lastEdited="5" lowestEdited="5" rupBuild="9302"/>
<workbookPr date1904="false" defaultThemeVersion="124226"/>
<bookViews>
<workbookView xWindow="120" yWindow="45" windowWidth="19155" windowHeight="4935"/>
</bookViews>
<sheets>');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         -- PHARTENFELLER(2019/09/23) added option to hide sheet
         IF NOT workbook.sheets_tab (s).hidden then
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<sheet name="'
                           || workbook.sheets_tab (s).vc_sheet_name
                           || '" sheetId="'
                           || TO_CHAR (s)
                           || '" r:id="rId'
                           || TO_CHAR (9 + s)
                           || '"/>');
         ELSE
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<sheet name="'
                           || workbook.sheets_tab (s).vc_sheet_name
                           || '" sheetId="'
                           || TO_CHAR (s)
                           || '" state="hidden" '
                           || 'r:id="rId'
                           || TO_CHAR (9 + s)
                           || '"/>');
         END IF;
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</sheets>');

      IF workbook.defined_names_tab.COUNT > 0
      THEN
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<definedNames>');

         FOR s IN 1 .. workbook.defined_names_tab.COUNT
         LOOP
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<definedName name="'
                             || workbook.defined_names_tab (s).vc_defined_name
                             || '"'
                             || CASE
                                   WHEN workbook.defined_names_tab (s).pi_sheet IS NOT NULL
                                   THEN ' localSheetId="' || TO_CHAR (workbook.defined_names_tab (s).pi_sheet) || '"'
                                END
                             || '>'
                             || workbook.defined_names_tab (s).vc_defined_ref
                             || '</definedName>');
         END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</definedNames>');
      END IF;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<calcPr calcId="144525"/></workbook>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/workbook.xml', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Office Theme">
<a:themeElements>
<a:clrScheme name="Office">
<a:dk1>
<a:sysClr val="windowText" lastClr="000000"/>
</a:dk1>
<a:lt1>
<a:sysClr val="window" lastClr="FFFFFF"/>
</a:lt1>
<a:dk2>
<a:srgbClr val="1F497D"/>
</a:dk2>
<a:lt2>
<a:srgbClr val="EEECE1"/>
</a:lt2>
<a:accent1>
<a:srgbClr val="4F81BD"/>
</a:accent1>
<a:accent2>
<a:srgbClr val="C0504D"/>
</a:accent2>
<a:accent3>
<a:srgbClr val="9BBB59"/>
</a:accent3>
<a:accent4>
<a:srgbClr val="8064A2"/>
</a:accent4>
<a:accent5>
<a:srgbClr val="4BACC6"/>
</a:accent5>
<a:accent6>
<a:srgbClr val="F79646"/>
</a:accent6>
<a:hlink>
<a:srgbClr val="0000FF"/>
</a:hlink>
<a:folHlink>
<a:srgbClr val="800080"/>
</a:folHlink>
</a:clrScheme>
<a:fontScheme name="Office">
<a:majorFont>
<a:latin typeface="Cambria"/>
<a:ea typeface=""/>
<a:cs typeface=""/>
<a:font script="Jpan" typeface="MS P????"/>
<a:font script="Hang" typeface="?? ??"/>
<a:font script="Hans" typeface="??"/>
<a:font script="Hant" typeface="????"/>
<a:font script="Arab" typeface="Times New Roman"/>
<a:font script="Hebr" typeface="Times New Roman"/>
<a:font script="Thai" typeface="Tahoma"/>
<a:font script="Ethi" typeface="Nyala"/>
<a:font script="Beng" typeface="Vrinda"/>
<a:font script="Gujr" typeface="Shruti"/>
<a:font script="Khmr" typeface="MoolBoran"/>
<a:font script="Knda" typeface="Tunga"/>
<a:font script="Guru" typeface="Raavi"/>
<a:font script="Cans" typeface="Euphemia"/>
<a:font script="Cher" typeface="Plantagenet Cherokee"/>
<a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
<a:font script="Tibt" typeface="Microsoft Himalaya"/>
<a:font script="Thaa" typeface="MV Boli"/>
<a:font script="Deva" typeface="Mangal"/>
<a:font script="Telu" typeface="Gautami"/>
<a:font script="Taml" typeface="Latha"/>
<a:font script="Syrc" typeface="Estrangelo Edessa"/>
<a:font script="Orya" typeface="Kalinga"/>
<a:font script="Mlym" typeface="Kartika"/>
<a:font script="Laoo" typeface="DokChampa"/>
<a:font script="Sinh" typeface="Iskoola Pota"/>
<a:font script="Mong" typeface="Mongolian Baiti"/>
<a:font script="Viet" typeface="Times New Roman"/>
<a:font script="Uigh" typeface="Microsoft Uighur"/>
<a:font script="Geor" typeface="Sylfaen"/>
</a:majorFont>
<a:minorFont>
<a:latin typeface="Calibri"/>
<a:ea typeface=""/>
<a:cs typeface=""/>
<a:font script="Jpan" typeface="MS P????"/>
<a:font script="Hang" typeface="?? ??"/>
<a:font script="Hans" typeface="??"/>
<a:font script="Hant" typeface="????"/>
<a:font script="Arab" typeface="Arial"/>
<a:font script="Hebr" typeface="Arial"/>
<a:font script="Thai" typeface="Tahoma"/>
<a:font script="Ethi" typeface="Nyala"/>
<a:font script="Beng" typeface="Vrinda"/>
<a:font script="Gujr" typeface="Shruti"/>
<a:font script="Khmr" typeface="DaunPenh"/>
<a:font script="Knda" typeface="Tunga"/>
<a:font script="Guru" typeface="Raavi"/>
<a:font script="Cans" typeface="Euphemia"/>
<a:font script="Cher" typeface="Plantagenet Cherokee"/>
<a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
<a:font script="Tibt" typeface="Microsoft Himalaya"/>
<a:font script="Thaa" typeface="MV Boli"/>
<a:font script="Deva" typeface="Mangal"/>
<a:font script="Telu" typeface="Gautami"/>
<a:font script="Taml" typeface="Latha"/>
<a:font script="Syrc" typeface="Estrangelo Edessa"/>
<a:font script="Orya" typeface="Kalinga"/>
<a:font script="Mlym" typeface="Kartika"/>
<a:font script="Laoo" typeface="DokChampa"/>
<a:font script="Sinh" typeface="Iskoola Pota"/>
<a:font script="Mong" typeface="Mongolian Baiti"/>
<a:font script="Viet" typeface="Arial"/>
<a:font script="Uigh" typeface="Microsoft Uighur"/>
<a:font script="Geor" typeface="Sylfaen"/>
</a:minorFont>
</a:fontScheme>
<a:fmtScheme name="Office">
<a:fillStyleLst>
<a:solidFill>
<a:schemeClr val="phClr"/>
</a:solidFill>
<a:gradFill rotWithShape="1">
<a:gsLst>
<a:gs pos="0">
<a:schemeClr val="phClr">
<a:tint val="50000"/>
<a:satMod val="300000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="35000">
<a:schemeClr val="phClr">
<a:tint val="37000"/>
<a:satMod val="300000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="100000">
<a:schemeClr val="phClr">
<a:tint val="15000"/>
<a:satMod val="350000"/>
</a:schemeClr>
</a:gs>
</a:gsLst>
<a:lin ang="16200000" scaled="1"/>
</a:gradFill>
<a:gradFill rotWithShape="1">
<a:gsLst>
<a:gs pos="0">
<a:schemeClr val="phClr">
<a:shade val="51000"/>
<a:satMod val="130000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="80000">
<a:schemeClr val="phClr">
<a:shade val="93000"/>
<a:satMod val="130000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="100000">
<a:schemeClr val="phClr">
<a:shade val="94000"/>
<a:satMod val="135000"/>
</a:schemeClr>
</a:gs>
</a:gsLst>
<a:lin ang="16200000" scaled="0"/>
</a:gradFill>
</a:fillStyleLst>
<a:lnStyleLst>
<a:ln w="9525" cap="flat" cmpd="sng" algn="ctr">
<a:solidFill>
<a:schemeClr val="phClr">
<a:shade val="95000"/>
<a:satMod val="105000"/>
</a:schemeClr>
</a:solidFill>
<a:prstDash val="solid"/>
</a:ln>
<a:ln w="25400" cap="flat" cmpd="sng" algn="ctr">
<a:solidFill>
<a:schemeClr val="phClr"/>
</a:solidFill>
<a:prstDash val="solid"/>
</a:ln>
<a:ln w="38100" cap="flat" cmpd="sng" algn="ctr">
<a:solidFill>
<a:schemeClr val="phClr"/>
</a:solidFill>
<a:prstDash val="solid"/>
</a:ln>
</a:lnStyleLst>
<a:effectStyleLst>
<a:effectStyle>
<a:effectLst>
<a:outerShdw blurRad="40000" dist="20000" dir="5400000" rotWithShape="0">
<a:srgbClr val="000000">
<a:alpha val="38000"/>
</a:srgbClr>
</a:outerShdw>
</a:effectLst>
</a:effectStyle>
<a:effectStyle>
<a:effectLst>
<a:outerShdw blurRad="40000" dist="23000" dir="5400000" rotWithShape="0">
<a:srgbClr val="000000">
<a:alpha val="35000"/>
</a:srgbClr>
</a:outerShdw>
</a:effectLst>
</a:effectStyle>
<a:effectStyle>
<a:effectLst>
<a:outerShdw blurRad="40000" dist="23000" dir="5400000" rotWithShape="0">
<a:srgbClr val="000000">
<a:alpha val="35000"/>
</a:srgbClr>
</a:outerShdw>
</a:effectLst>
<a:scene3d>
<a:camera prst="orthographicFront">
<a:rot lat="0" lon="0" rev="0"/>
</a:camera>
<a:lightRig rig="threePt" dir="t">
<a:rot lat="0" lon="0" rev="1200000"/>
</a:lightRig>
</a:scene3d>
<a:sp3d>
<a:bevelT w="63500" h="25400"/>
</a:sp3d>
</a:effectStyle>
</a:effectStyleLst>
<a:bgFillStyleLst>
<a:solidFill>
<a:schemeClr val="phClr"/>
</a:solidFill>
<a:gradFill rotWithShape="1">
<a:gsLst>
<a:gs pos="0">
<a:schemeClr val="phClr">
<a:tint val="40000"/>
<a:satMod val="350000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="40000">
<a:schemeClr val="phClr">
<a:tint val="45000"/>
<a:shade val="99000"/>
<a:satMod val="350000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="100000">
<a:schemeClr val="phClr">
<a:shade val="20000"/>
<a:satMod val="255000"/>
</a:schemeClr>
</a:gs>
</a:gsLst>
<a:path path="circle">
<a:fillToRect l="50000" t="-80000" r="50000" b="180000"/>
</a:path>
</a:gradFill>
<a:gradFill rotWithShape="1">
<a:gsLst>
<a:gs pos="0">
<a:schemeClr val="phClr">
<a:tint val="80000"/>
<a:satMod val="300000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="100000">
<a:schemeClr val="phClr">
<a:shade val="30000"/>
<a:satMod val="200000"/>
</a:schemeClr>
</a:gs>
</a:gsLst>
<a:path path="circle">
<a:fillToRect l="50000" t="50000" r="50000" b="50000"/>
</a:path>
</a:gradFill>
</a:bgFillStyleLst>
</a:fmtScheme>
</a:themeElements>
<a:objectDefaults/>
<a:extraClrSchemeLst/>
</a:theme>',
         p_eof =>         TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/theme/theme1.xml', t_xxx);
      t_xxx := NULL;

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         t_col_min := 16384;
         t_col_max := 1;
         t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.FIRST;

         WHILE t_row_ind IS NOT NULL
         LOOP
            t_col_min := LEAST (t_col_min, workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).FIRST);
            t_col_max := GREATEST (t_col_max, workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).LAST);
            t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.NEXT (t_row_ind);
         END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:xdr="http://schemas.openxmlformats.org/drawingml/2006/spreadsheetDrawing" xmlns:x14="http://schemas.microsoft.com/office/spreadsheetml/2009/9/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">
<dimension ref="'
                       || alfan_col (t_col_min)
                       || workbook.sheets_tab (s).sheet_rows_tab.FIRST
                       || ':'
                       || alfan_col (t_col_max)
                       || workbook.sheets_tab (s).sheet_rows_tab.LAST
                       || '"/>
<sheetViews>
<sheetView'
                       || CASE WHEN s = 1 THEN ' tabSelected="1"' END
                       || ' workbookViewId="0">');

         IF workbook.sheets_tab (s).pi_freeze_rows > 0 AND workbook.sheets_tab (s).pi_freeze_cols > 0
         THEN
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<pane xSplit="'
                        || TO_CHAR (workbook.sheets_tab (s).pi_freeze_cols)
                        || '" '
                        || 'ySplit="'
                        || TO_CHAR (workbook.sheets_tab (s).pi_freeze_rows)
                        || '" '
                        || 'topLeftCell="'
                        || alfan_col (workbook.sheets_tab (s).pi_freeze_cols + 1)
                        || TO_CHAR (workbook.sheets_tab (s).pi_freeze_rows + 1)
                        || '" '
                        || 'activePane="bottomLeft" state="frozen"/>');
         ELSE
            IF workbook.sheets_tab (s).pi_freeze_rows > 0
            THEN
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<pane ySplit="'
                                || TO_CHAR (workbook.sheets_tab (s).pi_freeze_rows)
                                || '" topLeftCell="A'
                                || TO_CHAR (workbook.sheets_tab (s).pi_freeze_rows + 1)
                                || '" activePane="bottomLeft" state="frozen"/>');
            END IF;

            IF workbook.sheets_tab (s).pi_freeze_cols > 0
            THEN
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<pane xSplit="'
                                || TO_CHAR (workbook.sheets_tab (s).pi_freeze_cols)
                                || '" topLeftCell="'
                                || alfan_col (workbook.sheets_tab (s).pi_freeze_cols + 1)
                                || '1" activePane="bottomLeft" state="frozen"/>');
            END IF;
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '</sheetView>
</sheetViews>
<sheetFormatPr defaultRowHeight="15" x14ac:dyDescent="0.25"/>');

         IF workbook.sheets_tab (s).widths_tab_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<cols>');
            t_col_ind := workbook.sheets_tab (s).widths_tab_tab.FIRST;

            WHILE t_col_ind IS NOT NULL
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<col min="'
                                || TO_CHAR (t_col_ind)
                                || '" max="'
                                || TO_CHAR (t_col_ind)
                                || '" width="'
                                || TO_CHAR (workbook.sheets_tab (s).widths_tab_tab (t_col_ind), 'TM9', 'NLS_NUMERIC_CHARACTERS=.,')
                                || '" customWidth="1"/>');
               t_col_ind := workbook.sheets_tab (s).widths_tab_tab.NEXT (t_col_ind);
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</cols>');
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<sheetData>');
         t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.FIRST;

         WHILE t_row_ind IS NOT NULL
         LOOP
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<row r="' || t_row_ind || '" spans="' || TO_CHAR (t_col_min) || ':' || TO_CHAR (t_col_max) || '">');
            t_col_ind := workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).FIRST;

            WHILE t_col_ind IS NOT NULL
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<c r="'
                                || alfan_col (t_col_ind)
                                || TO_CHAR (t_row_ind)
                                || '"'
                                || ' '
                                || workbook.sheets_tab (s).sheet_rows_tab (t_row_ind) (t_col_ind).vc_style_def
                                || '> '		       		                                
                                || CASE WHEN workbook.sheets_tab (s).sheet_rows_tab (t_row_ind) (t_col_ind).formula IS NOT NULL THEN '<f>'
                                || TO_CHAR (workbook.sheets_tab (s).sheet_rows_tab (t_row_ind) (t_col_ind).formula)
                                || '</f>' END
                                || '<v>'
                                || TO_CHAR (workbook.sheets_tab (s).sheet_rows_tab (t_row_ind) (t_col_ind).nn_value_id,
                                            'TM9',
                                            'NLS_NUMERIC_CHARACTERS=.,')
                                || '</v></c>');

               t_col_ind := workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).NEXT (t_col_ind);
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</row>');
            t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.NEXT (t_row_ind);
         END LOOP;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '</sheetData>');

         IF workbook.sheets_tab (s).hash_value is not null and workbook.sheets_tab (s).salt_value is not null 
         THEN     
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<sheetProtection sheet="1" algorithmName="SHA-512" hashValue="' 
                              || workbook.sheets_tab (s).hash_value 
                              || '" saltValue="' 
                              || workbook.sheets_tab (s).salt_value 
                              || '" spinCount="100000" objects="1" scenarios="1" />');
         END IF;                                   

         IF workbook.sheets_tab (s).protection_tab.COUNT > 0  
         THEN    
            clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<protectedRanges>');

            FOR p in 1 .. workbook.sheets_tab (s).protection_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '   <protectedRange sqref="' 
                                 || workbook.sheets_tab (s).protection_tab (p).vc_tl_col
                                 || workbook.sheets_tab (s).protection_tab (p).vc_tl_row 
                                 || ':' 
                                 || workbook.sheets_tab (s).protection_tab (p).vc_br_col 
                                 || workbook.sheets_tab (s).protection_tab (p).vc_br_row 
                                 || '" name="'
                                 || workbook.sheets_tab (s).protection_tab (p).vc_name
                                 || '" />');
            END LOOP;  

            clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '</protectedRanges>');                   
         END IF;   

         FOR a IN 1 .. workbook.sheets_tab (s).autofilters_tab.COUNT
         LOOP
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<autoFilter ref="'
                             || alfan_col (NVL (workbook.sheets_tab (s).autofilters_tab (A).pi_column_start, t_col_min))
                             || TO_CHAR (NVL (workbook.sheets_tab (s).autofilters_tab (a).pi_row_start, workbook.sheets_tab (s).sheet_rows_tab.FIRST))
                             || ':'
                             || alfan_col (
                                   COALESCE (workbook.sheets_tab (s).autofilters_tab (a).pi_column_end,
                                             workbook.sheets_tab (s).autofilters_tab (a).pi_column_start,
                                             t_col_max))
                             || TO_CHAR (NVL (workbook.sheets_tab (s).autofilters_tab (A).pi_row_end, workbook.sheets_tab (s).sheet_rows_tab.LAST))
                             || '"/>');
         END LOOP;

         IF workbook.sheets_tab (s).mergecells_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<mergeCells count="' || TO_CHAR (workbook.sheets_tab (s).mergecells_tab.COUNT) || '">');

            FOR m IN 1 .. workbook.sheets_tab (s).mergecells_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<mergeCell ref="' || workbook.sheets_tab (s).mergecells_tab (m) || '"/>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</mergeCells>');
         END IF;

         IF workbook.sheets_tab (s).validations_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<dataValidations count="' || TO_CHAR (workbook.sheets_tab (s).validations_tab.COUNT) || '">');

            FOR m IN 1 .. workbook.sheets_tab (s).validations_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<dataValidation'
                                || ' type="'
                                || workbook.sheets_tab (s).validations_tab (m).vc_validation_type
                                || '"'
                                || ' errorStyle="'
                                || workbook.sheets_tab (s).validations_tab (m).vc_errorstyle
                                || '"'
                                || ' allowBlank="'
                                || CASE WHEN NVL (workbook.sheets_tab (s).validations_tab (m).bo_allowblank, TRUE) THEN '1' ELSE '0' END
                                || '"'
                                || ' sqref="'
                                || workbook.sheets_tab (s).validations_tab (m).vc_sqref
                                || '"');

               IF workbook.sheets_tab (s).validations_tab (m).vc_prompt IS NOT NULL
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => ' showInputMessage="1" prompt="'
                                   || workbook.sheets_tab (s).validations_tab (m).vc_prompt 
                                   || '"');

                  IF workbook.sheets_tab (s).validations_tab (m).vc_title IS NOT NULL
                  THEN
                     clob_vc_concat(
                        p_clob        => t_xxx,
                        p_vc_buffer   => t_tmp,
                        p_vc_addition => ' promptTitle="'
                                      || workbook.sheets_tab (s).validations_tab (m).vc_title
                                      || '"');
                  END IF;
               END IF;

               IF workbook.sheets_tab (s).validations_tab (m).bo_showerrormessage
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => ' showErrorMessage="1"');

                  IF workbook.sheets_tab (s).validations_tab (m).vc_error_title IS NOT NULL
                  THEN
                     clob_vc_concat(
                        p_clob        => t_xxx,
                        p_vc_buffer   => t_tmp,
                        p_vc_addition => ' errorTitle="' 
                                      || workbook.sheets_tab (s).validations_tab (m).vc_error_title 
                                      || '"');
                  END IF;

                  IF workbook.sheets_tab (s).validations_tab (m).vc_error_txt IS NOT NULL
                  THEN
                     clob_vc_concat(
                        p_clob        => t_xxx,
                        p_vc_buffer   => t_tmp,
                        p_vc_addition => ' error="' 
                                      || workbook.sheets_tab (s).validations_tab (m).vc_error_txt 
                                      || '"');
                  END IF;
               END IF;

               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '>');

               IF workbook.sheets_tab (s).validations_tab (m).vc_formula1 IS NOT NULL
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => '<formula1>' 
                                   || workbook.sheets_tab (s).validations_tab (m).vc_formula1 
                                   || '</formula1>');
               END IF;

               IF workbook.sheets_tab (s).validations_tab (m).vc_formula2 IS NOT NULL
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => '<formula2>' 
                                   || workbook.sheets_tab (s).validations_tab (m).vc_formula2
                                   || '</formula2>');
               END IF;

               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '</dataValidation>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</dataValidations>');
         END IF;

         IF workbook.sheets_tab (s).hyperlinks_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<hyperlinks>');

            FOR h IN 1 .. workbook.sheets_tab (s).hyperlinks_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<hyperlink ref="'
                                || workbook.sheets_tab (s).hyperlinks_tab (h).vc_cell
                                || '" r:id="rId'
                                || TO_CHAR (h)
                                || '"/>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</hyperlinks>');
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" footer="0.3"/>');

         IF workbook.sheets_tab (s).comments_tab.COUNT > 0
         THEN
            -- AMEI, 20141129 Bugfix for
            -- t_xxx := t_xxx || '<legacyDrawing r:id="rId' || (workbook.sheets_tab (s).hyperlinks_tab.COUNT + 1) || '"/>';
            -- Raised ORA-06502: PL/SQL: numerischer oder Wertefehler,
            -- occurs when a at least on column has a Help Text,
            -- occurs NOT when NONE column has a Help Text at all.
            -- Bugfix by explicit conversion TO_CHAR(...)
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<legacyDrawing r:id="rId' 
                             || TO_CHAR (workbook.sheets_tab (s).hyperlinks_tab.COUNT + 1) 
                             || '"/>');
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '</worksheet>',
            p_eof         => TRUE);
         zip_util_pkg.add_file (t_excel, 'xl/worksheets/sheet' || TO_CHAR (s) || '.xml', t_xxx);
         t_xxx := NULL;

         IF workbook.sheets_tab (s).hyperlinks_tab.COUNT > 0 OR workbook.sheets_tab (s).comments_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">');

            IF workbook.sheets_tab (s).comments_tab.COUNT > 0
            THEN
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<Relationship Id="rId'
                                || TO_CHAR (workbook.sheets_tab (s).hyperlinks_tab.COUNT + 2)
                                || '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/comments" Target="../comments'
                                || s
                                || '.xml"/>');
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<Relationship Id="rId'
                                || TO_CHAR (workbook.sheets_tab (s).hyperlinks_tab.COUNT + 1)
                                || '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/vmlDrawing" Target="../drawings/vmlDrawing'
                                || TO_CHAR (s)
                                || '.vml"/>');
            END IF;

            FOR h IN 1 .. workbook.sheets_tab (s).hyperlinks_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<Relationship Id="rId'
                                || TO_CHAR (h)
                                || '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="'
                                || workbook.sheets_tab (s).hyperlinks_tab (h).vc_url
                                || '" TargetMode="External"/>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</Relationships>',
               p_eof         => TRUE);
            zip_util_pkg.add_file (t_excel, 'xl/worksheets/_rels/sheet' || TO_CHAR (s) || '.xml.rels', t_xxx);
            t_xxx := NULL;
         END IF;

         IF workbook.sheets_tab (s).comments_tab.COUNT > 0
         THEN
            DECLARE
               cnt          PLS_INTEGER;
               author_ind   st_author;
            BEGIN
               gv_authors_tab.delete;

               FOR c IN 1 .. workbook.sheets_tab (s).comments_tab.COUNT
               LOOP
                  gv_authors_tab (workbook.sheets_tab (s).comments_tab (c).vc_author) := 0;
               END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<comments xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
<authors>');
               cnt := 0;
               author_ind := gv_authors_tab.FIRST;

               WHILE author_ind IS NOT NULL OR gv_authors_tab.NEXT (author_ind) IS NOT NULL
               LOOP
                  gv_authors_tab (author_ind) := cnt;
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => '<author>' || author_ind || '</author>');
                  cnt := cnt + 1;
                  author_ind := gv_authors_tab.NEXT (author_ind);
               END LOOP;
            END;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</authors><commentList>');

            FOR c IN 1 .. workbook.sheets_tab (s).comments_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<comment ref="'
                                || alfan_col (workbook.sheets_tab (s).comments_tab (c).pi_column_nr)
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_row_nr)
                                || '" authorId="'
                                || gv_authors_tab (workbook.sheets_tab (s).comments_tab (c).vc_author)
                                || '"><text>');

               IF workbook.sheets_tab (s).comments_tab (c).vc_author IS NOT NULL
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => '<r><rPr><b/><sz val="9"/><color indexed="81"/><rFont val="Tahoma"/><charset val="1"/></rPr><t xml:space="preserve">'
                                   || workbook.sheets_tab (s).comments_tab (c).vc_author
                                   || ':</t></r>');
               END IF;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<r><rPr><sz val="9"/><color indexed="81"/><rFont val="Tahoma"/><charset val="1"/></rPr><t xml:space="preserve">'
                             || CASE WHEN workbook.sheets_tab (s).comments_tab (c).vc_author IS NOT NULL THEN '' END
                             || workbook.sheets_tab (s).comments_tab (c).vc_text
                             || '</t></r></text></comment>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</commentList></comments>',
               p_eof         => TRUE);
            zip_util_pkg.add_file (t_excel, 'xl/comments' || TO_CHAR (s) || '.xml', t_xxx);
            t_xxx := NULL;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<xml xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel">
<o:shapelayout v:ext="edit"><o:idmap v:ext="edit" data="2"/></o:shapelayout>
<v:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe"><v:stroke joinstyle="miter"/><v:path gradientshapeok="t" o:connecttype="rect"/></v:shapetype>');

            FOR c IN 1 .. workbook.sheets_tab (s).comments_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<v:shape id="_x0000_s'
                                || TO_CHAR (c)
                                || '" type="#_x0000_t202" style="position:absolute;margin-left:35.25pt;margin-top:3pt;z-index:'
                                || TO_CHAR (c)
                                || ';visibility:hidden;" fillcolor="#ffffe1" o:insetmode="auto">
<v:fill color2="#ffffe1"/><v:shadow on="t" color="black" obscured="t"/><v:path o:connecttype="none"/>
<v:textbox style="mso-direction-alt:auto"><div style="text-align:left"></div></v:textbox>
<x:ClientData ObjectType="Note"><x:MoveWithCells/><x:SizeWithCells/>');
               t_w := workbook.sheets_tab (s).comments_tab (c).pi_width;
               t_c := 1;

               LOOP
                  IF workbook.sheets_tab (s).widths_tab_tab.EXISTS (workbook.sheets_tab (s).comments_tab (c).pi_column_nr + t_c)
                  THEN
                     t_cw := 256 * workbook.sheets_tab (s).widths_tab_tab (workbook.sheets_tab (s).comments_tab (c).pi_column_nr + t_c);
                     t_cw := TRUNC ( (t_cw + 18) / 256 * 7);                                              -- assume default 11 point Calibri
                  ELSE
                     t_cw := 64;
                  END IF;

                  EXIT WHEN t_w < t_cw;
                  t_c := t_c + 1;
                  t_w := t_w - t_cw;
               END LOOP;

               t_h := workbook.sheets_tab (s).comments_tab (c).pi_height;
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<x:Anchor>'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_column_nr)
                                || ',15,'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_row_nr)
                                || ',30,'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_column_nr + t_c - 1)
                                || ','
                                || TO_CHAR (ROUND (t_w))
                                || ','
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_row_nr + 1 + TRUNC (t_h / 20))
                                || ','
                                || TO_CHAR (MOD (t_h, 20))
                                || '</x:Anchor>');
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<x:AutoFill>false</x:AutoFill><x:Row>'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_row_nr - 1)
                                || '</x:Row><x:Column>'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_column_nr - 1)
                                || '</x:Column></x:ClientData></v:shape>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</xml>',
               p_eof         => TRUE);
            zip_util_pkg.add_file (t_excel, 'xl/drawings/vmlDrawing' || TO_CHAR (s) || '.vml', t_xxx);
            t_xxx := NULL;
         END IF;
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings" Target="sharedStrings.xml"/>
<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/>');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<Relationship Id="rId'
                          || TO_CHAR (9 + s)
                          || '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet'
                          || TO_CHAR (s)
                          || '.xml"/>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</Relationships>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/_rels/workbook.xml.rels', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><sst xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" count="'
                       || workbook.pi_str_cnt
                       || '" uniqueCount="'
                       || TO_CHAR (workbook.strings_tab.COUNT)
                       || '">');

      FOR i IN 0 .. workbook.str_ind_tab.COUNT - 1
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<si><t>' 
                          || DBMS_XMLGEN.CONVERT (SUBSTR (workbook.str_ind_tab (i), 1, 32000))
                          || '</t></si>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</sst>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/sharedStrings.xml', t_xxx);
      t_xxx := NULL;
      zip_util_pkg.finish_zip (t_excel);
      clear_workbook;
      RETURN t_excel;
   END finish;

   FUNCTION query2sheet (p_sql VARCHAR2, p_column_headers BOOLEAN := TRUE, p_sheet PLS_INTEGER := NULL, p_skip_header boolean := FALSE)
      RETURN BLOB
   AS
      t_sheet       PLS_INTEGER;
      t_c           INTEGER;
      t_col_cnt     INTEGER;
      t_desc_tab    DBMS_SQL.desc_tab2;
      d_tab         DBMS_SQL.date_table;
      n_tab         DBMS_SQL.number_table;
      v_tab         DBMS_SQL.varchar2_table;
      t_bulk_size   PLS_INTEGER := 200;
      t_r           INTEGER;
      t_cur_row     PLS_INTEGER;
   BEGIN
      t_sheet := COALESCE (p_sheet, new_sheet);
      t_c := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (t_c, p_sql, DBMS_SQL.native);
      DBMS_SQL.describe_columns2 (t_c, t_col_cnt, t_desc_tab);

      FOR c IN 1 .. t_col_cnt
      LOOP
         IF p_column_headers
         THEN
            cell (c,
                  1,
                  t_desc_tab (c).col_name,
                  p_sheet   => t_sheet);
         END IF;

         CASE
            WHEN t_desc_tab (c).col_type IN (2, 100, 101)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      n_tab,
                                      t_bulk_size,
                                      1);
            WHEN t_desc_tab (c).col_type IN (12,
                                             178,
                                             179,
                                             180,
                                             181,
                                             231)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      d_tab,
                                      t_bulk_size,
                                      1);
            WHEN t_desc_tab (c).col_type IN (1,
                                             8,
                                             9,
                                             96,
                                             112)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      v_tab,
                                      t_bulk_size,
                                      1);
            ELSE
               NULL;
         END CASE;
      END LOOP;

      -- column headers werden vom Lieferantenabfragetool gesetzt, daher die Idßs um einen erhöht (TH)
      if p_skip_header then
          t_cur_row := CASE WHEN p_column_headers THEN 3 ELSE 2 END;
      else
          t_cur_row := CASE WHEN p_column_headers THEN 2 ELSE 1 END;
      end if;

      t_r := DBMS_SQL.execute (t_c);

      LOOP
         t_r := DBMS_SQL.fetch_rows (t_c);

         IF t_r > 0
         THEN
            FOR c IN 1 .. t_col_cnt
            LOOP
               CASE
                  WHEN t_desc_tab (c).col_type IN (2, 100, 101)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, n_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF n_tab (i + n_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 n_tab (i + n_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     n_tab.delete;
                  WHEN t_desc_tab (c).col_type IN (12,
                                                   178,
                                                   179,
                                                   180,
                                                   181,
                                                   231)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, d_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF d_tab (i + d_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 d_tab (i + d_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     d_tab.delete;
                  WHEN t_desc_tab (c).col_type IN (1,
                                                   8,
                                                   9,
                                                   96,
                                                   112)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, v_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF v_tab (i + v_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 v_tab (i + v_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     v_tab.delete;
                  ELSE
                     NULL;
               END CASE;
            END LOOP;
         END IF;

         EXIT WHEN t_r != t_bulk_size;
         t_cur_row := t_cur_row + t_r;
      END LOOP;

      DBMS_SQL.close_cursor (t_c);
      RETURN finish;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF DBMS_SQL.is_open (t_c)
         THEN
            DBMS_SQL.close_cursor (t_c);
         END IF;

         RETURN NULL;
   END query2sheet;

   FUNCTION finish2 (p_clob                 IN OUT NOCOPY CLOB,
                     p_columns              PLS_INTEGER,
                     p_rows                 PLS_INTEGER,
                     p_XLSX_date_format     VARCHAR2,
                     p_XLSX_datetime_format VARCHAR2)
      RETURN BLOB
   AS
      t_excel               BLOB;
      t_xxx                 CLOB;
      t_str                 VARCHAR2 (32767);
   BEGIN
      DBMS_LOB.createtemporary (t_excel, TRUE);
	  DBMS_LOB.createtemporary (t_xxx, TRUE);
	  --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"
           xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
	<dimension ref="A1:'
                       || alfan_col (p_columns)
                       || p_rows
                       || '"/>
	<sheetViews>
		<sheetView tabSelected="1"
		           workbookViewId="0">
			<pane ySplit="1"
			      topLeftCell="A2"
			      activePane="bottomLeft"
			      state="frozen"/>
			<selection pane="bottomLeft"
			           activeCell="A2"
			           sqref="A2"/>
		</sheetView>
	</sheetViews><sheetData>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
	  DBMS_LOB.append (t_xxx, p_clob);
	  DBMS_LOB.freetemporary (p_clob);
      t_str := '</sheetData><autoFilter ref="A1:'
                             || alfan_col (p_columns)
                             || p_rows
							 || '"/>
</worksheet>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'xl/worksheets/sheet1.xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
	<Default Extension="xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml" />
	<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml" />
	<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml" />
	<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml" />
	<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
</Types>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, '[Content_Types].xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
	<Relationship Target="xl/workbook.xml" Id="r_main" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"/>
	<Relationship Target="docProps/core.xml" Id="r_props" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties"/>
</Relationships>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, '_rels/.rels', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"
          xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
	<sheets>
		<sheet name="Sheet1"
		       sheetId="1"
		       r:id="r_sheet1" />
	</sheets>
	<definedNames>
		<definedName name="_xlnm._FilterDatabase"
		             localSheetId="0"
		             hidden="1">Sheet1!$A$1:'
					 || alfan_col(p_columns) || '$' || p_rows
					 || '</definedName>
	</definedNames>
</workbook>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'xl/workbook.xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
                   xmlns:dc="http://purl.org/dc/elements/1.1/"
                   xmlns:dcterms="http://purl.org/dc/terms/"
                   xmlns:dcmitype="http://purl.org/dc/dcmitype/"
                   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<dc:creator>'
		|| NVL(SYS_CONTEXT('APEX$SESSION','APP_USER'),SYS_CONTEXT ('userenv', 'os_user'))
		|| '</dc:creator>
	<cp:lastModifiedBy>'
		|| NVL(SYS_CONTEXT('APEX$SESSION','APP_USER'),SYS_CONTEXT ('userenv', 'os_user'))
		|| '</cp:lastModifiedBy>
	<dcterms:created xsi:type="dcterms:W3CDTF">'
		|| TO_CHAR (sysdate, 'yyyy-mm-dd"T"hh24:mi:ss')
		|| '</dcterms:created>
	<dcterms:modified xsi:type="dcterms:W3CDTF">'
		|| TO_CHAR (sysdate, 'yyyy-mm-dd"T"hh24:mi:ss')
		|| '</dcterms:modified>
</cp:coreProperties>';
	  DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'docProps/core.xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
	<numFmts count="2">
		<numFmt numFmtId="1000"
		        formatCode="' || orafmt2excel(p_XLSX_date_format) || '" />
		<numFmt numFmtId="1001"
		        formatCode="' || orafmt2excel(p_XLSX_datetime_format) || '" />
	</numFmts>
	<fonts count="2">
		<font />
		<font>
			<b/>
		</font>
	</fonts>
	<fills count="3">
		<fill>
			<patternFill patternType="none"/>
		</fill>
		<fill>
			<patternFill patternType="gray125"/>
		</fill>
		<fill>
			<patternFill patternType="solid">
				<fgColor rgb="FFE1E1E1"/>
				<bgColor indexed="64"/>
			</patternFill>
		</fill>
	</fills>
	<borders count="1">
		<border />
	</borders>
	<cellStyleXfs count="1">
		<xf />
	</cellStyleXfs>
	<cellXfs count="4">
		<xf />
		<xf fontId="1" fillId="2" applyFont="1" applyFill="1"/>
		<xf numFmtId="1000" />
		<xf numFmtId="1001" />
	</cellXfs>
</styleSheet>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'xl/styles.xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
	<Relationship Target="worksheets/sheet1.xml" Id="r_sheet1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet"/>
	<Relationship Target="styles.xml" Id="r_styles" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles"/>
</Relationships>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'xl/_rels/workbook.xml.rels', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      zip_util_pkg.finish_zip (t_excel);
      DBMS_LOB.freetemporary (t_xxx);
      RETURN t_excel;
   exception
    when others then
        raise_application_error(-20002, '|+|' || sqlerrm || ',' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '|+|');
   END finish2;

   FUNCTION query2sheet2(p_sql                  VARCHAR2,
                         p_XLSX_date_format     VARCHAR2 := 'dd/mm/yyyy',
                         p_XLSX_datetime_format VARCHAR2 := 'dd/mm/yyyy hh24:mi:ss')
      RETURN BLOB
   AS
      t_c               INTEGER;
      t_r               INTEGER;
      t_desc_tab        DBMS_SQL.desc_tab2;
      t_clob_sql        CLOB;
      t_clob_result     CLOB;
      t_column_name     VARCHAR2(30);
      t_column_type     VARCHAR2(10);
      t_str             VARCHAR2(32767);
      t_cols_count      PLS_INTEGER := 0;
      t_rows_count      PLS_INTEGER := 0;
   BEGIN
      DBMS_LOB.createtemporary (t_clob_sql, true);
      t_c := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (t_c, p_sql, DBMS_SQL.native);
      DBMS_SQL.describe_columns2 (t_c, t_cols_count, t_desc_tab);

      t_str := 'select xmlserialize(content xmlagg(t_xml)) as t_xml, count(*) as cnt from ( select '
            ||      'xmlelement("row",';
      DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      FOR c IN 1 .. t_cols_count
      LOOP
         t_column_name := t_desc_tab (c).col_name;
         t_str := 'xmlelement("c",xmlattributes(''inlineStr'' as "t",''1'' as "s"),xmlelement("is",xmlelement("t",xmlcdata('''||t_column_name||'''))))' || case when c != t_cols_count then ',' end;
         DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      END LOOP;
      t_str := ') as t_xml from dual ';

      DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      t_str := ' union all select '
            ||      'xmlelement("row",';
      DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      FOR c IN 1 .. t_cols_count
      LOOP
         t_column_name := t_desc_tab (c).col_name;
         t_column_type :=
            case
                when t_desc_tab(c).col_type IN (2,100,101)              then 'n' -- number
                when t_desc_tab(c).col_type IN (12,178,179,180,181,231) then 'd' -- date
                when t_desc_tab(c).col_type IN (1,9,96,112)             then 'inlineStr' -- char
                when t_desc_tab(c).col_type IN (8)                      then 'long' -- long
                else 'other'
            end;
         t_str :=
                'xmlelement("c",'
              ||    'xmlattributes('''||case when t_column_type in ('long','other') then 'inlineStr' else t_column_type end||''' as "t"'
              ||case when t_column_type != 'd' then '),' else ',case when nvl(trunc('||t_column_name||'),trunc(sysdate))=nvl('||t_column_name||',trunc(sysdate)) then ''2'' else ''3'' end as "s"),' end
              ||case
                    when t_column_type = 'inlineStr' then
                        'xmlelement("is",xmlelement("t",xmlcdata('||t_column_name||')))'
                    when t_column_type = 'long' then
                        'xmlelement("is",xmlelement("t",xmlcdata(''I don''''t know how to select longs'')))'
                    when t_column_type = 'other' then
                        'xmlelement("is",xmlelement("t",xmlcdata(to_clob('||t_column_name||'))))'
                    else
                        'case '
                        ||'when '||t_column_name||' is not null then xmlelement("v",'||case when t_column_type='d' then 'case when nvl(trunc('||t_column_name||'),trunc(sysdate))=nvl('||t_column_name||',trunc(sysdate)) then to_char('||t_column_name||',''yyyymmdd'') else to_char('||t_column_name||',''yyyymmdd"T"hh24miss'') end' else 'xmlcdata('||t_column_name||')' end ||') '
                        ||'else xmlelement("v") '
                        ||'end'
                end
              ||')'
              || case when c != t_cols_count then ',' end;
         DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      END LOOP;
      t_str := ') as t_xml FROM ( ' || p_sql || ' )) ';
      DBMS_LOB.writeappend (t_clob_sql, length(t_str), t_str);
      DBMS_SQL.parse (t_c, t_clob_sql, DBMS_SQL.native);
      DBMS_LOB.freetemporary (t_clob_sql);
      DBMS_SQL.define_column (t_c, 1, t_clob_result);
      DBMS_SQL.define_column (t_c, 2, t_rows_count);
      t_r := DBMS_SQL.execute_and_fetch (t_c);
      DBMS_SQL.column_value (t_c, 1, t_clob_result);
      DBMS_SQL.column_value (t_c, 2, t_rows_count);
      DBMS_SQL.close_cursor (t_c);
      return finish2(p_clob             => t_clob_result,
                     p_columns          => t_cols_count,
                     p_rows             => t_rows_count,
                     p_XLSX_date_format      => p_XLSX_date_format,
                     p_XLSX_datetime_format  => p_XLSX_datetime_format) ;
   EXCEPTION
      WHEN OTHERS THEN
         IF DBMS_SQL.is_open (t_c) THEN DBMS_SQL.close_cursor (t_c); END IF;
         if DBMS_LOB.istemporary (t_clob_sql)=1 then DBMS_LOB.freetemporary (t_clob_sql); end if;
         raise_application_error(-20001, '|+|' || sqlerrm || ',' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '|+|');
   end query2sheet2;

   function query2sheet3
   (
     p_sql     in varchar2
   , p_binds   in t_bind_tab
   , p_headers in t_header_tab
   , p_XLSX_date_format     VARCHAR2 := 'dd/mm/yyyy'
   , p_XLSX_datetime_format VARCHAR2 := 'dd/mm/yyyy hh24:mi:ss'
   )
    return blob
   AS
      t_sheet       pls_integer;
      t_c           INTEGER;
      t_col_cnt     INTEGER;
      t_desc_tab    DBMS_SQL.desc_tab2;
      d_tab         DBMS_SQL.date_table;
      n_tab         DBMS_SQL.number_table;
      v_tab         DBMS_SQL.varchar2_table;
      t_bulk_size   PLS_INTEGER := 200;
      t_r           INTEGER;
      t_cur_row     PLS_INTEGER;
      t_cur_bind_name   varchar2(32767);
   begin
      t_sheet := COALESCE (null, new_sheet);
      t_c := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (t_c, p_sql, DBMS_SQL.native);
      DBMS_SQL.describe_columns2 (t_c, t_col_cnt, t_desc_tab);

      if p_binds.count > 0 then
         t_cur_bind_name := p_binds.first();
         loop
            exit when t_cur_bind_name is null;
            dbms_sql.bind_variable( t_c, t_cur_bind_name, p_binds(t_cur_bind_name));
            t_cur_bind_name := p_binds.next(t_cur_bind_name);
         end loop;
      end if;


      FOR c IN 1 .. t_col_cnt
      LOOP
          cell (c,
                1,
                case when p_headers.exists(c) then p_headers(c) else t_desc_tab(c).col_name end,
                p_sheet   => t_sheet);

         CASE
            WHEN t_desc_tab (c).col_type IN (2, 100, 101)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      n_tab,
                                      t_bulk_size,
                                      1);
            WHEN t_desc_tab (c).col_type IN (12,
                                             178,
                                             179,
                                             180,
                                             181,
                                             231)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      d_tab,
                                      t_bulk_size,
                                      1);
            WHEN t_desc_tab (c).col_type IN (1,
                                             8,
                                             9,
                                             96,
                                             112)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      v_tab,
                                      t_bulk_size,
                                      1);
            ELSE
               NULL;
         END CASE;
      END LOOP;

      t_cur_row := CASE WHEN true THEN 2 ELSE 1 END;

      t_r := DBMS_SQL.execute (t_c);

      LOOP
         t_r := DBMS_SQL.fetch_rows (t_c);

         IF t_r > 0
         THEN
            FOR c IN 1 .. t_col_cnt
            LOOP
               CASE
                  WHEN t_desc_tab (c).col_type IN (2, 100, 101)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, n_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF n_tab (i + n_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 n_tab (i + n_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     n_tab.delete;
                  WHEN t_desc_tab (c).col_type IN (12,
                                                   178,
                                                   179,
                                                   180,
                                                   181,
                                                   231)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, d_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF d_tab (i + d_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 d_tab (i + d_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     d_tab.delete;
                  WHEN t_desc_tab (c).col_type IN (1,
                                                   8,
                                                   9,
                                                   96,
                                                   112)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, v_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF v_tab (i + v_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 v_tab (i + v_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     v_tab.delete;
                  ELSE
                     NULL;
               END CASE;
            END LOOP;
         END IF;

         EXIT WHEN t_r != t_bulk_size;
         t_cur_row := t_cur_row + t_r;
      END LOOP;

      DBMS_SQL.close_cursor (t_c);
      RETURN finish;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF DBMS_SQL.is_open (t_c)
         THEN
            DBMS_SQL.close_cursor (t_c);
         END IF;

         RETURN NULL;
   END query2sheet3;

END;
/