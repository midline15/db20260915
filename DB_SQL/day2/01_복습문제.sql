-- 1. 다음 학생 정보를 STUDENT 테이블에 추가하시오.
--    학번 : 20262015
--    이름 : 박학생
--    학과 : 기계
--    학년 : 1
--    반 : A
--    성별 : F
--    키 : 165
--    몸무게 : 52
INSERT INTO student VALUES ( '20262015',
                             '박학생',
                             '기계',
                             1,
                             'A',
                             'F',
                             165,
                             52 );


-- 2. 몸무게가 NULL이 아닌 학생을 조회하시오.
SELECT
    *
FROM
    student
WHERE
    stu_weight IS NOT NULL;


-- 3. 키가 160 이상 175 이하인 학생을 조회하시오.
--    ( BETWEEN 사용 )
SELECT
    *
FROM
    student
WHERE
    stu_height BETWEEN 160 AND 175;


-- 4. 이름이 '이'씨로 시작하는 학생을 조회하시오.
SELECT
    *
FROM
    student
WHERE
    stu_name LIKE '이%';


-- 5. 학과가 '기계'이면서 몸무게가 60 이상인 학생을 조회하시오.
SELECT
    *
FROM
    student
WHERE
        stu_dept = '기계'
    AND stu_weight >= 60;


-- 6. 학과가 '컴퓨터정보' 또는 '전기전자'인 학생을 조회하시오.
--    ( IN 사용 )
SELECT
    *
FROM
    student
WHERE
    stu_dept IN ( '컴퓨터정보', '전기전자' );


-- 7. 학번이 20262015인 학생의 키를 3 증가시키시오.
UPDATE student
SET
    stu_height = stu_height + 3
WHERE
    stu_no = 20262015;


-- 8. 학번이 20262015인 학생을 삭제하시오.
DELETE student
WHERE
    stu_no = 20262015;
    
    
---------------------------------------------------------
SELECT
    concat(
        concat(stu_name, '_'),
        stu_no
    )         AS "이름 학번",
    stu_name
    || '_'
    || stu_no 이름_학번
FROM
    student;

SELECT
    stu_no,
    substr(stu_no, 5),
    substr(stu_no, 2, 3)
FROM
    student;

SELECT
    stu_dept,
    length(stu_dept)
FROM
    student;
    
select
    instr(email, '@')
from professor;

select
    id,
    rpad(id,10,'*'),
    substr(id,1,length(id)-3),
    rpad(substr(id,1,length(id)-3),length(id),'*')
from professor;

select
    substr(stu_name,1,2)||'*'
from student;

select
    name,
    length(name),
    substr(name,1,length(name)-1),
    substr(name,1,2)||'*',
    rpad(substr(name,1,length(name)-1),length(name)*1.7,'*') --바이트
from professor;