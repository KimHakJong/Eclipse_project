create table calendar(
id varchar2(15),
startday date,
endday date,
title varchar2(15)

);


drop table calendar cascade constraints purge;
