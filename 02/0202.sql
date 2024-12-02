--2
DECLARE
    is_safe boolean;
    sum number := 0;
    num number := null;
    skip_count number := 0;
    last_num number := null;
    is_ascending BOOLEAN := null;
    prev_is_ascending BOOLEAN := null;
    second_is_ascending BOOLEAN := null;
    idx number := 0;
    second_num number := null;
BEGIN
    for line in (select * from aoc_input where day = 2 and key = 'INPUT') loop
        is_safe := true;
        is_ascending := null;
        prev_is_ascending := null;
        second_is_ascending := null;
        skip_count := 0;
        idx := 0;
        for part in (select * from table(SPLIT_STRING(line.line_str, ' '))) LOOP
            num := to_number(trim(part.COLUMN_VALUE));
            if last_num is not null THEN
                if (last_num - num = 0 or last_num - num > 3 or last_num - num < - 3) THEN
                    if (second_num is null or 
                    ( second_num - num = 0 or second_num - num > 3 or second_num - num < - 3 )) then
                        if(skip_count > 0) then
                            is_safe := false;
                            exit;
                        end if;
                        if(idx = 1) THEN
                            second_num := num;
                        end if;
                        skip_count := skip_count + 1;
                        CONTINUE;
                    end if;
                end if;

                if (last_num - num < 0) THEN
                    is_ascending := true;
                elsif (last_num - num > 0) THEN
                    is_ascending := false;
                end if;

                if (idx = 2 and second_num - num < 0) THEN
                    second_is_ascending := true;
                elsif (idx = 2 and second_num - num > 0) THEN
                    second_is_ascending := false;
                end if;

                if (is_ascending != prev_is_ascending) THEN
                    if ( second_is_ascending is null or second_is_ascending != is_ascending ) then
                        if(skip_count > 0) then
                            is_safe := false;
                            exit;
                        end if;
                        if(idx = 1) THEN
                            second_num := num;
                        end if;
                        skip_count := skip_count + 1;
                        CONTINUE;
                    end if;
                end if;
            end if;

            last_num := num;
            prev_is_ascending := is_ascending;
            second_is_ascending := null;
            second_num := null;
            idx := idx + 1;
        end loop;
        if is_safe = false THEN
            sum := sum + 1;
        end if;
        last_num := null;
    end loop;
    sum := 1000 - sum;
    DBMS_OUTPUT.PUT_LINE('sum p2: '|| SUM);
end;