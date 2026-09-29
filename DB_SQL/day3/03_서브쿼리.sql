--서브쿼리
SELECT
    MAX(stu_height)
FROM
    student;

SELECT
    *
FROM
    student
WHERE
    stu_height = (
        SELECT
            MAX(stu_height)
        FROM
            student
    );

--두개이상의 레코드 조건절에서 서브쿼리
SELECT
    *
FROM
    student
WHERE
    stu_height IN (
        SELECT
            MAX(stu_height)
        FROM
            student
        UNION
        SELECT
            MIN(stu_height)
        FROM
            student
    );


--유니온
SELECT
    MAX(stu_height)
FROM
    student
UNION
SELECT
    MIN(stu_height)
FROM
    student;
    
    
--각 학과별 가장 키가 큰 사람
SELECT
    stu_dept,
    MAX(stu_height)
FROM
    student
GROUP BY
    stu_dept;

SELECT
    *
FROM
    student
WHERE
    stu_height IN (
        SELECT
            MAX(stu_height)
        FROM
            student
        GROUP BY
            stu_dept
    ); -- 다른학과의 같은 키를 가진 학생도 조회해버림

SELECT
    *
FROM
    student
WHERE
    ( stu_dept, stu_height ) IN (
        SELECT
            stu_dept, MAX(stu_height)
        FROM
            student
        GROUP BY
            stu_dept
    );
    
    
--서브쿼리
SELECT
    stu_no,
    stu_name,
    stu_dept,
    (
        SELECT
            AVG(enr_grade)
        FROM
            enrol
    ) -- select 절에서 가능. 성능 안좋음
FROM
    student;

SELECT
    stu_no,
    stu_name,
    stu_dept,
    avs
FROM
         student
    INNER JOIN (
        SELECT
            AVG(enr_grade) AS avs
        FROM
            enrol
    ) ON 1 = 1;

-------------------------------------------------------------------

--각 직급별 가장 높은 급여를 갖는 교수의 이름,직급, 급여 출력
SELECT
    name,
    position,
    pay
FROM
    professor
WHERE
    ( position, pay ) IN (
        SELECT
            position, MAX(pay)
        FROM
            professor
        GROUP BY
            position
    );

--본인의 학과 평균 점수보다 높은 평균 점수를 가진 학생의 학번 이름 평균점수 출력
SELECT
    s.stu_no,
    stu_name,
    s.stu_dept,
    AVG(enr_grade) AS avg_score,
    dept_score
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
    INNER JOIN (
        SELECT
            stu_dept,
            AVG(enr_grade) AS dept_score
        FROM
                 student s
            INNER JOIN enrol e ON e.stu_no = s.stu_no
        GROUP BY
            stu_dept
    )     t ON s.stu_dept = t.stu_dept
GROUP BY
    s.stu_no,
    stu_name,
    s.stu_dept,
    dept_score
HAVING
    AVG(enr_grade) > dept_score
ORDER BY
    s.stu_dept;
    
--본인 학과의 평균 키보다 큰 학생 출력
SELECT
    stu_no,
    stu_name,
    s.stu_dept,
    stu_height,
    평균키
FROM
         student s
    INNER JOIN (
        SELECT
            stu_dept,
            AVG(stu_height) AS 평균키
        FROM
            student
        GROUP BY
            stu_dept
    ) t ON s.stu_dept = t.stu_dept
WHERE
    stu_height > 평균키;