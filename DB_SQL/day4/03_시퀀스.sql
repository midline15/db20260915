-- 시퀀스

-- ex) 게시판 -> 제목, 내용, 작성자, 작성일, 조회수 등이 필요

CREATE TABLE board (
    boardno   NUMBER PRIMARY KEY,
    title     VARCHAR2(100),
    contents  VARCHAR2(300),
    userid    VARCHAR2(100),
    cnt       NUMBER,
    cdatetime DATE,
    udatetime DATE
);

CREATE SEQUENCE test_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE; -- cycle 처음부터 다시 시작

SELECT
    test_seq.NEXTVAL
FROM
    dual;

CREATE SEQUENCE board_seq INCREMENT BY 1 START WITH 1;

INSERT INTO board VALUES ( board_seq.NEXTVAL,
                           '두번째',
                           '내용',
                           '아이',
                           0,
                           sysdate,
                           sysdate );

COMMIT;

SELECT
    *
FROM
    board;

CREATE TABLE board_comment (
    commentno NUMBER PRIMARY KEY,
    boardno   NUMBER,
    FOREIGN KEY ( boardno )
        REFERENCES board ( boardno ),
    contents  VARCHAR2(300),
    userid    VARCHAR2(100),
    cdatetime DATE,
    udatetime DATE
);

CREATE SEQUENCE comment_seq INCREMENT BY 1 START WITH 1;

INSERT INTO board_comment VALUES ( comment_seq.NEXTVAL,
                                   1,
                                   'ㅇㅈ',
                                   '아이',
                                   sysdate,
                                   sysdate );

SELECT
    *
FROM
    board_comment;

--각 게시글 별 댓글수 구하기 없으면0
SELECT
    b.boardno,
    b.title,
    b.contents,
    b.userid,
    b.cdatetime,
    b.udatetime,
    COUNT(commentno)
FROM
    board         b
    LEFT JOIN board_comment c ON b.boardno = c.boardno
GROUP BY
    b.boardno,
    b.title,
    b.contents,
    b.userid,
    b.cdatetime,
    b.udatetime;

SELECT
    b.*,
    nvl(c_cnt, 0)
FROM
    board b
    LEFT JOIN (
        SELECT
            boardno,
            COUNT(*) AS c_cnt
        FROM
            board_comment
        GROUP BY
            boardno
    )     c ON b.boardno = c.boardno;

SELECT
    s.*,
    e.enr_grade,
    av,
    sub.sub_name
FROM
         student s
    INNER JOIN enrol   e ON s.stu_no = e.stu_no
    LEFT JOIN (
        SELECT
            sub_no,
            AVG(enr_grade) AS av
        FROM
            enrol
        GROUP BY
            sub_no
    )       t ON e.sub_no = t.sub_no
    LEFT JOIN subject sub ON e.sub_no = sub.sub_no