--조인
--각 고객이 구매한  내역 출력
SELECT
    *
FROM
         customer c
    JOIN orders o ON c.custid = o.custid
    JOIN book   b ON o.bookid = b.bookid
ORDER BY
    name;

SELECT
    e1.ename,
    e2.ename
FROM
    emp e1
    LEFT JOIN emp e2 ON e1.mgr = e2.empno;

--교수들이 속한 대학 출력
SELECT
    p.*,
    d3.dname
FROM
    professor  p
    LEFT JOIN department d1 ON p.deptno = d1.deptno
    LEFT JOIN department d2 ON d1.part = d2.deptno
    LEFT JOIN department d3 ON d2.part = d3.deptno;

SELECT
    s1.stu_no,
    COUNT(s2.stu_no)
FROM
         student s1
    JOIN student s2 ON s1.stu_height < s2.stu_height
GROUP BY
    s1.stu_no;

-- emp 테이블에서 본인 급여등급보다 높은 급여등급을 가진 직원의 수 구하기
-- 사번, 이름, 급여등급 사람수 출력
SELECT
    empno,
    ename,
    RANK()
    OVER(
        ORDER BY
            grade DESC
    ) - 1 AS 사람수,
    grade
FROM
         emp e
    INNER JOIN salgrade s ON e.sal BETWEEN losal AND hisal;

SELECT
    c.*,
    COUNT(o.orderid)
FROM
         customer c
    JOIN orders o ON c.custid = o.custid
GROUP BY
    c.custid,
    c.name,
    c.address,
    c.phone;

SELECT
    *
FROM
         professor p
    JOIN (
        SELECT
            deptno,
            COUNT(*)
        FROM
            professor
        GROUP BY
            deptno
    ) t ON t.deptno = p.deptno;
    
-- 학번, 이름, 전공, 부전공
SELECT
    stuno,
    name,
    d1.dname,
    nvl(d2.dname, '없음')
FROM
         stu
    JOIN department d1 ON stu.deptno1 = d1.deptno
    LEFT JOIN department d2 ON stu.deptno2 = d2.deptno;

-- 학번, 이름, 시험본 개수 출력, 단, 시험을 안본 학생은 0으로 출력
SELECT
    s.stu_no,
    s.stu_name,
    COUNT(enr_grade)
FROM
    student s
    LEFT JOIN enrol   e ON s.stu_no = e.stu_no
GROUP BY
    s.stu_no,
    s.stu_name;
    
--학생들의 평균 점수를 기준으로 순위 매기기

SELECT
    s.stu_no,
    s.stu_name,
    AVG(e.enr_grade) avg_grade,
    RANK()
    OVER(
        ORDER BY
            AVG(e.enr_grade) DESC
    )
FROM
         student s
    JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    s.stu_no,
    s.stu_name;