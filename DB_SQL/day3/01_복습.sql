-- 학생이름, 학번,학과, 담당교수명
select
    s.name,
    stuno,
    dname,
    p.name
from stu s
inner join professor p on s.profno = p.profno
inner join department d on d.deptno= s.deptno1;

--각 학과별 학생 수, 학과명, 학생수 출력
select
    dname,
    count(*)
from stu s
inner join department d on d.deptno = s.deptno1
group by s.deptno1, dname;