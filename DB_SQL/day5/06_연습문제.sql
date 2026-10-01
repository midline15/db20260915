--1. 조건을 이용한 SELECT 조회 
-- STUDENT 테이블에서 컴퓨터정보 학과(STU_DEPT) 학생들을 모두 출력하시오.
-- 난이도 : 하
select *
from student
where stu_dept like '컴퓨터정보';

--2. DML 명령어
--     2-1) EMP 테이블에 INSERT 구문을 이용하여 레코드 추가
--		(필수 컬럼 : EMPNO, ENAME, MGR, SAL) 
--          - 데이터는 임의의 값을 넣으면 되나, MGR의 경우 EMPNO와 MGR의 관계를 고려하여 값을 넣을 것.
insert into emp(empno, ename, mgr, sal)
values(9999,'hong',7839,8000);
--	 2-2) 2-1에서 만든 데이터의 SAL을 2000으로 변경
update emp set
sal = 2000
where empno = 9999;
--	 2-3) 2-1에서 만든 데이터를 EMPNO를 조건으로 삭제
-- 난이도 : 하
delete from emp
where empno = 9999;
	 
-- 3. 미공개

-- 4. 그룹 함수 (STUDENT)
-- STUDENT테이블에서 컴퓨터정보 학과(STU_DEPT) 학생들의 수를 구하시오.
-- 난이도 : 하
select 
    count(*)
from student
where stu_dept = '컴퓨터정보'
group by stu_dept;

-- 5. 조인 - 2문제
-- 5-1) 컴퓨터정보 학과에 속한 교수의 수업을 듣는 학생들의 목록을 출력하시오. (STUDENT, ENROL, SUBJECT)
select distinct
 s.stu_no, s.stu_name
from student s
join enrol e on s.stu_no = e.stu_no
join subject sub on e.sub_no = sub.sub_no
where sub.sub_dept = '컴퓨터정보';
-- 5-2) EMP 테이블에 속한 사람들의 사번(EMPNO), 이름(ENAME), 급여등급을 출력하시오. (EMP, SALGRADE)
-- 난이도 : 중
select 
    empno,
    ename,
    grade
from emp e
join salgrade s on sal  between losal and hisal;

-- 6. 셀프조인 
-- 부하직원(본인을 MGR로 가지고 있는 사원)이 가장 많은 사원의 사번, 이름, 부하직원 수를 출력하시오.
-- (EMP)
-- 난이도 : 중
select 
    max(count(*))
from emp e1
join emp e2 on e1.mgr = e2.empno
group by e2.empno;

-- 7. 2개의 수업을 들은 학생들의 평균점수와 1개의 수업을 들은 학생들의 평균점수를 구하시오.
-- (수업 개수, 평균 점수 출력)
-- (STUDENT, ENROL)
-- 난이도 : 중
select 
    cnt,
    avg(e.enr_grade)
from student s
join enrol e on s.stu_no = e.stu_no
join (
select 
    s.stu_no,
    count(*) as cnt
from student s
join enrol e on s.stu_no = e.stu_no
group by s.stu_no
) t on s.stu_no = t.stu_no
group by cnt;

-- 8. 본인 학과에서 본인보다 몸무게가 큰 학생의 수를 출력하시오. ( 학번, 이름, 학과, 큰 학생 수 출력 )
-- (STUDENT)
-- 난이도 : 중
select 
s1.stu_no,
s1.stu_name,
s1.stu_dept,
count(s2.stu_no)
from student s1
join student s2 on s2.stu_weight > s1.stu_weight
group by s1.stu_no,s1.stu_name, s1.stu_dept;