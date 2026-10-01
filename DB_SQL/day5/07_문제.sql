-- BOOK, CUSTOMER, ORDERS
--1. BOOK 테이블에서 PRICE 가 20000 이상인 레코드를 출력하시오.
select *
from book
where price >= 2000;
--2. BOOK 테이블에서 BOOKNAME 컬럼에 '야구' 가 들어간 레코드 출력하시오.
select *
from book
where bookname like '%야구%';
--3. BOOK 테이블에서 PUBLISHER 컬럼이 '굿스포츠'인 데이터를 BOOKNAME 컬럼 내림차순으로 출력하시오.
select *
from book
where publisher = '굿스포츠'
order by bookname desc;
--4. BOOK 테이블에서 PRICE 가 5000이상 20000이하 데이터 출력하시오.
select *
from book
where price between 5000 and 20000;

--5. CUSTOMER 테이블에서 PHONE가 NULL이 아니고 CUSTID가 3이상인 레코드 출력하시오.
select *
from customer
where phone is not null and
    custid >=3;
    
--6. 고객별 평균 주문 금액을 반올림한 값을 출력하시오.(고객명, 평균 주문 금액 출력)
select
    c.name,
    round(avg(saleprice))
from orders o
join customer c on o.custid = c.custid
group by c.custid, c.name;

--7. 이상미디어의 책을 구매한 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
select 
substr(c.name,1,1),
count(*)
from orders o
join book b on o.bookid = b.bookid
join customer c on o.custid = c.custid
where b.publisher = '이상미디어'
group by substr(c.name,1,1);

--8. 이상미디어에서 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객이름, 도서번호를 모두 보이시오. 
select 
   o.orderid, 
   o.orderdate,
   c.name,
   o.bookid
from orders o
join book b on o.bookid = b.bookid
join customer c on o.custid = c.custid
where to_char(o.orderdate, 'yyyy-mm-dd') = '2020-07-07'
    and b.publisher = '이상미디어';

--9. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시하시오.
select 
    name,
    nvl(phone,'연락처없음')
from customer;

--10. 전체 평균 주문금액 보다 금액이 작은 주문에 대해서 주문번호와 금액을 출력하시오.
select
    o.orderid,
    o.saleprice
from orders o
where saleprice < (
    select
        avg(saleprice)
    from orders
);

--11. ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 출력하시오.
select
    sum(saleprice)
from orders o
join customer c on o.custid = c.custid
where c.address like '%대한민국%';

--12. 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 출력하시오.
select 
    orderid,
    saleprice
from orders
where saleprice > (select max(saleprice)
from orders
where custid=3);


--13. 이상미디어의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력).
select 
    saleprice
from