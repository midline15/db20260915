-- STUDENT, ENROL, SUBJECT
-- 1. 과목별 평균 점수 출력 (출력 : 과목이름, 평균점수)
SELECT
    sub_name       과목이름,
    AVG(enr_grade) 평균점수
FROM
         enrol e
    INNER JOIN student s ON e.stu_no = s.stu_no
    INNER JOIN subject sub ON e.sub_no = sub.sub_no
GROUP BY
    sub_name;

-- 2. 학생별 시험 평균 점수 출력. 단 평균 60점 이상만(출력 : 학번, 이름, 평균점수)
SELECT
    s.stu_no       학번,
    stu_name       이름,
    AVG(enr_grade) 평균점수
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    s.stu_no,
    stu_name
HAVING
    AVG(enr_grade) >= 60;

-- 3. 2개이상의 시험을 본 학생들의 이름, 시험개수 출력
SELECT
    stu_name 이름,
    COUNT(*) 시험개수
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    stu_name
HAVING
    COUNT(*) >= 2;

-- 4. '강종영' 교수의 수업을 들은(시험을 본) 학생의 학번, 이름, 학과, 시험점수 출력
SELECT
    s.stu_no  학번,
    stu_name  이름,
    stu_dept  학과,
    enr_grade 시험점수
FROM
         student s
    INNER JOIN enrol   e ON e.stu_no = s.stu_no
    INNER JOIN subject sub ON sub.sub_no = e.sub_no
WHERE
    sub_prof = '강종영';

-- EMP, DEPT, SALGRADE
-- 5. 급여 등급이 3이상인 사람의 사번, 이름, 급여등급 출력
SELECT
    empno 사번,
    ename 이름,
    grade 급여등급
FROM
         emp e
    INNER JOIN salgrade s ON sal BETWEEN losal AND hisal
WHERE
    grade >= 3;

-- 6. 직급(JOB) 평균 급여 등급이 3이상인 직급, 급여등급 출력
SELECT
    job        직급,
    AVG(grade) 급여등급
FROM
         emp
    INNER JOIN salgrade s ON sal BETWEEN losal AND hisal
GROUP BY
    job
HAVING
    AVG(grade) >= 3;

-- 7. 직급별 급여 등급이 3이상인 사람의 수 출력(직급, 3등급 이상 사람 수)
SELECT
    job      직급,
    COUNT(*) "사람 수"
FROM
         emp
    INNER JOIN salgrade s ON sal BETWEEN losal AND hisal
WHERE
    grade >= 3
GROUP BY
    job;

-- 8. 부서별 평균 급여 출력. 단, 1800 이상인 부서만.(출력 : 부서번호, 부서이름, 평균 급여)
SELECT
    d.deptno 부서번호,
    dname    부서이름,
    AVG(sal) "평균 급여"
FROM
         dept d
    INNER JOIN emp e ON e.deptno = d.deptno
GROUP BY
    d.deptno,
    dname
HAVING
    AVG(sal) >= 1800;