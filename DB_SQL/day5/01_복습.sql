--student테이블에서 키가큰 상위 5명 출력 rownum사용
SELECT
    *
FROM
    (
        SELECT
            s.*
        FROM
            student s
        WHERE
            stu_height IS NOT NULL
        ORDER BY
            stu_height DESC
    )
WHERE
    ROWNUM <= 5;

--student테이블에서 키가큰 상위 5명 출력 rank사용
SELECT
    *
FROM
    (
        SELECT
            s.*,
            RANK()
            OVER(
                ORDER BY
                    stu_height DESC
            ) AS rank1
        FROM
            student s
        WHERE
            stu_height IS NOT NULL
    )
WHERE
    rank1 <= 5;