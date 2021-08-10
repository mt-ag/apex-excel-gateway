create or replace package body zip_util_pkg
is

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
* MBR     21.05.2012  Fixed a bug related to use of dbms_lob.substr in get_file (use dbms_lob.copy instead)
* MK      01.07.2014  Added get_file_clob to immediatly retrieve file content as a CLOB
*
* @headcom
*/

  /* Constants */
  c_max_length CONSTANT PLS_INTEGER := 32767;
  c_file_comment CONSTANT RAW(32767) := utl_raw.cast_to_raw('Implementation by Anton Scheffer');

  /**
  * Convert to little endian raw
  */
  FUNCTION little_endian( p_big IN NUMBER
                        , p_bytes IN pls_integer := 4
                        )
    RETURN RAW
  AS
  BEGIN
    RETURN utl_raw.substr( utl_raw.cast_from_binary_integer( p_big
                                                             , utl_raw.little_endian
                                                           )
                         , 1
                         , p_bytes
                         );
  END little_endian;

  FUNCTION get_modify_date( p_modify_date IN DATE DEFAULT SYSDATE)
    RETURN RAW
  AS
  BEGIN
    RETURN little_endian( to_number( to_char( p_modify_date, 'dd' ) )
                          + to_number( to_char( p_modify_date, 'mm' ) ) * 32
                          + ( to_number( to_char( p_modify_date, 'yyyy' ) ) - 1980 ) * 512
                        , 2
                        );
  END get_modify_date;

  FUNCTION get_modify_time( p_modify_date IN DATE DEFAULT SYSDATE)
    RETURN RAW
  AS
  BEGIN
    RETURN little_endian( to_number( to_char( p_modify_date, 'ss' ) ) / 2
                          + to_number( to_char( p_modify_date, 'mi' ) ) * 32
                          + to_number( to_char( p_modify_date, 'hh24' ) ) * 2048
                        , 2
                        );
  END get_modify_time;


  FUNCTION raw2num( p_value in raw )
    RETURN NUMBER
  AS
  BEGIN                                               -- note: FFFFFFFF => -1
    RETURN utl_raw.cast_to_binary_integer( p_value
                                         , utl_raw.little_endian
                                         );

  END raw2num;

  FUNCTION raw2varchar2( p_raw IN RAW
                       , p_encoding IN VARCHAR2
                       )
    RETURN VARCHAR2
  AS
  BEGIN
    RETURN nvl( utl_i18n.raw_to_char( p_raw
                                    , p_encoding
                                    )
              , utl_i18n.raw_to_char ( p_raw
                                     , utl_i18n.map_charset( p_encoding
                                                           , utl_i18n.generic_context
                                                           , utl_i18n.iana_to_oracle
                                                           )
                                     )
              );
  END raw2varchar2;

  FUNCTION raw2varchar2( p_zipped_blob IN BLOB
                       , p_start_index IN NUMBER
                       , p_end_index IN NUMBER
                       , p_encoding IN VARCHAR2
                       )
    RETURN VARCHAR2
  AS
  BEGIN
    RETURN raw2varchar2( dbms_lob.substr( p_zipped_blob
                                        , p_start_index
                                        , p_end_index
                                        )
                       , p_encoding
                       );
  END raw2varchar2;


  FUNCTION raw2num( p_zipped_blob IN BLOB
                  , p_start_index IN NUMBER
                  , p_end_index IN NUMBER
                  )
    RETURN NUMBER
  AS
  BEGIN
    RETURN raw2num( dbms_lob.substr( p_zipped_blob
                                   , p_start_index
                                   , p_end_index
                                   )
                  );
  END raw2num;

  FUNCTION get_file_list( p_zipped_blob IN BLOB
                        , p_encoding IN VARCHAR2 := NULL
  )
    RETURN t_file_list
  AS
    l_index INTEGER;
    l_header_index INTEGER;
    l_file_list t_file_list;
  BEGIN
    l_index := dbms_lob.getlength( p_zipped_blob ) - 21;
    LOOP
      EXIT WHEN dbms_lob.substr( p_zipped_blob, 4, l_index ) = hextoraw( '504B0506' )
             OR l_index < 1;
      l_index := l_index - 1;
    END LOOP;

    IF l_index <= 0 THEN
      RETURN NULL;
    END IF;

    l_header_index := raw2num( p_zipped_blob, 4, l_index + 16 ) + 1;
    l_file_list := t_file_list( );
    l_file_list.EXTEND( raw2num( p_zipped_blob, 2, l_index + 10 ) );

    FOR i IN 1 .. raw2num( p_zipped_blob, 2, l_index + 8 )
    LOOP
      l_file_list( i ) := raw2varchar2( p_zipped_blob
                                      , raw2num( p_zipped_blob, 2, l_header_index + 28 )
                                      , l_header_index + 46
                                      , p_encoding
                                      );
      l_header_index := l_header_index
                      + 46
                      + raw2num( dbms_lob.substr( p_zipped_blob, 2, l_header_index + 28 ) )
                      + raw2num( dbms_lob.substr( p_zipped_blob, 2, l_header_index + 30 ) )
                      + raw2num( dbms_lob.substr( p_zipped_blob, 2, l_header_index + 32 ) );
    END LOOP;

    RETURN l_file_list;
  END get_file_list;

  FUNCTION get_file( p_zipped_blob IN BLOB
                   , p_file_name IN VARCHAR2
                   , p_encoding IN VARCHAR2 := NULL
                   )
    RETURN BLOB
  AS
    l_retval BLOB;
    l_index INTEGER;
    l_header_index INTEGER;
    l_file_index INTEGER;
  BEGIN
    l_index := dbms_lob.getlength( p_zipped_blob ) - 21;
    LOOP
      EXIT WHEN dbms_lob.substr( p_zipped_blob, 4, l_index ) = hextoraw( '504B0506' )
             OR l_index < 1;
      l_index := l_index - 1;
    END LOOP;

    IF l_index <= 0 THEN
      RETURN NULL;
    END IF;

    l_header_index := raw2num( p_zipped_blob, 4, l_index + 16 ) + 1;
    FOR i IN 1 .. raw2num( p_zipped_blob, 2, l_index + 8 )
    LOOP
      IF p_file_name = raw2varchar2( p_zipped_blob
                                   , raw2num( p_zipped_blob, 2, l_header_index + 28 )
                                   , l_header_index + 46
                                   , p_encoding
                                   )
      THEN
        IF dbms_lob.substr( p_zipped_blob, 2, l_header_index + 10 ) = hextoraw( '0800' ) -- deflate
        THEN
          l_file_index := raw2num( p_zipped_blob, 4, l_header_index + 42 );
          l_retval := hextoraw( '1F8B0800000000000003' ); -- gzip r_header
          dbms_lob.copy( l_retval
                       , p_zipped_blob
                       , raw2num( p_zipped_blob, 4, l_file_index + 19 )
                       , 11
                       , l_file_index
                         + 31
                         + raw2num( p_zipped_blob, 2, l_file_index + 27 )
                         + raw2num( p_zipped_blob, 2, l_file_index + 29 )
                       );
          dbms_lob.append( l_retval
                         , dbms_lob.substr( p_zipped_blob, 4, l_file_index + 15 )
                         );
          dbms_lob.append( l_retval
                         , dbms_lob.substr( p_zipped_blob, 4, l_file_index + 23 )
                         );
          RETURN utl_compress.lz_uncompress( l_retval );
        END IF;
        IF dbms_lob.substr( p_zipped_blob, 2, l_header_index + 10) = hextoraw( '0000' ) -- The file is stored (no compression)
        THEN
          l_file_index := raw2num( p_zipped_blob, 4, l_header_index + 42 );

          dbms_lob.createtemporary(l_retval, cache => true);

          dbms_lob.copy(dest_lob => l_retval,
                        src_lob => p_zipped_blob,
                        amount => raw2num( p_zipped_blob, 4, l_file_index + 19 ),
                        dest_offset => 1,
                        src_offset => l_file_index + 31 + raw2num(dbms_lob.substr(p_zipped_blob, 2, l_file_index + 27)) + raw2num(dbms_lob.substr( p_zipped_blob, 2, l_file_index + 29))
                       );

          RETURN l_retval;                                        
        END IF;
      END IF;
      l_header_index := l_header_index
                      + 46
                      + raw2num( p_zipped_blob, 2, l_header_index + 28 )
                      + raw2num( p_zipped_blob, 2, l_header_index + 30 )
                      + raw2num( p_zipped_blob, 2, l_header_index + 32 );
    END LOOP;
    RETURN NULL;
  END get_file;

  FUNCTION get_file_clob( p_zipped_blob IN BLOB
                        , p_file_name IN VARCHAR2
                        , p_encoding IN VARCHAR2 := NULL
                        )
    RETURN CLOB
  AS
    l_file_blob BLOB;
    l_return CLOB;
    l_dest_offset INTEGER := 1;
    l_src_offset INTEGER := 1;
    l_warning INTEGER;
    l_lang_ctx INTEGER := dbms_lob.DEFAULT_LANG_CTX;
  BEGIN
    l_file_blob := get_file( p_zipped_blob => p_zipped_blob
                           , p_file_name => p_file_name
                           , p_encoding => p_encoding
                           );
    IF l_file_blob IS NULL THEN
      raise_application_error( -20000
                             , 'File not found...'
                             );
    END IF;
    dbms_lob.createtemporary (l_return, true);
    dbms_lob.converttoclob( dest_lob => l_return
                          , src_blob => l_file_blob
                          , amount => dbms_lob.lobmaxsize
                          , dest_offset => l_dest_offset
                          , src_offset => l_src_offset
                          , blob_csid => dbms_lob.default_csid
                          , lang_context =>l_lang_ctx
                          , warning => l_warning
                          );
    RETURN l_return;
  END get_file_clob;

  PROCEDURE add_file( p_zipped_blob IN OUT NOCOPY BLOB
                    , p_name IN VARCHAR2
                    , p_content IN BLOB
  )
  AS
    l_new_file BLOB;
    l_content_length INTEGER;
  BEGIN
    l_new_file := utl_compress.lz_compress( p_content );
    l_content_length := dbms_lob.getlength( l_new_file );

    IF p_zipped_blob IS NULL THEN
      dbms_lob.createtemporary( p_zipped_blob, true );
    END IF;
    dbms_lob.APPEND( p_zipped_blob
                   , utl_raw.concat ( hextoraw( '504B0304' )                                -- Local file r_header signature
                                    , hextoraw( '1400' )                                    -- version 2.0
                                    , hextoraw( '0000' )                                    -- no General purpose bits
                                    , hextoraw( '0800' )                                    -- deflate
                                    , get_modify_time                                       -- File last modification time
                                    , get_modify_date                                       -- File last modification date
                                    , dbms_lob.substr( l_new_file, 4, l_content_length - 7) -- CRC-321
                                    , little_endian( l_content_length - 18 )                -- compressed size
                                    , little_endian( dbms_lob.getlength( p_content ) )      -- uncompressed size
                                    , little_endian( LENGTH( p_name ), 2 )                  -- File name length
                                    , hextoraw( '0000' )                                    -- Extra field length
                                    , utl_raw.cast_to_raw( p_name )                         -- File name
                                    )
                   );
    dbms_lob.copy( p_zipped_blob
                 , l_new_file
                 , l_content_length - 18
                 , dbms_lob.getlength( p_zipped_blob ) + 1
                 , 11
                 );  -- compressed content
    dbms_lob.freetemporary( l_new_file );
  END add_file;

  PROCEDURE add_file( p_zipped_blob IN OUT NOCOPY BLOB
                    , p_name IN VARCHAR2
                    , p_content CLOB
                    )
  AS
    l_tmp BLOB;
    dest_offset INTEGER := 1;
    src_offset INTEGER := 1;
    l_warning INTEGER;
    l_lang_ctx INTEGER := dbms_lob.DEFAULT_LANG_CTX;
  BEGIN
    dbms_lob.createtemporary( l_tmp, true );
    dbms_lob.converttoblob( l_tmp
                          , p_content
                          , dbms_lob.lobmaxsize
                          , dest_offset
                          , src_offset
                          , nls_charset_id( 'AL32UTF8' ) 
                          , l_lang_ctx
                          , l_warning
                          );
    add_file( p_zipped_blob, p_name, l_tmp );
    dbms_lob.freetemporary( l_tmp );
  END add_file;

  PROCEDURE finish_zip( p_zipped_blob IN OUT NOCOPY BLOB )
  AS
    l_cnt pls_integer := 0;
    l_offset INTEGER;
    l_offset_directory INTEGER;
    l_offset_header INTEGER;
  BEGIN
    l_offset_directory := dbms_lob.getlength( p_zipped_blob );
    l_offset := dbms_lob.instr( p_zipped_blob
                              , hextoraw( '504B0304' )
                              , 1
                              );
    WHILE l_offset > 0 LOOP
      l_cnt := l_cnt + 1;
      dbms_lob.APPEND( p_zipped_blob
                     , utl_raw.concat( hextoraw( '504B0102' )                           -- Central directory file r_header signature
                                     , hextoraw( '1400' )                               -- version 2.0
                                     , dbms_lob.substr( p_zipped_blob, 26, l_offset + 4 )
                                     , hextoraw( '0000' )                               -- File comment length
                                     , hextoraw( '0000' )                               -- Disk number where file starts
                                     , hextoraw( '0100' )                               -- Internal file attributes
                                     , hextoraw( '2000B681' )                           -- External file attributes
                                     , little_endian( l_offset - 1 )                    -- Relative offset of local file r_header
                                     , dbms_lob.substr( p_zipped_blob
                                                      , utl_raw.cast_to_binary_integer( dbms_lob.substr( p_zipped_blob
                                                                                                       , 2
                                                                                                       , l_offset + 26
                                                                                                       )
                                                                                      , utl_raw.little_endian
                                                                                      )
                                                      , l_offset + 30
                                                      )                                 -- File name
                                    )
                     );
      l_offset := dbms_lob.instr( p_zipped_blob
                                , hextoraw( '504B0304' )
                                , l_offset + 32
                                );
    END LOOP;

    l_offset_header := dbms_lob.getlength( p_zipped_blob );
    dbms_lob.APPEND( p_zipped_blob
                  , utl_raw.concat( hextoraw( '504B0506' )                                         -- End of central directory signature
                                   , hextoraw( '0000' )                                            -- Number of this disk
                                   , hextoraw( '0000' )                                            -- Disk where central directory starts
                                   , little_endian( l_cnt, 2 )                                     -- Number of central directory records on this disk
                                   , little_endian( l_cnt, 2 )                                     -- Total number of central directory records
                                   , little_endian( l_offset_header - l_offset_directory )         -- Size of central directory
                                   , little_endian( l_offset_directory )                           -- Relative offset of local file r_header
                                   , little_endian( nvl( utl_raw.length( c_file_comment ), 0 ), 2) -- ZIP file comment length
                                   , c_file_comment
                                   )
                    );
  END finish_zip;

end zip_util_pkg;
/