-- 사용자 아이디, 이름, 잔여포인트 출력
SELECT
    u.userid,
    name,
    balance
FROM
         tbl_user u
    INNER JOIN (
        SELECT
            userid,
            balance,
            RANK()
            OVER(PARTITION BY userid
                 ORDER BY
                     cdatetime DESC
            ) AS rank1
        FROM
            tbl_point
    ) t ON u.userid = t.userid
WHERE
    rank1 = 1;
    
--오지훈의 현재남은 포인트를 출력하세요
SELECT
    u.userid,
    name,
    balance
FROM
         tbl_user u
    INNER JOIN (
        SELECT
            userid,
            balance,
            RANK()
            OVER(PARTITION BY userid
                 ORDER BY
                     cdatetime DESC
            ) AS rank1
        FROM
            tbl_point
    ) t ON u.userid = t.userid
WHERE
        rank1 = 1
    AND name LIKE '오지훈';

SELECT
    userid,
    name,
    balance
FROM
    (
        SELECT
            u.userid,
            name,
            balance
        FROM
                 tbl_user u
            INNER JOIN tbl_point p ON u.userid = p.userid
        WHERE
            name = '오지훈'
        ORDER BY
            p.cdatetime DESC
    )
WHERE
    ROWNUM = 1;

--'SUMMERBOX67' 아이디를 가진 사람의 포인트 변동 내역을 출력
-- 최신순으로 출력
-- 아이디, 이름, 잔여포인트, 내용
SELECT
    p.userid,
    name,
    balance,
    description,
    p.cdatetime
FROM
         tbl_point p
    INNER JOIN tbl_user u ON p.userid = u.userid
WHERE
    p.userid = 'summerbox67'
ORDER BY
    p.cdatetime DESC;

SELECT
    u.*,
    cnt
FROM
         tbl_user u
    JOIN (
        SELECT
            userid,
            COUNT(*) AS cnt
        FROM
            tbl_point
        GROUP BY
            userid
    ) t ON u.userid = t.userid;