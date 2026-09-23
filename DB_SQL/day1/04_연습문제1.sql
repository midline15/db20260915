-- PROFESSOR 테이블 기준

-- 1. 아래 정보에 맞게 PROFESSOR 테이블에 INSERT 하시오.
--    교수번호 : 1234, 이름 : 김교수, 아이디 : test12, 직급 : 정교수, 급여 : 500
--    입사일 : SYSDATE 
INSERT INTO professor (
    profno,
    name,
    id,
    position,
    pay,
    hiredate
) VALUES ( '1234',
           '김교수',
           'test12',
           '정교수',
           500,
           sysdate );
  
-- 2. 보너스가 NULL이 아닌 데이터를 조회하시오.
SELECT
    *
FROM
    professor
WHERE
    bonus IS NOT NULL;
 
-- 3. 200~400 사이의 급여를 받는 데이터를 조회하시오. ( BETWEEN 사용 )
SELECT
    *
FROM
    professor
WHERE
    pay BETWEEN 200 AND 400;
 
-- 4. 이름이 '김'씨로 시작하는 데이터를 조회하시오.
SELECT
    *
FROM
    professor
WHERE
    name LIKE '김%';

-- 5. 직급이 '조교수' 이면서 급여가 250이상인 데이터를 조회하시오.
SELECT
    *
FROM
    professor
WHERE
        position = '조교수'
    AND pay >= 250;
 
-- 6. 직급이 '조교수' 이거나 '정교수'인 데이터를 조회하시오. ( IN 사용 )
SELECT
    *
FROM
    professor
WHERE
    position IN ( '조교수', '정교수' );
 
-- 7. 교수번호가 1234인 데이터의 급여를 50증가 시키시오.
UPDATE professor
SET
    pay = pay + 50
WHERE
    profno = '1234';
 
-- 8. 교수번호가 1234인 데이터를 삭제하시오.
DELETE FROM professor
WHERE
    profno = '1234';