-- 1. EMP 테이블에서 급여(SAL)가 3000이상인 사원의 사번, 이름, 급여를 출력하시오
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
    sal >= 3000;

-- 2. TBL_EMP 테이블에 데이터를 삽입, 수정, 삭제하시오. 
-- 조건 1. 데이터 삽입 시 들어갈 내용은 자유롭게 정의하되, manager_id 컬럼은 테이블의 연관성을 고려하여 삽입한다. (NULL 금지)
INSERT INTO tbl_emp VALUES ( 'E1008',
                             '홍길동',
                             '사원',
                             'E1007',
                             sysdate,
                             4200000,
                             'D03' );
-- 조건 2. 조건 1에서 삽입한 직원의 급여 정보를 10%로 증가한다. 
UPDATE tbl_emp
SET
    salary = salary * 1.1
WHERE
    emp_id = 'E1008';
-- 조건 3. 조건 1에서 삽입한 직원을 PK를 조건으로 삭제 한다.
DELETE FROM tbl_emp
WHERE
    emp_id = 'E1008';
	 
-- 3. 시험 점수가 80점 이상이면 'A', 70점 이상이면 'B', 60점 이상이면 'C', 그외는 '노력요망' 으로 출력하시오. 
-- 사용테이블 : ENROL
-- 출력 컬럼 : 학생번호, 평가정보
SELECT
    stu_no,
    CASE
        WHEN enr_grade >= 80 THEN
            'A'
        WHEN enr_grade >= 70 THEN
            'B'
        WHEN enr_grade >= 60 THEN
            'C'
        ELSE
            '노력요망'
    END AS 평가정보
FROM
    enrol;

-- 4. PROFESSOR테이블에서 직급(POSITION)이 '정교수'인 데이터의 수를 구하시오.
SELECT
    COUNT(*)
FROM
    professor
WHERE
    position = '정교수';

-- 5. PROFESSOR테이블에서 EMAIL컬럼 내용 중 아이디(@이전 값들)만 추출하여 출력하시오.
SELECT
    substr(email,
           1,
           instr(email, '@') - 1)
FROM
    professor;

-- 6. PROFESSOR테이블에서 월별 입사한 사람의 수를 구하시오.
-- 출력 : 월, 입사한 사람 수
SELECT
    to_char(hiredate, 'mm')
    || '월',
    COUNT(*)
FROM
    professor
GROUP BY
    to_char(hiredate, 'mm')
    || '월'
ORDER BY
    to_char(hiredate, 'mm')
    || '월';

-- 7. 조인 - 2문제 (STU, PROFESSOR, DEPARTMENT)
-- 7-1) 컴퓨터공학과에 속한 교수의 교수번호, 이름, 직급, 학과명을 출력하시오.
SELECT
    p.profno,
    p.name,
    p.position,
    d.dname
FROM
         professor p
    JOIN department d ON p.deptno = d.deptno;
-- 7-2) 학생들의 학번, 이름, 부전공명을 출력하시오. 단, 부전공이 없으면 '해당없음' 으로 출력하시오.
SELECT
    stuno,
    name,
    nvl(dname, '해당없음')
FROM
    stu        s
    LEFT JOIN department d ON s.deptno2 = d.deptno;

-- 8. 셀프조인 
-- emp 테이블에서 부하직원(본인을 MGR로 가지고 있는 사원)이 1명도 없는 사원의 사번, 이름을 출력하시오.
SELECT
    e1.empno,
    e1.ename
FROM
    emp e1
    LEFT JOIN emp e2 ON e1.empno = e2.mgr
WHERE
    e2.empno IS NULL;

-- 9. PROFESSOR테이블에서 보너스가 높은 순으로 출력하시오. 단, 보너스가 없을 경우 '없음'으로 출력하시오.
-- 출력 : 교수번호, 이름, 급여, 보너스 
-- 보너스가 없을 경우 제일 마지막에 출력
SELECT
    profno,
    name,
    pay,
    nvl(
        to_char(bonus),
        '없음'
    )
FROM
    professor
ORDER BY
    nvl(bonus, 0) DESC;

-- 10. (TBL_EMP, TBL_DEPT) 각 부서의 부서아이디, 부서이름, 지역, 부서장 이름, 부서에 속한 사원의 수를 출력하시오.
SELECT
    d.dept_id,
    d.dept_name,
    d.location,
    e1.emp_name,
    COUNT(e2.emp_id)
FROM
         tbl_dept d
    JOIN tbl_emp e1 ON d.head_id = e1.emp_id
    JOIN tbl_emp e2 ON d.dept_id = e2.dept_id
GROUP BY
    d.dept_id,
    d.dept_name,
    d.location,
    e1.emp_name;
    

-- 11. (TBL_EMP, TBL_DEPT) 본인 부서에서 본인보다 높은 급여를 받는 사원의 수를 출력하시오.
-- 출력 : 사원아이디, 이름, 부서명, 본인 부서에서 본인보다 높은 급여를 받는 사원의 수
-- 없으면 0 출력
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    COUNT(e2.emp_id)
FROM
         tbl_emp e
    JOIN tbl_dept d ON e.dept_id = d.dept_id
    LEFT JOIN tbl_emp  e2 ON e.salary < e2.salary
                            AND e2.dept_id = e.dept_id
GROUP BY
    e.emp_id,
    e.emp_name,
    d.dept_name
ORDER BY
    dept_name,
    COUNT(e2.emp_id);

-- 12. (신규 테이블 기준) 사원 아이디, 이름, 진행중인 프로젝트 명, 진행 부서명, 해당 프로젝트 투입 인원 수를 출력하시오.
-- 진행중인 프로젝트가 없으면 아이디, 이름 외에 다른 정보를 NULL로 출력하시오.
SELECT
    e.emp_id,
    e.emp_name,
    t.proj_name,
    t.dept_name,
    t.cnt
FROM
    tbl_emp e
    LEFT JOIN (
        SELECT
            p.dept_id,
            p.proj_name,
            d.dept_name,
            COUNT(*) AS cnt
        FROM
                 tbl_project p
            JOIN tbl_dept d ON p.dept_id = d.dept_id
            JOIN tbl_emp  e ON d.dept_id = e.dept_id
        GROUP BY
            p.dept_id,
            p.proj_name,
            d.dept_name
    )       t ON t.dept_id = e.dept_id;


-- 13. (신규 테이블 기준) 부서별 급여합산이 가장 높은 부서의 부서이름, 급여합산 결과를 출력하시오.
SELECT
    dept_name,
    sum_sal
FROM
    (
        SELECT
            d.dept_name,
            SUM(salary) AS sum_sal,
            RANK()
            OVER(
                ORDER BY
                    SUM(salary) DESC
            )           AS rank1
        FROM
                 tbl_dept d
            JOIN tbl_emp e ON d.dept_id = e.dept_id
        GROUP BY
            d.dept_id,
            d.dept_name
    )
WHERE
    rank1 = 1;

-- 14. (SAL, SALGRADE) 급여등급이 3이상인 사람의 수와 3미만인 사람의 수를 구하시오.
(출력결과는 아래 이미지와 동일해야 함)
SELECT
    카테고리,
    COUNT(*) AS 인원수
FROM
    (
        SELECT
            empno,
            CASE
                WHEN grade >= 3 THEN
                    '3등급이상'
                ELSE
                    '3등급미만'
            END AS 카테고리
        FROM
                 emp e
            JOIN salgrade s ON e.sal BETWEEN losal AND hisal
    )
GROUP BY
    카테고리
ORDER BY
    카테고리 DESC;