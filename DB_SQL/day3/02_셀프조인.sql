--self join
SELECT
    e1.empno,
    e1.ename,
    e2.ename
FROM
         emp e1
    INNER JOIN emp e2 ON e1.mgr = e2.empno;

--학과 학부 대학
SELECT
    d1.dname,
    d2.dname,
    d3.dname
FROM
         department d1
    INNER JOIN department d2 ON d1.part = d2.deptno
    INNER JOIN department d3 ON d2.part = d3.deptno;
    
--공과 대학에 속한 학생들 출력
SELECT
    s.name,
    d1.dname,
    d2.dname,
    d3.dname
FROM
         stu s
    INNER JOIN department d1 ON d1.deptno = s.deptno1
    INNER JOIN department d2 ON d1.part = d2.deptno
    INNER JOIN department d3 ON d2.part = d3.deptno
WHERE
    d3.deptno = 10;

--각 대학별 교수의 수
SELECT
    d3.dname,
    COUNT(*)
FROM
         professor p
    INNER JOIN department d1 ON d1.deptno = p.deptno
    INNER JOIN department d2 ON d1.part = d2.deptno
    INNER JOIN department d3 ON d2.part = d3.deptno
GROUP BY
    d3.deptno,
    d3.dname;
    
-- 본인의 부하직원 수 구하기 이름 부하직원수 출력
select 
    e2.ename,
    count(*)
from emp e1
inner join emp e2 on e1.mgr = e2.empno
group by e2.empno, e2.ename;