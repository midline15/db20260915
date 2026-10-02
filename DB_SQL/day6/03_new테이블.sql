-- 1. 각 부서별 평균 금여를 구한 후 평균 급여를 기준으로 내림차순 하시오. 
-- 사용테이블 : TBL_EMP, TBL_DEPT
-- 출력 컬럼 : 부서 이름, 평균 급여
select 
    dept_name,
    avg(salary)
from tbl_emp e
join tbl_dept d on e.dept_id = d.dept_id
group by dept_name
order by avg(salary) desc;

-- 2. 모든 부서장들의 급여 평균보다 높은 급여를 받는 직원들을 출력하시오. 
-- 사용 테이블 : TBL_EMP, TBL_DEPT
-- 출력 컬럼 : 직원 이름, 급여, 부서장들의 평균 급여
select 
    emp_name,
    salary,
    avg_sal
from tbl_emp e
join (select 
avg(salary) as avg_sal
from tbl_dept d
join tbl_emp e on d.head_id = e.emp_id) t on 1=1
where salary > avg_sal;

-- 3. '모바일 앱 개발' 프로젝트에 배정된 직원들중 가장 높은 급여를 받는 직원을 출력하시오. 
-- 사용 테이블 : TBL_EMP, TBL_PROJECT, TBL_ASSIGNMENT
-- 출력 컬럼 : 직원 이름, 직급, 급여
select 
    emp_name,
    job_title,
    salary
from (select
    emp_name,
    job_title,
    salary,
    rank() over(order by e.salary desc) rank1
from tbl_emp e
join tbl_project p on p.dept_id = e.dept_id
where p.proj_name = '모바일 앱 개발')
where rank1 = 1;

-- 4. 각 직원의 부하직원의 수(자신의 emp_id를 manager_id로 가지고 있는 사람 수)를 구하시오. 단, 없으면 0으로 출력하시오. 
-- 사용 테이블 : TBL_EMP
-- 출력 컬럼 : 직원 이름, 직급, 부하직원 수
select 
    e1.emp_name,
    e1.job_title,
    count(e2.emp_id)
from tbl_emp e1
left join tbl_emp e2 on e1.emp_id = e2.manager_id
group by e1.emp_name, e1.job_title;

-- 5. 각 프로젝트에 투입된 직원의 수를 출력하시오.
-- 사용 테이블 : TBL_PROJECT
-- 출력 컬럼 : 프로젝트 이름, 투입된 인원 수
select 
    p.proj_name,
    count(e.emp_id)
from tbl_project p
join tbl_emp e on p.dept_id = e.dept_id
group by p.proj_name;