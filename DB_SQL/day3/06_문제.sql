-- STUDENT, ENROL, SUBJECT 
-- 1. 성이 '김'씨인 학생들의 학번, 이름, 학과를 출력하시오.
SELECT
    stu_no,
    stu_name,
    stu_dept
FROM
    student
WHERE
    stu_name LIKE '김%';

-- 2. 15학번 학생들의 학번, 이름, 학과를 출력하시오.(학번 3,4번째 숫자 15)
SELECT
    stu_no,
    stu_name,
    stu_dept
FROM
    student
WHERE
    stu_no LIKE '2015%';

-- 3. 컴퓨터정보 학과 학생들의 시험 평균 점수를 구하시오.
SELECT
    stu_dept,
    AVG(enr_grade)
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    stu_dept
HAVING
    stu_dept = '컴퓨터정보';

-- 4. 컴퓨터개론 수업을 듣는 학생의 학번, 이름, 학과, 시험점수를 구하시오.
SELECT
    s.stu_no,
    stu_name,
    stu_dept,
    enr_grade
FROM
         enrol e
    INNER JOIN student s ON s.stu_no = e.stu_no
    INNER JOIN subject sub ON sub.sub_no = e.sub_no
WHERE
    sub_name = '컴퓨터개론';

-- 5. 학생들의 전체 평균 키보다 큰 키를 가진 학생들의 학번, 이름, 키를 출력하시오.
SELECT
    stu_no,
    stu_name,
    stu_height
FROM
    student
WHERE
    stu_height > (
        SELECT
            AVG(stu_height)
        FROM
            student
    );

-- 6. 본인 학과의 평균 키보다 큰 학생들의 이름, 학과, 키, 학과 평균키 값 출력
SELECT
    stu_no,
    stu_name,
    stu_height
FROM
         student s
    INNER JOIN (
        SELECT
            stu_dept,
            AVG(stu_height) AS ah
        FROM
            student
        GROUP BY
            stu_dept
    ) t ON s.stu_dept = t.stu_dept
WHERE
    stu_height > ah;

-- 7. 컴퓨터정보과의 평균보다 평균이 낮은 학과의 학과명, 점수 출력
SELECT
    stu_dept,
    AVG(enr_grade)
FROM
         student s
    INNER JOIN enrol e ON s.stu_no = e.stu_no
GROUP BY
    stu_dept
HAVING
    AVG(enr_grade) < (
        SELECT
            AVG(enr_grade)
        FROM
                 student s
            INNER JOIN enrol e ON s.stu_no = e.stu_no
        GROUP BY
            stu_dept
        HAVING
            stu_dept = '컴퓨터정보'
    );

-- EMP, SALGRADE, DEPT
-- 1. 사번, 이름, 팀장(MGR)의 이름을 출력하시오.
SELECT
    e1.empno,
    e1.ename,
    e2.ename
FROM
         emp e1
    INNER JOIN emp e2 ON e1.mgr = e2.empno;

-- 2. 부서별 가장 높은 급여를 받는 사원의 사번, 이름, 급여, 부서명을 출력하시오.
SELECT
    empno,
    ename,
    sal,
    dname
FROM
         emp e
    INNER JOIN dept d ON e.deptno = d.deptno
    INNER JOIN (
        SELECT
            deptno,
            MAX(sal) AS max_sal
        FROM
            emp
        GROUP BY
            deptno
    )    t ON e.deptno = t.deptno
WHERE
    e.sal = max_sal;

-- 3. 입사년도가 1981년도인 사원들의 급여 총합을 구하시오.
SELECT
    SUM(sal)
FROM
    emp
WHERE
    to_char(hiredate, 'yy') = 81;
-- 4. 직급별 급여의 합이 가장 큰 직급의 직급명, 급여의 합을 출력하시오.
SELECT
    job,
    SUM(sal)
FROM
    emp e
GROUP BY
    job
HAVING
    SUM(sal) = (
        SELECT
            MAX(SUM(sal))
        FROM
            emp e
        GROUP BY
            job
    );

-- 5. ALLEN과 같은 JOB, DEPTNO(부서)를 가진 사람을 구하시오.(ENAME, DNAME 출력)
SELECT
    e.ename,
    d.dname
FROM
         emp e
    INNER JOIN dept d ON e.deptno = d.deptno
WHERE
    ( job,
      e.deptno ) = (
        SELECT
            job,
            deptno
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    ) and ename != 'ALLEN';

-- STU, PROFESSOR, DEPARTMENT
-- 1. 남자이면서(주민번호 7번째자리 1) 공과대학에 속한 학생의 수를 구하시오.
SELECT
    COUNT(*)
FROM
         stu s
    INNER JOIN department d1 ON s.deptno1 = d1.deptno
    INNER JOIN department d2 ON d1.part = d2.deptno
    INNER JOIN department d3 ON d2.part = d3.deptno
WHERE
    substr(jumin, 7, 1) = 1
GROUP BY
    d3.deptno
HAVING
    d3.deptno = 10;

-- 2. 보너스+급여가 400 이하인 교수들의 이름, 아이디, 학과명을 출력하시오.
SELECT
    name,
    id,
    dname
FROM
         professor p
    INNER JOIN department d ON p.deptno = d.deptno
WHERE
    pay + nvl(bonus, 0) <= 400;

-- 3. 담당 학생이 2명이상인 교수의 이름, 아이디, 담당학생 수를 출력하시오.
SELECT
    p.name,
    p.id,
    COUNT(s.stuno)
FROM
         professor p
    INNER JOIN stu s ON p.profno = s.profno
GROUP BY
    p.profno,
    p.name,
    p.id
HAVING
    COUNT(s.stuno) >= 2;

-- 4. 가장 많은 학생이 있는 학과와 가장 적은 학생이 있는 학과의 학과명, 학생수를 출력하시오.\
SELECT
    dname,
    COUNT(*)
FROM
         stu s
    INNER JOIN department d ON s.deptno1 = d.deptno
GROUP BY
    dname
HAVING
    COUNT(*) IN (
        SELECT
            MAX(COUNT(*))
        FROM
            stu
        GROUP BY
            deptno1
        UNION
        SELECT
            MIN(COUNT(*))
        FROM
            stu
        GROUP BY
            deptno1
    );
    
SELECT
    dname,
    COUNT(*)
FROM
         stu s
    INNER JOIN department d ON s.deptno1 = d.deptno
    inner join (
        select 
            max(count(*)) max_s,
            min(count(*)) min_s
        from stu
        group by deptno1
    ) t on 1=1
GROUP BY
    dname, max_s, min_s
having count(*) in (max_s, min_s);
    
--본인보다 높은 학년인 사람의 학생 수 구하고, 아래 이미지와 같이 결과를 도출하시오.(사용 테이블 : STU)
SELECT
    COUNT(s2.stuno),
    s.stuno,
    s.name,
    s.grade
FROM
    stu s
left join stu s2 on s2.grade > s.grade
group by s.stuno, s.name, s.grade
order by s.grade;
