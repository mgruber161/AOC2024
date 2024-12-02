CREATE OR REPLACE FUNCTION split_string(
    p_string VARCHAR2,
    p_delimiter VARCHAR2
) RETURN SYS.ODCIVARCHAR2LIST
PIPELINED IS
    v_start_index NUMBER := 1;
    v_end_index NUMBER;
BEGIN
    WHILE v_start_index <= LENGTH(p_string) LOOP
        v_end_index := INSTR(p_string, p_delimiter, v_start_index);
        IF v_end_index = 0 THEN
            PIPE ROW (SUBSTR(p_string, v_start_index));
            RETURN;
        END IF;
        
        PIPE ROW (SUBSTR(p_string, v_start_index, v_end_index - v_start_index));
        v_start_index := v_end_index + 1;
    END LOOP;
END split_string;