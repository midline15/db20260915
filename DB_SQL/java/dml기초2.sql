-- 오렌지, 1500원 15개 삽입
-- 가격이 1000원 이상 조회
-- 오렌지 과일의 개수를 기존개수 -3개
-- COMMIT
-- 오렌지 과일 삭제
-- ROLLBACK

INSERT INTO FRUIT
VALUES ('오렌지', 1500, 15);

SELECT * 
FROM FRUIT
WHERE PRICE >= 1000;

UPDATE FRUIT SET
    CNT = CNT -3
WHERE FRUIT_NAME = '오렌지';

COMMIT;

DELETE FROM FRUIT
WHERE FRUIT_NAME = '오렌지';

SELECT *
FROM FRUIT;

ROLLBACK;

--update fruit set price = 5000 where fruit_name = '키위'