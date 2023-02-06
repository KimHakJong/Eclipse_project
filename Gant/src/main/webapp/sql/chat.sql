create table chat(
id		 	varchar2(15) references members(id) on delete cascade,
name 		varchar2(15), 
contents	varchar2(2000), 
regdate 	date default sysdate, 
chatimg 	varchar2(50)
);