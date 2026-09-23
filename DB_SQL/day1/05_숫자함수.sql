--ROUND 반올림
SELECT
    round(12.3456, 2)
FROM
    dual;

--CEIL 올림
SELECT
    ceil(123.0001)
FROM
    dual;

--FLOOR 내림
SELECT
    floor(123.999)
FROM
    dual;
    
--TRUNC 날림(특정위치까지 출력)
SELECT
    trunc(123.999, 2)
FROM
    dual;
    
--MOD 나머지
SELECT
    MOD(11, 4)
FROM
    dual;
    
--SIGN 부호 양수면 1, 음수면 -1, 0이면 0
SELECT
    sign(-1234)
FROM
    dual;
    
--ABS 절대값
SELECT
    abs(-1234)
FROM
    dual;
    
--POWER 제곱
SELECT
    POWER(2,10)
FROM
    dual;