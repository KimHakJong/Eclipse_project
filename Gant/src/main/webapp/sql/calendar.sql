drop table calendar cascade constraints purge;

create table calendar(

name varchar2(15),
id varchar2(15),
admin varchar2(15),
allday varchar2(15) default 'true',
startday varchar2(30),
endday varchar2(30),
title varchar2(15)

);

CREATE SEQUENCE calseq START WITH 1 INCREMENT BY 1;

drop sequence calseq;



insert into members values('true','asd12345','12345678','박길동','811111-1111111','010-1111-1111','1@1.com','22222','서울시 종로구','인사부','대리',null,'20230201');