--CONCAT, || 합치기
SELECT
    concat(stu_no, stu_name)
FROM
    student;

SELECT
    concat(
        concat(stu_no, '_'),
        stu_name
    )
FROM
    student;

SELECT
    stu_no
    || ' '
    || stu_name AS zz
FROM
    student;

--LENGTH 길이
SELECT
    id,
    length(id)
FROM
    professor;
    
--SUBSTR 자르기
SELECT
    name,
    substr(jumin, 1, 6), --생년월일
    substr(jumin, 3, 2),  --월
    substr(jumin, 7),    --뒷자리
    decode(
        substr(jumin, 7, 1),
        1,
        '남자',
        '여자'
    )-- 참고 DECODE(컬럼값,1,참,거짓)
FROM
    stu;

--UPPER, LOWER 대소문자
SELECT
    upper('Hello Oracle'),
    lower('Hello Oracle')
FROM
    dual;
    
--INSTR 문자열 처음위치 (표준SQL POSITION())
SELECT
    email,
    instr(email, '@'),
    substr(email,
           instr(email, '@') + 1)
FROM
    professor;
    
--TRIM, LTRIM, RTRIM 끝공백제거
SELECT
    TRIM('  Hello Oracle   '),
    ltrim('  Hello Oracle   '),
    rtrim('  Hello Oracle   ')
FROM
    dual;

--LPAD, RPAD 지정한 길이 만큼 특정 문자 채우기
SELECT
    rpad(id, 10, '*'),
    lpad(id, 10, '*')
FROM
    professor;

--아이디에 첫 3글자만 출력하고 나머지는 공간은 *로 채우기
SELECT
    rpad(
        substr(id, 1, 3),
        length(id),
        '*'
    ),
    rpad(
        substr(id,
               1,
               length(id) - 3),
        length(id),
        '*'
    )
    --SUBSTR(ID,1,LENGTH(ID)-3)||'***' 
    --CONCAT(SUBSTR(ID,1,LENGTH(ID)-3),'***')
FROM
    professor;
    
--이메일에서 아이디 뒷부분을 다 * 출력
SELECT
    rpad(
        substr(email,
               1,
               instr(email, '@') - 1),
        length(email),
        '*'
    )
FROM
    professor;
    
--첫글자와 마지막글자 빼고 다 별표
SELECT
    rpad(
        substr(id, 1, 1),
        length(id) - 1,
        '*'
    )
    || substr(id,
              length(id))
FROM
    professor;

--REPLACE 문자열을 다른 문자열로 대체
SELECT
    email,
    replace(email, 'net', 'com')
FROM
    professor;