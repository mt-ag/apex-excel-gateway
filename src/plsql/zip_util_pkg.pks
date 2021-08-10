create or replace PACKAGE zip_util_pkg
  AUTHID CURRENT_USER
AS

/**
* Purpose:      Package handles zipping and unzipping of files
*
* Remarks:      by Anton Scheffer, see http://forums.oracle.com/forums/thread.jspa?messageID=9289744#9289744
*
*               for unzipping, see http://technology.amis.nl/blog/8090/parsing-a-microsoft-word-docx-and-unzip-zipfiles-with-plsql
*               for zipping, see http://forums.oracle.com/forums/thread.jspa?threadID=1115748&tstart=0
*
* Who     Date        Description
* ------  ----------  --------------------------------
* MBR     09.01.2011  Created
* MK      16.04.2014  Removed UTL_FILE dependencies and file operations
* MK      01.07.2014  Added get_file_clob to immediately retrieve file content as a CLOB
*
* @headcom
**/

  /** List of all files within zipped file */
  TYPE t_file_list IS TABLE OF CLOB;


  FUNCTION little_endian( p_big IN NUMBER
                        , p_bytes IN pls_integer := 4
                        )
    RETURN RAW;

  FUNCTION get_file_list( p_zipped_blob IN BLOB
                        , p_encoding IN VARCHAR2 := NULL /* Use CP850 for zip files created with a German Winzip to see umlauts, etc */
                        )
    RETURN t_file_list;

  FUNCTION get_file( p_zipped_blob IN BLOB
                   , p_file_name IN VARCHAR2
                   , p_encoding IN VARCHAR2 := NULL
                   )
    RETURN BLOB;

  FUNCTION get_file_clob( p_zipped_blob IN BLOB
                        , p_file_name IN VARCHAR2
                        , p_encoding IN VARCHAR2 := NULL
                        )
    RETURN CLOB;

  PROCEDURE add_file( p_zipped_blob IN OUT NOCOPY BLOB
                    , p_name IN VARCHAR2
                    , p_content IN BLOB
                    )
  ;

  PROCEDURE add_file( p_zipped_blob IN OUT NOCOPY BLOB
                    , p_name IN VARCHAR2
                    , p_content CLOB
                    )
  ;

  PROCEDURE finish_zip( p_zipped_blob IN OUT NOCOPY BLOB);

END zip_util_pkg;
/