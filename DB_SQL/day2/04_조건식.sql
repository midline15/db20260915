--조건 함수
select *
from professor
where pay+bonus >= 300; -- null값을 더하면 결과도 null

--nvl nvl2
-- nvl(컬럼명, 대체값)
select
    name,
    pay,
    nvl(bonus,0),
    pay+nvl(bonus,0)
from professor;

select *
from professor
where pay+nvl(bonus, 0) >= 300;

--nvl2(컬럼명,값1, 값2)
select 
    name, bonus, nvl2(bonus, '있다', '없다')
from professor;

--decode
select
    stu_name,
    decode(stu_gender,'M','남자'), -- if
    decode(stu_gender,'M','남자','여자') -- if else
from student;

select
    stu_name,
    decode(stu_grade,1,'저학년',2,stu_grade||'학년','고학년') -- else if
from student;

--학생 이름, 성별 출력
-- 성별을 구하는 방법은 jumin의 7번째 숫자
select
    name,
    decode(substr(jumin,7,1),1 ,'남자','여자') as 성별
from stu;

--case when then else end
select
    CASE 
        when enr_grade >= 80 then '통과'
        when enr_grade >= 70 then '보류'
        else '재시험'
    end as 시험결과
from enrol;

----------------------------------------------------------------------

-- pay+bonus가 500 이상이면 '높다'
-- 300이상 500미만이면 '중간'
-- 그외에는 '낮다'
select
    name,
    case
        when pay+nvl(bonus,0) >= 500 then '높다'
        when pay+nvl(bonus,0) >= 300 then '중간'
        else '낮다'
    end as "급여"
from professor;