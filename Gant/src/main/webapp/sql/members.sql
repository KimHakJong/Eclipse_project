create table members(
admin 		varchar2(5) check (admin in ('true','false')),
id		varchar2(15) PRIMARY KEY,
password 	varchar2(20),
name		varchar2(15),
jumin		varchar2(14),
phone_num 	varchar2(13),
email		varchar2(30),
post		number(5),
address  		varchar2(60),
department 	varchar2(15),
position		varchar2(10),
profileimg	varchar2(30)
);
select * from members;

insert into members (admin,id,password,name,jumin,phone_num,email,post,address,department,position)
values ('false','choi55','hakjong1','최공사','111218-1111111','010-4514-1233',
		'tosil0702@naver.com','33332','서울시 관악구','총무부','부장');