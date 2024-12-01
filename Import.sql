INSERT INTO AOC_INPUT (day, key, line_no, line_str)
    WITH line_splits AS (
        SELECT 
            LEVEL AS line_number,
            TRIM(REGEXP_SUBSTR(:bind, '[^('||chr(13)||chr(10)||')]+', 1, LEVEL)) AS line_text
        FROM DUAL
        CONNECT BY 
            REGEXP_SUBSTR(:bind, '[^('||chr(13)||chr(10)||')]+', 1, LEVEL) IS NOT NULL
    )
    SELECT 1, 'INPUT', line_number, line_text
    FROM line_splits;
commit;