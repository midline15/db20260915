--(PROFESSOR, STU, DEPARTMENT) 
-- 1. 많은 급여를 받는 상위 5명 교수의 이름, 급여, 순위를 출력하시오.
SELECT
    *
FROM
    (
        SELECT
            name,
            pay,
            RANK()
            OVER(
                ORDER BY
                    pay DESC
            ) AS rank1
        FROM
            professor
    )
WHERE
    rank1 <= 5;

-- 2. 각 학과별 가장 높은 급여를 받는 교수의 이름, 학과, 급여를 출력
SELECT
    name,
    dname,
    pay
FROM
    (
        SELECT
            name,
            dname,
            pay,
            RANK()
            OVER(PARTITION BY p.deptno
                 ORDER BY
                     pay DESC
            ) AS rank1
        FROM
                 professor p
            INNER JOIN department d ON p.deptno = d.deptno
    )
WHERE
    rank1 = 1;



-- 3. (STU) 각 성별에서 키가 가장 큰 학생의 이름, 성별, 키 출력 
SELECT
    name,
    gender,
    height
FROM
    (
        SELECT
            name,
            decode(
                substr(jumin, 7, 1),
                1,
                '남자',
                '여자'
            ) AS gender,
            height,
            RANK()
            OVER(PARTITION BY substr(jumin, 7, 1)
                 ORDER BY
                     height DESC
            ) AS rank1
        FROM
            stu
    )
WHERE
    rank1 = 1;


--(EMP)
-- 4. 부서(DEPTNO)별 평균 급여가 가장 높은 부서의 부서명, 평균 급여 출력
SELECT
    deptno,
    dname,
    avg_sal
FROM
    (
        SELECT
            e.deptno,
            dname,
            AVG(sal) AS avg_sal,
            RANK()
            OVER(
                ORDER BY
                    AVG(sal) DESC
            )        AS rank1
        FROM
                 emp e
            INNER JOIN dept d ON e.deptno = d.deptno
        GROUP BY
            e.deptno,
            dname
    )
WHERE
    rank1 = 1;