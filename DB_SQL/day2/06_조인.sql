--조인
--student 테이블의 stu_no는 pk(primay key)
SELECT
    *
FROM
    student;
--enrol 테이블의 stu_no는 참조키(foriegn key)
SELECT
    *
FROM
    enrol;

-- inner join
-- 학번 이름 학과 - student, 점수 - enrol
SELECT
    s.stu_no,
    stu_name,
    stu_dept,
    enr_grade
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no;
--평균
SELECT
    s.stu_no,
    stu_name,
    stu_dept,
    AVG(enr_grade)
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    s.stu_no,
    stu_name,
    stu_dept;


--각 과목별 점수
SELECT
    *
FROM
    subject;

SELECT
    *
FROM
         subject s
    INNER JOIN enrol e ON s.sub_no = e.sub_no;


-- 학번 이름 학과 - student, 점수 - enrol 과목명 - subject
SELECT
    s.stu_no,
    stu_name,
    stu_dept,
    sub_name,
    enr_grade
FROM
         student s
    INNER JOIN enrol   e ON s.stu_no = e.stu_no
    INNER JOIN subject sub ON e.sub_no = sub.sub_no
ORDER BY
    stu_no;

--학과별 시험 평균 점수
SELECT
    stu_dept,
    AVG(enr_grade)
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    stu_dept;

--사번 이름 부서번호 부서이름    
SELECT
    empno,
    ename,
    d.deptno,
    dname
FROM
         emp e
    INNER JOIN dept d ON d.deptno = e.deptno;
    
--조인은 꼭 값이 같은 컬럼끼리 하는건 아니다
--사번 이름 급여 급여등급
SELECT
    empno,
    ename,
    sal,
    grade
FROM
         emp e
    INNER JOIN salgrade s ON sal BETWEEN losal AND hisal;
    
--부서별 급여 평균 등급 출력
-- 부서번호, 부서이름, 급여등급
SELECT
    d.deptno,
    dname,
    round(
        avg(grade),
        2
    )
FROM
         emp e
    INNER JOIN dept     d ON e.deptno = d.deptno
    INNER JOIN salgrade s ON sal BETWEEN losal AND hisal
GROUP BY
    d.deptno,
    dname;