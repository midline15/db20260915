--날짜 함수

--sysdate 현재시간
select
    sysdate 
from dual;

--to_char   시간을 문자포맷으로
--to_date   문자를 시간포맷으로
select
    to_char(sysdate, 'pm HH:Mi:ss yyyy-mm-dd'),
    to_char(sysdate, 'HH24:Mi:ss yyyy-mm-dd'),
    to_char(sysdate, 'yy'),
    to_date('2026-09-28','yyyy-mm-dd')
from dual;

---------------------------------------------------

select 
    p.*,
    to_char(hiredate, 'yy-mm-dd') as 입사일
from professor p
where to_char(hiredate, 'yy') = '85';

