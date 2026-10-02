insert into board(title, contents,userid)
values('asdf', 'asdfasdf','asdf');
select * from board;
insert into board
values(null,'fkndlknf','flkanslknfe','stae',0,now(),now());

select * from board_comment;
insert into board_comment
values(null,2,'assd24vdf','asdadv',now(),now());

select *
from board b
join board_comment c on b.boardno = c.boardno;

select title || contents
from board;

select concat(boardno, title, contents)
from board;

select COALESCE(cnt, 100)
from board;
select ifnull(cnt, 100)
from board;

select truncate(123.456,1);

select 
	date_format(cdatetime, '%Y'),
    date_format(cdatetime, '%y'),
    date_format(cdatetime, '%M'),
    date_format(cdatetime, '%m'),
    date_format(cdatetime, '%D'),
    date_format(cdatetime, '%d'),
    date_format(cdatetime, '%H'),
    date_format(cdatetime, '%h'),
    date_format(cdatetime, '%I'),	-- 시간
    date_format(cdatetime, '%i'),
    date_format(cdatetime, '%S'),
    date_format(cdatetime, '%s'),
    date_format(cdatetime, '%Y. %m. %d. %H:%i:%s')
from board_comment