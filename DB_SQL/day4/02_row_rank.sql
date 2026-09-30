--rownum 열 번호

SELECT
    s.*,
    ROWNUM
FROM
    student s
WHERE
    ROWNUM <= 3;

SELECT
    s.*,
    ROWNUM
FROM
    student s
WHERE
    stu_height IS NOT NULL
ORDER BY
    stu_height DESC;  -- 정렬전에 정해짐

SELECT
    *
FROM
    (
        SELECT
            t.*,
            ROWNUM AS r
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
            ) t
    )
WHERE
    r = 3;

SELECT
    *
FROM
    (
        SELECT
            job,
            SUM(sal)
        FROM
            emp
        GROUP BY
            job
        ORDER BY
            2 DESC
    )
    where rownum = 1;
    
-- rank, dense_rank, row_number 함수
select
    ename,
    sal,
    rank() over(order by sal desc) as rank1,
    dense_rank() over(order by sal desc) as rank2,
    row_number() over(order by sal desc, ename desc) as rank3
from emp;

select * 
from (select
    ename,
    sal,
    deptno,
    rank() over(partition by deptno  order by sal desc) as rank1
from emp)
where rank1 = 1;