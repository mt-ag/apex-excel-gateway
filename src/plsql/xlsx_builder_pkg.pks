create or replace PACKAGE xlsx_builder_pkg
   AUTHID CURRENT_USER
IS
   /**********************************************
   **
   ** Author: Anton Scheffer
   ** Date: 19-02-2011
   ** Website: http://technology.amis.nl/blog
   ** See also: http://technology.amis.nl/blog/?p=10995
   **
   ** Changelog:
   **   Date: 21-02-2011
   **     Added Aligment, horizontal, vertical, wrapText
   **   Date: 06-03-2011
   **     Added Comments, MergeCells, fixed bug for dependency on NLS-settings
   **   Date: 16-03-2011
   **     Added bold and italic fonts
   **   Date: 22-03-2011
   **     Fixed issue with timezone's set to a region(name) instead of a offset
   **   Date: 08-04-2011
   **     Fixed issue with XML-escaping from text
   **   Date: 27-05-2011
   **     Added MIT-license
   **   Date: 11-08-2011
   **     Fixed NLS-issue with column width
   **   Date: 29-09-2011
   **     Added font color
   **   Date: 16-10-2011
   **     fixed bug in add_string
   **   Date: 26-04-2012
   **     Fixed set_autofilter (only one autofilter per sheet, added _xlnm._FilterDatabase)
   **     Added list_validation = drop-down
   **   Date: 27-08-2013
   **     Added freeze_pane
   **   Date: 01-03-2014 (MK)
   **     Changed new_sheet to function returning sheet id
   **   Date: 22-03-2014 (MK)
   **     Added function to convert Oracle Number Format to Excel Format
   **   Date: 07-04-2014 (MK)
   **     Removed references to UTL_FILE
   **     query2sheet is now function returning BLOB
   **     changed date handling to be based on 01-01-1900
   **   Date: 08-04-2014 (MK)
   **     internal function for date to excel serial conversion added
   **   Date: 01-12-2014 (AMEI)
   **     Some Naming-conventions (and renaming of elements accordingly), new FUNCTION get_sheet_id
   **     Triggered by: @SEE AMEI, 20141129 Bugfix:
   **     For concatenation operations (in particular where record fields are involved) added a lot of TO_CHAR (...)
   **     to make sure correct explicit conversion (mayby not all caught where necessary)
   **     To make this easier to recognize, inducted some naming conventions and renamed some elements.
   **   Date: 26-04-2017 (MP)
   **     Added new function "query2sheet2" which is faster.
   **     For dates used following logic:
   **       - if trunc([column])=[column], then outputed cell value is formatted to format YYYYMMDD;
   **       - otherwise, outputted cell value is formatted to format YYYYMMDDTHH24MISS;
   **   Date: 24-09-2019 (PH)
   **     Added parameter "p_hidden" to function "new_sheet" to create a hidden sheet 
   **   Date: 24-05-2021 (TH)
   **     Added parameter "p_formula" to function "cell" to add a formual into a cell 
   ******************************************************************************
   ******************************************************************************
   Copyright (C) 2011, 2012 by Anton Scheffer

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.

   ******************************************************************************
   ******************************************************************************
   * @headcom
   */

   /**
   * Record with data about column alignment.
   * @param vertical   Vertical alignment.
   * @param horizontal Horizontal alignment.
   * @param wrapText   Switch to allow or disallow word wrap.
   */
   TYPE t_alignment_rec IS RECORD
   (
      vc_vertical     VARCHAR2 (11),
      vc_horizontal   VARCHAR2 (16),
      bo_wraptext     BOOLEAN
   );

   type t_bind_tab is table of varchar2(32767) index by varchar2(32767);

   type t_header_tab is table of varchar2(32767) index by pls_integer;

   /**
   * Clears the whole workbook to start fresh.
   */
   PROCEDURE clear_workbook;

   /**
   * Create a new sheet in the workbook.
   * @param p_sheetname Name Excel should display for the new worksheet.
   * @return ID of newly created worksheet.
   */
   FUNCTION new_sheet (p_sheetname VARCHAR2 := NULL, p_hidden BOOLEAN := FALSE)
      RETURN PLS_INTEGER;

   /**
   * Converts an Oracle date format to the corresponding Excel date format.
   * @param p_format The Oracle date format to convert.
   * @return Corresponding Excel date format.
   */
   FUNCTION orafmt2excel (p_format VARCHAR2 := NULL)
      RETURN VARCHAR2;

   /**
   * Converts an Oracle number format to the corresponding Excel number format.
   * @param The Oracle number format to convert.
   * @return Corresponding Excel number format.
   */
   FUNCTION oranumfmt2excel (p_format VARCHAR2)
      RETURN VARCHAR2;

   /**
   * Get ID for given number format.
   * @param p_format Wanted number formatting using Excle number format.
   *                 Use OraNumFmt2Excel to convert from Oracle to Excel.
   * @return ID for given number format.
   */
   FUNCTION get_numfmt (p_format VARCHAR2 := NULL)
      RETURN PLS_INTEGER;

   /**
   * Get ID for given font settings.
   * @param p_name
   * @param p_family
   * @param p_fontsize
   * @param p_theme
   * @param p_underline
   * @param p_italic
   * @param p_bold
   * @param p_rgb
   * @return ID for given font definition
   */
   FUNCTION get_font (p_name         VARCHAR2,
                      p_family       PLS_INTEGER := 2,
                      p_fontsize     NUMBER := 8,
                      p_theme        PLS_INTEGER := 1,
                      p_underline    BOOLEAN := FALSE,
                      p_italic       BOOLEAN := FALSE,
                      p_bold         BOOLEAN := FALSE,
                      p_rgb          VARCHAR2 := NULL                        -- this is a hex ALPHA Red Green Blue value, but RGB works also
                                                     )
      RETURN PLS_INTEGER;

   /**
   * Get ID for given cell fill
   * @param p_patternType Pattern for the fill.
   * @param p_fgRGB       Color using an ARGB or RGB hex value
   * @return ID for given cell fill.
   */
   FUNCTION get_fill (p_patterntype VARCHAR2, p_fgrgb VARCHAR2 := NULL)
      RETURN PLS_INTEGER;

   /**
   * Get ID for given border definition.
   * Possible values for all parameters:
   * none, thin, medium, dashed, dotted, thick, double, hair, mediumDashed,
   * dashDot, mediumDashDot, dashDotDot, mediumDashDotDot, slantDashDot
   * @param p_top    Style for top border
   * @param p_bottom Style for bottom border
   * @param p_left   Style for left border
   * @param p_right  Style for right border
   * @return ID for given border definition
   */
   FUNCTION get_border (p_top       VARCHAR2 := 'thin',
                        p_bottom    VARCHAR2 := 'thin',
                        p_left      VARCHAR2 := 'thin',
                        p_right     VARCHAR2 := 'thin')
      RETURN PLS_INTEGER;

   /**
   * Function to get a record holding alignment data.
   * @param p_vertical   Vertical alignment.
   *                     (bottom, center, distributed, justify, top)
   * @param p_horizontal Horizontal alignment.
   *                     (center, centerContinuous, distributed, fill, general, justify, left, right)
   * @param p_wraptext   Switch to allow or disallow text wrapping.
   * @return Record with alignment data.
   */
   FUNCTION get_alignment (p_vertical VARCHAR2 := NULL, p_horizontal VARCHAR2 := NULL, p_wraptext BOOLEAN := NULL)
      RETURN t_alignment_rec;

   /**
   * Puts a number value into a cell of the spreadsheet.
   * @param p_col       Column number where the cell is located
   * @param p_row       Row number where the cell is located
   * @param p_value     The value to put into the cell
   * @param p_numFmtId  ID of number format
   * @param p_fontId    ID of font defintion
   * @param p_fillId    ID of fill definition
   * @param p_borderId  ID of border definition
   * @param p_alignment The wanted alignment
   * @param p_sheet     Worksheet the cell is located, if omitted last worksheet is used
   */
   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        NUMBER,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL);

   /**
   * Puts a character value into a cell of the spreadsheet.
   * @param p_col       Column number where the cell is located
   * @param p_row       Row number where the cell is located
   * @param p_value     The value to put into the cell
   * @param p_numFmtId  ID of formatting definition
   * @param p_fontId    ID of font defintion
   * @param p_fillId    ID of fill definition
   * @param p_borderId  ID of border definition
   * @param p_alignment The wanted alignment
   * @param p_sheet     Worksheet the cell is located, if omitted last worksheet is used
   * @param p_formula   The formula to put into the cell
   */
   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        VARCHAR2,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL,
                   p_formula      VARCHAR2 := NULL);

   /**
   * Puts a date value into a cell of the spreadsheet.
   * @param p_col       Column number where the cell is located
   * @param p_row       Row number where the cell is located
   * @param p_value     The value to put into the cell
   * @param p_numFmtId  ID of format definition
   * @param p_fontId    ID of font defintion
   * @param p_fillId    ID of fill definition
   * @param p_borderId  ID of border definition
   * @param p_alignment The wanted alignment
   * @param p_sheet     Worksheet the cell is located, if omitted last worksheet is used
   */
   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        DATE,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL);

   PROCEDURE hyperlink (p_col      PLS_INTEGER,
                        p_row      PLS_INTEGER,
                        p_url      VARCHAR2,
                        p_value    VARCHAR2 := NULL,
                        p_sheet    PLS_INTEGER := NULL);

   PROCEDURE comment (p_col       PLS_INTEGER,
                      p_row       PLS_INTEGER,
                      p_text      VARCHAR2,
                      p_author    VARCHAR2 := NULL,
                      p_width     PLS_INTEGER := 150                                                                               -- pixels
                                                    ,
                      p_height    PLS_INTEGER := 100                                                                               -- pixels
                                                    ,
                      p_sheet     PLS_INTEGER := NULL);

   PROCEDURE mergecells (p_tl_col    PLS_INTEGER                                                                                 -- top left
                                                ,
                         p_tl_row    PLS_INTEGER,
                         p_br_col    PLS_INTEGER                                                                             -- bottom right
                                                ,
                         p_br_row    PLS_INTEGER,
                         p_sheet     PLS_INTEGER := NULL);

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
                             p_sheet          PLS_INTEGER := NULL) ;

   PROCEDURE list_validation (p_sqref_col        PLS_INTEGER,
                              p_sqref_row        PLS_INTEGER,
                              p_tl_col           PLS_INTEGER                                                                       -- top left
                                                            ,
                              p_tl_row           PLS_INTEGER,
                              p_br_col           PLS_INTEGER                                                                   -- bottom right
                                                            ,
                              p_br_row           PLS_INTEGER,
                              p_style            VARCHAR2 := 'stop'                                              -- stop, warning, information
                                                                   ,
                              p_title            VARCHAR2 := NULL,
                              p_prompt           VARCHAR2 := NULL,
                              p_show_error       BOOLEAN := FALSE,
                              p_error_title      VARCHAR2 := NULL,
                              p_error_txt        VARCHAR2 := NULL,
                              p_sheet            PLS_INTEGER := NULL,
                              p_sheet_datasource PLS_INTEGER := NULL);

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
                              p_sheet           PLS_INTEGER := NULL);

   PROCEDURE defined_name (p_tl_col        PLS_INTEGER                                                                           -- top left
                                                      ,
                           p_tl_row        PLS_INTEGER,
                           p_br_col        PLS_INTEGER                                                                       -- bottom right
                                                      ,
                           p_br_row        PLS_INTEGER,
                           p_name          VARCHAR2,
                           p_sheet         PLS_INTEGER := NULL,
                           p_localsheet    PLS_INTEGER := NULL);

   PROCEDURE set_column_width (p_col PLS_INTEGER, p_width NUMBER, p_sheet PLS_INTEGER := NULL);

   PROCEDURE set_column (p_col          PLS_INTEGER,
                         p_numfmtid     PLS_INTEGER := NULL,
                         p_fontid       PLS_INTEGER := NULL,
                         p_fillid       PLS_INTEGER := NULL,
                         p_borderid     PLS_INTEGER := NULL,
                         p_alignment    t_alignment_rec := NULL,
                         p_sheet        PLS_INTEGER := NULL);

   PROCEDURE set_row (p_row          PLS_INTEGER,
                      p_numfmtid     PLS_INTEGER := NULL,
                      p_fontid       PLS_INTEGER := NULL,
                      p_fillid       PLS_INTEGER := NULL,
                      p_borderid     PLS_INTEGER := NULL,
                      p_alignment    t_alignment_rec := NULL,
                      p_sheet        PLS_INTEGER := NULL);

   PROCEDURE freeze_rows (p_nr_rows PLS_INTEGER := 1, p_sheet PLS_INTEGER := NULL);

   PROCEDURE freeze_cols (p_nr_cols PLS_INTEGER := 1, p_sheet PLS_INTEGER := NULL);

   PROCEDURE freeze_pane (p_col PLS_INTEGER, p_row PLS_INTEGER, p_sheet PLS_INTEGER := NULL);

   PROCEDURE set_autofilter (p_column_start    PLS_INTEGER := NULL,
                             p_column_end      PLS_INTEGER := NULL,
                             p_row_start       PLS_INTEGER := NULL,
                             p_row_end         PLS_INTEGER := NULL,
                             p_sheet           PLS_INTEGER := NULL);

   FUNCTION finish
      RETURN BLOB;

   FUNCTION query2sheet (p_sql VARCHAR2, p_column_headers BOOLEAN := TRUE, p_sheet PLS_INTEGER := NULL, p_skip_header boolean := FALSE)
      RETURN BLOB;

   FUNCTION finish2 (p_clob                 IN OUT NOCOPY CLOB,
                     p_columns              PLS_INTEGER,
                     p_rows                 PLS_INTEGER,
                     p_XLSX_date_format     VARCHAR2,
                     p_XLSX_datetime_format VARCHAR2)
      RETURN BLOB;

   FUNCTION query2sheet2(p_sql                  VARCHAR2,
                         p_XLSX_date_format     VARCHAR2 := 'dd/mm/yyyy',
                         p_XLSX_datetime_format VARCHAR2 := 'dd/mm/yyyy hh24:mi:ss')
      RETURN BLOB;

   function query2sheet3
   (
     p_sql     in varchar2
   , p_binds   in t_bind_tab
   , p_headers in t_header_tab
   , p_XLSX_date_format     VARCHAR2 := 'dd/mm/yyyy'
   , p_XLSX_datetime_format VARCHAR2 := 'dd/mm/yyyy hh24:mi:ss'
   )
      return blob;

END;
/