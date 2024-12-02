--1
DECLARE
    is_safe boolean;
    sum number := 0;
    num number := null;
    last_num number := null;
    is_ascending BOOLEAN := null;
    prev_is_ascending BOOLEAN := null;
BEGIN
    for line in (select * from aoc_input where day = 2 and key = 'INPUT') loop
        is_safe := true;
        is_ascending := null;
        prev_is_ascending := null;
        for part in (select * from table(SPLIT_STRING(line.line_str, ' '))) LOOP
            num := to_number(trim(part.COLUMN_VALUE));
            if last_num is not null THEN
                if (last_num - num = 0 or last_num - num > 3 or last_num - num < - 3 ) THEN
                    is_safe := false;
                    EXIT;
                end if;

                if (last_num - num < 0) THEN
                    is_ascending := true;
                elsif (last_num - num > 0) THEN
                    is_ascending := false;
                end if;

                if (is_ascending != prev_is_ascending) THEN
                    is_safe := false;
                    exit;
                end if;
            end if;

            last_num := num;
            prev_is_ascending := is_ascending;
        end loop;
        if is_safe = false THEN
            sum := sum + 1;
        end if;
        last_num := null;
    end loop;
    sum := 1000 - sum;
    DBMS_OUTPUT.PUT_LINE('sum p1: '|| SUM);
end;
