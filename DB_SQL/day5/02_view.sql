--view
DROP VIEW emp_view;

CREATE OR REPLACE VIEW emp_view AS
    SELECT
        empno,
        ename,
        job,
        dname,
        loc
    FROM
             emp e
        INNER JOIN dept d ON e.deptno = d.deptno
WITH READ ONLY; --읽기 전용

SELECT
    *
FROM
    emp_view;

--view에서 수정이 가능한 경우
--1. 읽기 전용 옵션 없을 때 (with read only)
--2. join이 없을 떄
--3. group 함수 없을 때
--4. distinct 없을 때

SELECT DISTINCT
    stu_no,
    enr_grade
FROM
    enrol;
    
--학번, 이름, 학과, 시험평균 점수를 출력하는 view 생성. 읽기 전용
--score_view
CREATE OR REPLACE VIEW score_view AS
    SELECT
        s.stu_no,
        stu_name,
        stu_dept,
        avg_score
    FROM
             student s
        JOIN (
            SELECT
                stu_no,
                AVG(enr_grade) AS avg_score
            FROM
                enrol
            GROUP BY
                stu_no
        ) t ON s.stu_no = t.stu_no
WITH READ ONLY;

SELECT
    *
FROM
    score_view;