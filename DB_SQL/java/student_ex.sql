select * 
from student;

insert into student
values ('1234', '홍길동', 99,99,99);

commit;

select (java+oracle+html)/3
from student;
--select avr(java) from student; 해당 컬럼의 평균

select stu_name as zzz  --jdbc에서 zzz로 별칭
from student;

-- select *, (java+oracle+html)/3 from student 오류 >> 테이블에 별칭주기
select 
    s.*, 
    (java+oracle+html)/3 as 평균, 
    round((java+oracle+html)/3, 2) as 반올림
from student s; -- as생략 

select stu_no, stu_name, 
round((java+oracle+html)/3, 2) as 평균 from student order by 평균 desc;

delete from student where stu_no = 1234;

update student set java = 100 where stu_no = 1234;
