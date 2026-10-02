--round, ceil, floore, trunc
SELECT
    trunc(
        avg(sal),
        1
    )
FROM
    emp;

SELECT
    ename,
    length(ename),
    substr(ename, 3)
FROM
    emp;

SELECT
    *
FROM
    student
WHERE
    substr(stu_no, 3, 2) = 15;

SELECT
    AVG(stu_height)
FROM
    student
GROUP BY
    substr(stu_no, 3, 2);

SELECT
    tel,
    length(tel),
    substr(tel,
           1,
           instr(tel, '-'))
    || '****'
FROM
    stu;

SELECT
    sysdate,
    to_char(sysdate, 'yyyy.mm.dd am hh24:mi:ss')
FROM
    dual;

SELECT
    *
FROM
    emp
WHERE
    to_char(hiredate, 'yy') = 81;

SELECT
    to_char(hiredate, 'yy'),
    AVG(sal)
FROM
    emp
GROUP BY
    to_char(hiredate, 'yy');
    
-- avg, max, min , sum, count
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

SELECT
    s.*,
    RANK()
    OVER(
        ORDER BY
            nvl(stu_height, 0) DESC
    ) AS rank1
FROM
    student s;

SELECT
    *
FROM
    (
        SELECT
            s.*,
            RANK()
            OVER(
                ORDER BY
                    nvl(stu_height, 0) DESC
            ) AS rank1
        FROM
            student s
    )
WHERE
    rank1 = 1;

SELECT
    stu_dept,
    MAX(stu_height)
FROM
    student
GROUP BY
    stu_dept;

--학과별 가장 키가 큰 학생의 학번, 이름, 키 출력
SELECT
    stu_no,
    stu_name,
    stu_height
FROM
    (
        SELECT
            stu_no,
            stu_name,
            stu_height,
            RANK()
            OVER(PARTITION BY stu_dept
                 ORDER BY
                     nvl(stu_height, 0) DESC
            ) rank1
        FROM
            student
    )
WHERE
    rank1 = 1;
    
--emp 테이블에서 comm이 null이면 '정보없음'으로 출력
SELECT
    e.*,
    nvl(
        to_char(e.comm),
        '정보없음'
    )
FROM
    emp e;

--decode, case when
SELECT
    s.*,
    decode(stu_gender, 'M', '남자', '여자')
FROM
    student s;

SELECT
    s.*,
    decode(stu_gender, 'M', '남자', 'F', '여자',
           '알수없음')
FROM
    student s;

SELECT
    e.*,
    CASE
        WHEN enr_grade >= 80 THEN
            'A'
        WHEN enr_grade >= 60 THEN
            'B'
        ELSE
            'C'
    END AS 등급
FROM
    enrol e;