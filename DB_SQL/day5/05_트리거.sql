--트리거
-- 특정 테이블에 변화가 생겼을 때(delete, insert, update) 실행

CREATE OR REPLACE TRIGGER temp_trigger BEFORE 
    -- before or after
    INSERT OR UPDATE ON student
    -- insert or update or delete
    FOR EACH ROW
    --업데이트로 세명의 정보가 변경되면 세번 실행
BEGIN
    dbms_output.put_line('변경 전 : ' || :old.stu_height);
    dbms_output.put_line('변경 후 : ' || :new.stu_height);
END;
/

UPDATE student
SET
    stu_height = stu_height + 1
WHERE
    stu_name LIKE '옥한빛';

CREATE TABLE emp_log (
    l_empno NUMBER,
    o_sal   NUMBER,
    n_sal   NUMBER,
    o_comm  NUMBER,
    n_comm  NUMBER,
    l_id    VARCHAR2(50),
    event   VARCHAR2(50),
    l_time  DATE
);

CREATE OR REPLACE TRIGGER emp_trigger BEFORE
    INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW
BEGIN
    --IF :new.comm IS NULL
      -- OR :new.comm < 0 THEN
       -- :new.comm := 0;
   -- END IF;

    IF inserting THEN
        INSERT INTO emp_log VALUES ( :new.empno,
                                     :new.sal,
                                     :new.sal,
                                     :new.comm,
                                     :new.comm,
                                     sys_context('userenv', 'session_user'),
                                     'I',
                                     sysdate );

    ELSIF updating THEN
        INSERT INTO emp_log VALUES ( :new.empno,
                                     :old.sal,
                                     :new.sal,
                                     :old.comm,
                                     :new.comm,
                                     sys_context('userenv', 'session_user'),
                                     'U',
                                     sysdate );

    ELSIF deleting THEN
        raise_application_error(-20002, '사원 데이터는 삭제 불가!');
    END IF;
END;
/

UPDATE emp
SET
    sal = sal + 50
WHERE
    empno = 7499;

INSERT INTO emp VALUES ( 1234,
                         'hong',
                         'salesman',
                         7698,
                         sysdate,
                         2000,
                         200,
                         20 );

DELETE FROM emp
WHERE
    empno = 1234;

SELECT
    *
FROM
    emp_log;
    
---------------------------------------------------------------------
--ENROL 테이블 트리거 만들기

--조건 1. 테이블명은 ENROL_LOG
--       컬럼은 과목번호, 학생번호, 수정전시험점수, 수정후시험점수, 작업자ID, 작업종류, 작업날짜
--조건 2. INSERT할 경우 ENROL_LOG에 해당 내용 자동 저장
--       단, 시험점수가 0~100사이가 아니면 0으로 저장
--조건 3. UPDATE할 경우 ENROL_LOG에 해당 내용 자동 저장
--       단, 시험점수가 0~100사이가 아니면 에러를 띄운 후 종료
--조건 4. DELETE할 경우 에러를 띄운 후 종료
CREATE TABLE enrol_log (
    l_subno    VARCHAR(20),
    l_stuno    VARCHAR(20),
    o_enrgrade NUMBER,
    n_enrgrade NUMBER,
    l_id       VARCHAR2(50),
    event      VARCHAR2(50),
    l_time     DATE
);

CREATE OR REPLACE TRIGGER enrol_trigger BEFORE
    INSERT OR UPDATE OR DELETE ON enrol
    FOR EACH ROW
BEGIN
    IF
        inserting
        AND :new.enr_grade BETWEEN 0 AND 100
    THEN
        IF :new.enr_grade NOT BETWEEN 0 AND 100 THEN
            :new.enr_grade := 0;
        END IF;

        INSERT INTO enrol_log VALUES ( :new.sub_no,
                                       :new.stu_no,
                                       :new.enr_grade,
                                       :new.enr_grade,
                                       sys_context('userenv', 'session_user'),
                                       'I',
                                       sysdate );

    ELSIF updating THEN
        IF :new.enr_grade NOT BETWEEN 0 AND 100 THEN
            raise_application_error(-20004, '0에서 100사이 값 넣기');
        END IF;

        INSERT INTO enrol_log VALUES ( :new.sub_no,
                                       :new.stu_no,
                                       :old.enr_grade,
                                       :new.enr_grade,
                                       sys_context('userenv', 'session_user'),
                                       'U',
                                       sysdate );

    ELSIF deleting THEN
        raise_application_error(-20003, '삭제 금지');
    END IF;
END;
/

INSERT INTO enrol VALUES ( 105,
                           20131001,
                           101 );

SELECT
    *
FROM
    enrol_log;

UPDATE enrol
SET
    enr_grade = 65
WHERE
        sub_no = 103
    AND stu_no = 20152088;

DELETE FROM enrol
WHERE
        sub_no = 105
    AND stu_no = 20131001;

ROLLBACK;