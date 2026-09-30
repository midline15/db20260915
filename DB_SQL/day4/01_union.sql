--union, union all

SELECT
    stu_no,
    stu_name,
    stu_dept
FROM
    student
WHERE
    stu_height >= 170
UNION -- 중복없이
SELECT
    stu_no,
    stu_name,
    stu_dept
FROM
    student
WHERE
    stu_weight >= 60;

SELECT
    stu_no,
    stu_name,
    stu_dept
FROM
    student
WHERE
    stu_height >= 170
UNION ALL   -- 중복허용
SELECT
    stu_no,
    stu_name,
    stu_dept
FROM
    student
WHERE
    stu_weight >= 60;

-- 1. 컬럼의 갯수가 동일해야 한다.
-- 2. 컬럼의 타입도 동일해야 한다.
-- 3. 컬럼 이름, 별칭은 먼저 나오는 값을 기준으로 출력된다.
-- 4. 정렬은 맨 마지막에 작성, 첫번째 쿼리 컬럼을 기준으로한다.

-----------------------------------------------------------------------

SELECT
    AVG(stu_heigth)
FROM
    student
UNION
SELECT
    stu_name
FROM
    student; -- 타입이 다름

SELECT
    AVG(stu_height)
FROM
    student
UNION
SELECT
    MAX(stu_height),
    MIN(stu_height)
FROM
    student; -- 컬럼 수가 다름

SELECT
    AVG(stu_height) AS aaa
FROM
    student
UNION
SELECT
    MAX(stu_height) AS hhh
FROM
    student; -- 별칭은 처음꺼

SELECT
    AVG(stu_height) AS aaa
FROM
    student
UNION
SELECT
    MAX(stu_height) AS hhh
FROM
    student
ORDER BY
    qqq; -- 정렬은 마지막에만

-- 학생들의 평균 점수 구하기
-- 전체평균 구하기
-- 합치기

SELECT
    1 as orderkey,
    stu_name,
    AVG(enr_grade) as avg_grade
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    stu_name
UNION
SELECT
    2,
    '전체평균',
    AVG(enr_grade) as avg_grade
FROM
    enrol
order by orderkey;

select stu_name, avg_grade
from (
SELECT
    1 as orderkey,
    stu_name,
    AVG(enr_grade) as avg_grade
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    stu_name
UNION
SELECT
    2,
    '전체평균',
    AVG(enr_grade)
FROM
    enrol
order by orderkey
); -- 오더키 숨기기

--직급별 평균급여 출력
--마지막에는 전체 평균 급여 급여
select
    1,
    job,
    avg(sal)
from emp
group by job
union
select
    2,
    '전체 평균 급여',
    avg(sal)
from emp
order by 1;