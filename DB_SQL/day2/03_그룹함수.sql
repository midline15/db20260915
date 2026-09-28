--그룹함수

--sum, avg, max, min, count
--sum
SELECT
    SUM(pay)
FROM
    professor;

-- 정교수들의 급여의 합
SELECT
    SUM(pay)
FROM
    professor
WHERE
    position = '정교수';

--max min
SELECT
    MAX(pay),
    MIN(pay)
FROM
    professor;

--avg
SELECT
    AVG(pay)
FROM
    professor;

--count
SELECT
    COUNT(*),  -- 전체 레코드 수
    COUNT(name), -- name이 널이 아닌 레코드 수
    COUNT(bonus) --bonus가 널이 아닌 레코드 수
FROM
    professor;

-----------------------------------------------------------------------

--group by 그룹화
SELECT
    position,
    round(
        avg(pay),
        2
    )
FROM
    professor
GROUP BY
    position;

--그룹함수에서 where와 having 차이
-- where 그룹화 하기전에 조건으로 먼저 걸러냄
-- having 그룹화 이후 조건

-- 직급별 급여 평균, 단, 급여가 300 이상인 사람들을 대상
-- 직급별 급여평균이 400이하인 직급 구하기
SELECT
    position AS 직급,
    round(
        avg(pay),
        2
    )        AS "급여 평균"
FROM
    professor
WHERE
    pay >= 300
GROUP BY
    position
HAVING
    AVG(pay) <= 400;
    
--grout은 두개이상 컬럼으로 가능
--각학과별 성별 학생수 구하기
SELECT
    stu_dept AS 학과,
    stu_gender as 성별,
    COUNT(*) AS "총 원(명)"
FROM
    student
GROUP BY
    stu_dept,stu_gender;

---------------------------------------------------------

-- 각 학과별 학생수가 3이하인 학과명과 학생 수 출력
SELECT
    stu_dept AS 학과,
    COUNT(*) AS "총 원(명)"
FROM
    student
GROUP BY
    stu_dept
HAVING
    COUNT(*) <= 3;

-- 각 성별에서 가장 키가 큰 학생의 성별 키 구하기
SELECT
    stu_gender,
    MAX(stu_height)
FROM
    student
GROUP BY
    stu_gender;
    
-- 각 학과별 학생들의 평균키 구하기, 단 165 이하는 제외
select
    stu_dept,
    round(avg(stu_height))
from student
where stu_height > 165
group by stu_dept;

-- 각 학과에서 키가 170 이상인 학생들의 학생수 구하기
-- 학과명, 학생수
select
    stu_dept as 학과명,
    count(*) as "학생 수"
from student
where stu_height >= 170
group by stu_dept;