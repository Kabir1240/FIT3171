/*
Databases Week 9 Applied Class
week9_sql_basic_intermediate.sql

student id: 
student name:
applied class number:
last modified date:

*/

/* Part A - Retrieving data from a single table */

-- A1
select *
from uni.student
where upper(stuaddress) LIKE upper('%caulfield')
order by stuid;

-- A2
select *
from uni.unit
where upper(unitcode) LIKE upper('FIT1%')
order by unitcode;

-- A3
select stuid, stulname, stufname, stuaddress
from uni.student;
--where upper(stufname) = upper('s%')
--order by stuid;

-- A4


-- A5


-- A6




/* Part B - Retrieving data from multiple tables */

-- B1


-- B2


-- B3


-- B4
select unitcode, unitname, ofsemester, to_char(ofyear, 'yyy') as year,
nvl(to_char(enrolmark, '999'), 'N/A') as enrolmark,
nvl(enrolgrade, 'N/A')
where upper(stulname) = upper('Kilgour') and upper(stufname) = upper ('Brier')
from uni.student s
join uni.enrolment e on s.stuid = e.stuid
join uni.unit u on e.unitcode = u.unitcode
order by year, ofsemester, unitcode;

-- Cause ambiguously defined error because we dont know where we want to 
-- compare stuid from

-- B5


-- B6


-- B7


-- B8



/* Part C - Aggregate Function, Group By and Having */

-- C1


-- C2


-- C3
select unitcode, count(prerequnitcode) as "number of prereq"
from uni.prereq
group by unitcode
order by unitcode;

-- C4


-- C5
select unitcode, ofsemester, count(stuid) as "total no enrolment"
from uni.enrolment
where to_char(ofyear, 'yyyy') = 2019
group by ofsemester, unitcode
order by "total no enrolment", unitcode, ofsemester;

-- C6


-- C7
select unitcode, unitname
from uni.unit
join uni.enrolment using (unitcode)
where ofsemester = 2 and to_char(ofyear, 'yyyy') = 2021
and upper(enrolgrade) = 'DEF'
group by unitcode, unitname
having count(stuid) >= 2
order by unitcode, unitname;