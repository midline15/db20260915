--pl/sql(사용자정의함수, 트리거, 프로시저)

--선언부(선택), 실행부, 예외처리(선택)
--마지막을 '/'로 마무리

DROP FUNCTION mult;

CREATE OR REPLACE FUNCTION multi (
    i_value IN NUMBER
) RETURN NUMBER IS
BEGIN
    RETURN i_value * 2;
END;
/

SELECT
    ename,
    sal,
    multi(sal)
FROM
    emp;

CREATE OR REPLACE FUNCTION date_func (
    i_date DATE
) RETURN VARCHAR2 IS
BEGIN
    RETURN to_char(i_date, 'yyyy-mm-dd hh24:mi:ss');
END;
/

SELECT
    p.*,
    date_func(cdatetime)
FROM
    tbl_point p;

--date_func2
-- date_func2(cdatetime, 'date') -> 'yyyy.mm.dd'
-- date_func2(cdatetime, 'time') -> 'hh24:mi:ss'
-- date_func2(cdatetime, 'datetime') -> 'yyyy-mm-dd hh24:mi:ss'

CREATE OR REPLACE FUNCTION date_func2 (
    i_date DATE,
    i_type VARCHAR2
) RETURN VARCHAR2 IS
    o_date VARCHAR2(100);
BEGIN
    IF i_type = 'datetime' THEN
        o_date := to_char(i_date, 'yyyy-mm-dd hh24:mi:ss');
    ELSIF i_type = 'date' THEN
        o_date := to_char(i_date, 'yyyy-mm-dd');
    ELSIF i_type = 'time' THEN
        o_date := to_char(i_date, 'hh24:mi:ss');
    ELSE
        o_date := '값오류';
    END IF;

    RETURN o_date;
END;
/

SELECT
    date_func2(cdatetime, 'datetime') AS datetime1,
    date_func2(cdatetime, 'date')     AS date1,
    date_func2(cdatetime, 'time')     AS time1,
    date_func2(cdatetime, 'asdf')     AS wf1
FROM
    tbl_point;

--

SELECT
    gender_check('1234563123456')      
--7번째가 1이거나 3이면 '남자' 2거나4면'여자'
--글자수가 13글자가 아니거나 1~4가 아니면 '알수없음' 리턴
FROM
    dual;

CREATE OR REPLACE FUNCTION gender_check (
    i_jumin CHAR
) RETURN VARCHAR2 IS
    o_gender VARCHAR2(20);
BEGIN
    IF length(i_jumin) != 13 THEN
        o_gender := '알수없음';
    ELSIF substr(i_jumin, 7, 1) = 1
    OR substr(i_jumin, 7, 1) = 3 THEN
        o_gender := '남자';
    ELSIF substr(i_jumin, 7, 1) = 2
    OR substr(i_jumin, 7, 1) = 4 THEN
        o_gender := '여자';
    ELSE
        o_gender := '알수없음';
    END IF;

    RETURN o_gender;
END;
/

SELECT
    s.stu_no,
    stu_name,
    stu_dept,
    enr_grade,
    score_grade(enr_grade)
    --90 a 80 b 70 c 60 d 나머지 f
    --음수나 100초과 없다고 가정
FROM
         student s
    JOIN enrol e ON s.stu_no = e.stu_no;

CREATE OR REPLACE FUNCTION score_grade (
    i_val NUMBER
) RETURN VARCHAR2 IS
BEGIN
    IF i_val NOT BETWEEN 0 AND 100 THEN
        RETURN 'X';
    ELSIF i_val >= 90 THEN
        RETURN 'A';
    ELSIF i_val >= 80 THEN
        RETURN 'B';
    ELSIF i_val >= 70 THEN
        RETURN 'C';
    ELSIF i_val >= 60 THEN
        RETURN 'D';
    ELSE
        RETURN 'F';
    END IF;
END;
/

SELECT
    score_grade(90)
FROM
    dual;