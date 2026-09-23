select * 
from student;

select stu_name, stu_no, stu_dept
from student;

select stu_name as 이름, stu_no 학번, stu_dept "학과 이름"
from student;

--insert
-- 이름 홍길동 학번12345678 학과 기계

insert into student(stu_name, stu_no, stu_dept)
values('홍길동', '12345678', '기계');

rollback;

-------------------
-- 테이블 별칭
select stu_name 이름, s.*
from student s;
