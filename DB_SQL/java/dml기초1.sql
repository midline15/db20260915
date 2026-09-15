select * from fruit;

insert into fruit
VALUES('사과', 1000, 20);

insert into fruit 
VALUES('바나나', 500, 30);

COMMIT;

ROLLBACK;

SELECT PRICE, CNT
FROM FRUIT
WHERE FRUIT_NAME = '사과';

SELECT *
FROM FRUIT
WHERE PRICE <= 800;

SELECT *
FROM FRUIT
ORDER BY FRUIT_NAME ASC;

SELECT *
FROM FRUIT
ORDER BY CNT DESC;

UPDATE FRUIT SET 
    PRICE = 1100,
    CNT = CNT + 5
WHERE fruit_name = '사과';

DELETE FROM FRUIT
WHERE FRUIT_NAME = '바나나';