-- 1. (EMP) 81년도에 입사한 사람의 숫자를 출력하세요.
select 
    count(*)
from emp
where to_char(hiredate,'yy') = 81;

-- 2. (EMP) SAL+COMM의 값이 2500 이상인 사람의 숫자를 출력하세요.
select
    ename,
    sal+nvl(comm,0)
from emp
where sal+nvl(comm,0) >= 2500;

-- 3. (EMP) 직급(JOB)별 가장 높은 급여를 출력하세요. (직급, 가장 높은급여 출력)
select
    job,
    max(sal)
from emp
group by job;

-- 4. (EMP) 부서(DEPTNO)별 평균급여를 구하세요. 단, 출력은 평균급여가 1800이상인 부서명, 평균급여를 출력하세요.
select
 deptno,
 round(avg(sal))
from emp
group by deptno
having avg(sal) >= 1800;

-- 5. (EMP) 입사년도별 사원수를 출력하세요. (결과화면 하단 이미지 참고)
select
    to_char(hiredate,'yy') as 입사년도,
    count(*) as 사원수
from emp
group by to_char(hiredate,'yy')
order by 입사년도;

-- 6. (STU) 태어난 월(JUMIN 컬럼 3,4번째 숫자)별 학생 수를 구하시오. (결과화면 하단 이미지 참고)
select
    substr(jumin,3,2)||'월' as 월,
    count(*) as 학생수
from stu
group by substr(jumin,3,2)
order by 월;

-- 7. (STU) 각 성별별로 학생 수를 아래 이미지와 같이 구하시오.(하단 이미지 참고) 
select
    sum(decode(substr(jumin,7,1),1,1,0)) as 남학생수,
    sum(decode(substr(jumin,7,1),2,1,0)) as 여학생수,
    
    count(decode(substr(jumin,7,1),1,1))as 남학생수,
    count(decode(substr(jumin,7,1),2,1)) as 여학생수
from stu;