
create table parts_day1(
    line_no number(4), new_line_no number(1), num number(20));

insert into parts_day1
SELECT 
    line_no,
    1,
    to_number(SUBSTR(LINE_STR, 1, INSTR(LINE_STR, ' ') - 1))    
FROM aoc_input;

insert into parts_day1
SELECT 
    line_no,
    2,
    to_number(SUBSTR(LINE_STR, INSTR(LINE_STR, ' ') + 1))    
FROM aoc_input;

--1
select sum(ABS(p1.num - p2.num)) 
from 
    (select row_number() over (order by num) row_num, num
        from parts_day1
        where new_line_no = 1) p1 
join 
    (select row_number() over (order by num) row_num, num
        from parts_day1
        where new_line_no = 2) p2 
on p1.row_num = p2.row_num
;

--2
select 
    sum(p1.num * (select count(*) from parts_day1 p2 where p1.num = p2.num and p2.NEW_LINE_NO = 2))
from parts_day1 p1
where p1.new_line_no = 1;
