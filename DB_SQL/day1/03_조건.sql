--조건

--WHERE
-- = (같다) ><=(크거나작거나같다) ><(크다작다)

-- STUDENT 테이블에서 '김철수'의 모든 컬럼 조회
SELECT
    *
FROM
    student
WHERE
    stu_name = '김철수';
    
-- 키가 170이상인 학생들의 모든 컬럼 조회
SELECT
    *
FROM
    student
WHERE
    stu_height >= 170;

SELECT
    stu_name,
    stu_height
FROM
    student
WHERE
    stu_height IS NOT NULL;
    
-- 1학년이면서 여자인 학생들 출력
SELECT
    *
FROM
    student
WHERE
        stu_grade = 1
    AND stu_gender = 'F';

-- 2학년이거나 남자인 학생들 출력
SELECT
    *
FROM
    student
WHERE
    stu_grade = 2
    OR stu_gender = 'M';
    
--IN 같은 컬럼을 대상으로 OR 연산을 할 때
SELECT
    *
FROM
    student
WHERE
    stu_grade IN ( 1, 2 );

-- 키가 170이상 180이하인 학생 검색
SELECT
    *
FROM
    student
WHERE
        stu_height >= 170
    AND stu_height <= 180;

SELECT
    *
FROM
    student
WHERE
    stu_height BETWEEN 170 AND 180;

--특정 값 포함 여부를 검색할 수 있는 유용한 문법
SELECT
    *
FROM
    student
WHERE
    stu_no LIKE '2015%';
    
---------------------------------
SELECT
    *
FROM
    professor
WHERE
    email LIKE '%net';
    
SELECT * FROM professor WHERE EMAIL LIKE '%naver%';

select * from professor where position like '조__';

select sysdate from professor;