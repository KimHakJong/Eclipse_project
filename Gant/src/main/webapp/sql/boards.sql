drop table boards cascade constraints purge;


CREATE TABLE BOARDS(
id               VARCHAR2(15) ,--references members(id) on delete cascade 완성되면 넣겠습니다.
BOARD_NUM        NUMBER PRIMARY KEY,           --글 번호
BOARD_NAME       VARCHAR2(30),     --작성자
BOARD_PASS       VARCHAR2 (30),    --비밀번호
BOARD_SUBJECT    VARCHAR2 (300),   --제목
BOARD_CONTENT    VARCHAR2 (4000), --내용
BOARD_FILE       VARCHAR2(50),     --침부될 파일 명
BOARD_RE_REF     NUMBER,    -- 답변 글 작성시 참조되는 글의 번호
BOARD_RE_LEV     NUMBER,    -- 답변 글의 깊이
BOARD_RE_SEQ     NUMBER,    -- 답변 글의 순서 
BOARD_READCOUNT  NUMBER,    -- 글이 조회수
BOARD_DATE       VARCHAR2(10) default to_char(SYSDATE, 'YYYY/MM/DD') not null, -- 입사일
BOARD_LIKE       NUMBER, -- 좋아요수
BOARD_LIKE_CHECK VARCHAR2(5) check (BOARD_LIKE_CHECK in ('true','false')), -- 좋아요가 클릭되면 true 아니면 false
BOARD_NOTICE     VARCHAR2(5) check (BOARD_NOTICE in ('true','false')) -- 공지사항글이면 true 아니면 false
);

-- 게시글에 달린 댓글의 갯수를 구하기 위한 과정입니다.
select * from boards;
delete from boards;

insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF, BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE) 
values('admin',1,'처음이','안녕','admin',1,0,0,1,2,'false');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ) 
values('admin',2,'둘째이','안녕','admin',2,0,0,1,3,'true');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ) 
values('admin',3,'셋째이','안녕','admin',3,0,0,1,4,'false');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF, BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE) 
values('admin',4,'넷째','안녕','admin',4,0,0,1,2,'false');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ) 
values('admin',5,'다섯째','안녕','admin',5,0,0,1,3,'false');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ) 
values('admin',6,'여섯째','안녕','admin',6,0,0,1,4,'false');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF, BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE) 
values('admin',7,'일곱째','안녕','admin',7,0,0,1,2,'true');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ) 
values('admin',8,'팔팔이','안녕','admin',8,0,0,1,3,'false');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ) 
values('admin',9,'구이','안녕','admin',9,0,0,1,4,'true');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF, BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE) 
values('admin',10,'처음이','안녕','admin',10,0,0,1,2,'false');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ) 
values('admin',11,'둘째이','안녕','admin',11,0,0,1,3,'false');
insert into boards (id,BOARD_NUM, BOARD_SUBJECT,BOARD_CONTENT, BOARD_NAME, BOARD_RE_REF,BOARD_RE_LEV,BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_LIKE,BOARD_NOTICE ) 
values('admin',12,'셋째이','안녕','admin',12,0,0,1,4,'true');


insert into com (num, id , comment_board_num) values(1,'admin',1);  -- 1번 게시물 댓글
insert into com (num, id , comment_board_num) values(2,'admin',1);
insert into com (num, id , comment_board_num) values(3,'admin',2); -- 2번 게시물 댓글
insert into com (num, id , comment_board_num) values(4,'admin',2);

update boards
set BOARD_SUBJECT = '오늘도 행복하세요'
where BOARD_NUM = 1 ;

-- 1. comm 테이블에서 comment_board_num별 갯수를 구합니다.
comment_board_num    cnt
1                    2
2                    2

select comment_board_num ,count(*) as CNT
from comm
group by comment_board_num;


-- 2. board와 조인을 합니다.
BOARD_NUM   BOARD_SUBJECT  cnt
1           오늘도 행복하세요    2
2           둘째             2

select b.BOARD_NUM , b.BOARD_SUBJECT , c.cnt
from board b join (select comment_board_num ,count(*) as CNT
                   from comm
                   group by comment_board_num) c 
on (b.BOARD_NUM = c.comment_board_num);


-- 문제점 ) 만약 board 테이블에는 글이있지만 댓글이 없는 경우 조회가 되지 않습니다.
-- 3. outer join을 이용해서 board의 글이 모두 표시도고 cnt와 null인 경우 0으로 표시되도록 합니다.
BOARD_NUM   BOARD_SUBJECT  cnt
3           세째             0
2           둘째             2
1           오늘도 행복하세요    2


-- 1단계 ) 개시판 글에 댓글이 없는경우 cnt가 null이 됩니다.
select b.BOARD_NUM , b.BOARD_SUBJECT , c.cnt
from board b left outer join (select comment_board_num ,count(*) as CNT
                   from comm
                   group by comment_board_num) c 
on (b.BOARD_NUM = c.comment_board_num);
BOARD_NUM   BOARD_SUBJECT  cnt
1           오늘도 행복하세요    2
2           둘째             2
3           세째             NULL


-- 2단계 cnt가 null 인 경우 0으로 만들어요
select BOARD_NUM , BOARD_SUBJECT , nvl(cnt,0) as cnt
from board left outer join (select comment_board_num ,count(*) as CNT
                   from comm
                   group by comment_board_num) 
on BOARD_NUM = comment_board_num
order by BOARD_RE_REF desc,
BOARD_RE_SEQ asc;

BOARD_NUM   BOARD_SUBJECT  cnt
3           세째             0
2           둘째             2
1           오늘도 행복하세요    2




    
   