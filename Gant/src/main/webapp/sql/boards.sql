drop table boards cascade constraints purge;


CREATE TABLE BOARDS(
BOARD_NUM        NUMBER PRIMARY KEY,           --글 번호
BOARD_NAME       VARCHAR2(30) references members(id) on delete cascade,  --작성자 
BOARD_PASS       VARCHAR2 (30),    --비밀번호
BOARD_SUBJECT    VARCHAR2 (300),   --제목
BOARD_CONTENT    VARCHAR2 (4000), --내용
BOARD_FILE       VARCHAR2(50),     --침부될 파일 명
BOARD_RE_REF     NUMBER,    -- 답변 글 작성시 참조되는 글의 번호
BOARD_RE_LEV     NUMBER,    -- 답변 글의 깊이
BOARD_RE_SEQ     NUMBER,    -- 답변 글의 순서 
BOARD_READCOUNT  NUMBER,    -- 글이 조회수
BOARD_DATE       VARCHAR2(10) default to_char(SYSDATE, 'YYYY/MM/DD') not null, -- 글작성날짜
BOARD_LIKE       NUMBER, -- 좋아요수
BOARD_NOTICE     VARCHAR2(5) check (BOARD_NOTICE in ('true','false')), -- 공지사항글이면 true 아니면 false
fontColor        VARCHAR2(15), -- 게시판 글 색
fontSize         VARCHAR2(15), -- 게시판 글 사이즈
fontWeight       NUMBER   -- 게시판 글 굵기
);



-- 게시글에 달린 댓글의 갯수를 구하기 위한 과정입니다.
select * from boards;
delete from boards where BOARD_PASS !=1;


select * from boards where BOARD_SUBJECT LIKE '%이%';

insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF, BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE,
fontColor,fontSize,fontWeight) 
values(1,'처음이','안녕','admin',1,0,0,1,2,'false','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE,  
fontColor,fontSize,fontWeight)
values(2,'둘째이','안녕','admin',2,0,0,1,3,'true','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE , 
fontColor,fontSize,fontWeight)
values(3,'셋째이','안녕','admin',3,0,0,1,4,'false','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF, BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ,
fontColor,fontSize,fontWeight)
values(4,'넷째','안녕','admin',4,0,0,1,2,'false','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE,  
fontColor,fontSize,fontWeight)
values(5,'다섯째','안녕','admin',5,0,0,1,3,'false','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE , 
fontColor,fontSize,fontWeight)
values(6,'여섯째','안녕','admin',6,0,0,1,4,'false','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF, BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ,
fontColor,fontSize,fontWeight)
values(7,'일곱째','안녕','admin',7,0,0,1,2,'true','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE , 
fontColor,fontSize,fontWeight)
values(8,'팔팔이','안녕','admin',8,0,0,1,3,'false','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE , 
fontColor,fontSize,fontWeight)
values(9,'구이','안녕','admin',9,0,0,1,4,'true','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF, BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ,
fontColor,fontSize,fontWeight)
values(10,'처음이','안녕','admin',10,0,0,1,2,'false','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE , 
fontColor,fontSize,fontWeight)
values(11,'둘째이','안녕','admin',11,0,0,1,3,'false','black','15px',400);
insert into boards (BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE , 
fontColor,fontSize,fontWeight)
values(12,'셋째이','안녕','admin',12,0,0,1,4,'true','black','15px',400);


insert into com (num, id , comment_board_num) values(1,'admin',1);  -- 1번 게시물 댓글
insert into com (num, id , comment_board_num) values(2,'admin',1);
insert into com (num, id , comment_board_num) values(3,'admin',2); -- 2번 게시물 댓글
insert into com (num, id , comment_board_num) values(4,'admin',2);






    
   