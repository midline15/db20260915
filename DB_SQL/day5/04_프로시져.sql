--프로시저

CREATE OR REPLACE PROCEDURE temp_proc IS
BEGIN
    dbms_output.put_line('Hello Oracle');
END;
/

set serveroutput on;

exec temp_proc;

--인자 값으로 보낸 사번을 가진 사원의 이름, 직급, 급여 정보 출력
exec empinfo_proc(7902);

CREATE OR REPLACE PROCEDURE empinfo_proc (
    i_empno emp.empno%TYPE
) IS

    o_ename emp.ename%TYPE;
    o_job   emp.job%TYPE;
    o_sal   emp.sal%TYPE;
BEGIN
    SELECT
        ename,
        job,
        sal
    INTO
        o_ename,
        o_job,
        o_sal
    FROM
        emp
    WHERE
        empno = i_empno;

    dbms_output.put_line(o_ename
                         || '님의 직급은 '
                         || o_job
                         || ', 급여는 '
                         || o_sal);

END;
/


-- emp_addsal_proc(사번, 급여)
--해당 사번을 가진 사원의 급여를 두번째 인자 값으로 변경
CREATE OR REPLACE PROCEDURE emp_addsal_proc (
    i_empno emp.empno%TYPE,
    i_sal   emp.sal%TYPE
) IS
    o_count NUMBER;
BEGIN
    UPDATE emp
    SET
        sal = i_sal
    WHERE
        empno = i_empno;

    o_count := SQL%rowcount;
    IF o_count = 0 THEN
        dbms_output.put_line('사번을 확인해주세요');
    ELSIF o_count = 1 THEN
        dbms_output.put_line('수정되었습니다.');
    ELSE
        dbms_output.put_line('2건 이상 수정되었습니다.');
    END IF;

    COMMIT;
    --커밋가능
END;
/

exec emp_addsal_proc(7566, 4000);


-----------------------------------------------------------------------------

-- 프로시저 호출
-- ENROL_PROC('학번', '과목번호', '수정할 점수')
-- 1. 없는 학번이나 없는 과목번호를 입력하면 '정보를 다시 확인해주세요' 출력
-- 2. 점수가 0미만, 100초과일 경우 '점수의 범위는 1~100 입니다' 출력
-- 3. 학번, 과목번호에 해당하는 점수는 3번째 인자값으로 변경
CREATE OR REPLACE PROCEDURE enrol_proc (
    i_stu_no    enrol.stu_no%TYPE,
    i_sub_no    enrol.sub_no%TYPE,
    i_enr_grade enrol.enr_grade%TYPE
) IS
    o_count NUMBER;
BEGIN
    IF i_enr_grade NOT BETWEEN 0 AND 100 THEN
        dbms_output.put_line('점수의 범위는 0~100 입니다');
        RETURN;
    END IF;

    UPDATE enrol
    SET
        enr_grade = i_enr_grade
    WHERE
            stu_no = i_stu_no
        AND sub_no = i_sub_no;

    o_count := SQL%rowcount;
    IF o_count = 0 THEN
        dbms_output.put_line('정보를 다시 확인해주세요');
    ELSIF o_count = 1 THEN
        dbms_output.put_line('수정되었습니다.');
    ELSE
        dbms_output.put_line('2건 이상 수정되었습니다.');
    END IF;
   -- commit;
END;
/

exec enrol_proc(20131001,101,80);


-- STUDENT 테이블에 학번, 이름, 학과를 입력받아서 저장하는 프로시저
-- 학번은 8글자 아니면 에러 문구 출력
-- 프로시저 이름 : STUINSERT_PROC 
CREATE OR REPLACE PROCEDURE stuinsert_proc (
    i_stu_no   student.stu_no%TYPE,
    i_stu_name student.stu_name%TYPE,
    i_stu_dept student.stu_dept%TYPE
) IS
BEGIN
    IF length(i_stu_no) = 8 THEN
        INSERT INTO student (
            stu_no,
            stu_name,
            stu_dept
        ) VALUES ( i_stu_no,
                   i_stu_name,
                   i_stu_dept );

        IF SQL%rowcount = 0 THEN
            dbms_output.put_line('입력 실패');
        ELSE
            dbms_output.put_line('입력 성공');
            COMMIT;
        END IF;

    ELSE
        --dbms_output.put_line('오류');
        raise_application_error(-20001,'학번은 8글자!!');
    END IF;
END;
/

exec stuinsert_proc(1234,'asdf', 'asdf');