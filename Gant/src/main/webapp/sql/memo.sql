create table memo (
id      	varchar2(15) references members(id) on delete cascade,
content 	varchar2(3000),
background varchar2(100),
color		varchar2(20)
);
select * from memo;
drop table memo;