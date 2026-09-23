--insert
--1. 모든 컬럼에 값을 넣는 경우
-- 컬럼명 생략이 가능
INSERT INTO student VALUES ( '12123434',
                             '김철수',
                             '전기전자',
                             2,
                             'B',
                             'M',
                             170,
                             70 );

--2. 특정 컬럼만 값을 넣는 경우
-- 컬럼명을 명시해야 한다
INSERT INTO student (
    stu_name,
    stu_no,
    stu_dept
) VALUES ( '홍길동',
           '12345678',
           '기계' );

--update
UPDATE student
SET
    stu_grade = 3,
    stu_class = 'C'
WHERE
    stu_name = '김철수';
    
--delete
DELETE FROM student
WHERE
    stu_name = '홍길동';