-- PROFESSOR
-- 1. 가장 높은 급여를 받는 사람의 교수번호, 이름, 급여 출력
SELECT
    profno,
    name,
    pay
FROM
    professor
WHERE
    pay = (
        SELECT
            MAX(pay)
        FROM
            professor
    );

-- 2. 전체 평균 급여보다 높은 급여를 받는 교수의 교수번호, 이름, 급여 출력
SELECT
    profno,
    name,
    pay
FROM
    professor
WHERE
    pay > (
        SELECT
            AVG(pay)
        FROM
            professor
    );

-- 3. 본인의 직급 평균 급여보다 높은 급여를 받는 교수의 교수번호, 이름, 급여 출력
SELECT
    profno,
    name,
    pay
FROM
         professor p
    INNER JOIN (
        SELECT
            position,
            AVG(pay) AS ap
        FROM
            professor
        GROUP BY
            position
    ) t ON p.position = t.position
WHERE
    pay > ap;

-- EMP, SALGRADE, DEPT
-- 4. 가장 높은 급여를 받는 사람과 가장 적은 급여를 받는 사원의 사번, 이름, 급여 출력
SELECT
    empno,
    ename,
    sal
FROM
    emp e
WHERE
    sal IN (
        SELECT
            MAX(sal)
        FROM
            emp
        UNION
        SELECT
            MIN(sal)
        FROM
            emp
    );

-- 5. 부서별(DEPTNO) 가장 높은 급여를 받는 사람과 가장 적은 급여를 받는 사람의 사번, 이름, 부서명, 급여 출력
SELECT
    empno,
    ename,
    dname,
    sal
FROM
         emp e
    INNER JOIN dept d ON e.deptno = d.deptno
    INNER JOIN (
        SELECT
            deptno,
            MAX(sal) AS 최고,
            MIN(sal) AS 최저
        FROM
            emp
        GROUP BY
            deptno
    )    t ON e.deptno = t.deptno
WHERE
    sal IN ( 최고, 최저 );

-- 6. 본인 직급의 평균 급여 등급보다 높은 급여등급을 가진 사람의 사번, 이름, 급여등급 출력
SELECT
    empno,
    ename,
    grade
FROM
         emp e
    INNER JOIN salgrade ON sal BETWEEN losal AND hisal
    INNER JOIN (
        SELECT
            job,
            AVG(grade) AS ag
        FROM
                 emp
            INNER JOIN salgrade ON sal BETWEEN losal AND hisal
        GROUP BY
            job
    ) t ON e.job = t.job
WHERE
    grade > ag;