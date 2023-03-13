create table members(
admin       varchar2(5) check (admin in ('true','false')),
id      varchar2(15) PRIMARY KEY,
password    varchar2(20),
name      varchar2(15),
jumin      varchar2(14),
phone_num    varchar2(13),
email      varchar2(30),
post      number(5),
address     varchar2(60),
department    varchar2(15),
position    varchar2(10),
profileimg   varchar2(30),
hiredate    varchar2(8) default to_char(SYSDATE, 'YYYYMMDD') not null -- 입사일

);

select * from members;

