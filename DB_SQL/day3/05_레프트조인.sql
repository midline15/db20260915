--outer join
--left outer join
SELECT
    *
FROM
    student s
    LEFT JOIN enrol   e ON s.stu_no = e.stu_no;

--각 학생별 시험평균점수 출력, 시험을 안 본 학생은 '점수없음' 출력
SELECT
    s.stu_no,
    stu_name,
    nvl(
        to_char(avg(enr_grade)),
        '점수없음'
    )
FROM
    student s
    LEFT JOIN enrol   e ON s.stu_no = e.stu_no
GROUP BY
    s.stu_no,
    stu_name;

--각 학생들이 본 시험의 수 출력
--시험을 안 본 친구들 0으로 출력
SELECT
    s.stu_no,
    stu_name,
    COUNT(enr_grade)
FROM
    student s
    LEFT JOIN enrol   e ON s.stu_no = e.stu_no
GROUP BY
    s.stu_no,
    stu_name;

-- inner & left
SELECT
    name,
    d1.dname,
    d2.dname
FROM
         stu s
    INNER JOIN department d1 ON s.deptno1 = d1.deptno
    LEFT JOIN department d2 ON s.deptno2 = d2.deptno;

------------------------------------------------------------

-- 학생이름, 담당교수이름 출력. 담당교수 없으면 '담당없음' 출력
SELECT
    s.name,
    nvl(p.name, '담당없음')
FROM
    stu       s
    LEFT JOIN professor p ON s.profno = p.profno;

-- 각 교수가 담당하고 있는 학생의 수 출력, 없으면 0으로 출력
SELECT
    p.profno,
    p.name,
    COUNT(s.stuno)
FROM
    professor p
    LEFT JOIN stu       s ON p.profno = s.profno
GROUP BY
    p.profno,
    p.name;

-- 부하 직원의 수 구하기 없으면 0으로 출력
SELECT
    e1.empno,
    e1.ename,
    COUNT(e2.empno)
FROM
    emp e1
    LEFT JOIN emp e2 ON e1.empno = e2.mgr
GROUP BY
    e1.empno,
    e1.ename;