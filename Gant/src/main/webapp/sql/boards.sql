drop table board cascade constraints purge;
CREATE TABLE BOARDS(
id              VARCHAR2(15) references members(id) on delete cascade,
BOARD_NUM       NUMBER PRIMARY KEY,           --글 번호
BOARD_NAME      VARCHAR2(30),     --작성자
BOARD_PASS      VARCHAR2 (30),    --비밀번호
BOARD_SUBJECT   VARCHAR2 (300),   --제목
BOARD_CONTENT   VARCHAR2 (4000), --내용
BOARD_FILE      VARCHAR2(50),     --침부될 파일 명
BOARD_RE_REF    NUMBER,    -- 답변 글 작성시 참조되는 글의 번호
BOARD_RE_LEV    NUMBER,    -- 답변 글의 깊이
BOARD_RE_SEQ    NUMBER,    -- 답변 글의 순서 
BOARD_READCOUNT NUMBER,    -- 글이 조회수
BOARD_DATE DATE default sysdate,
);

-- 게시글에 달린 댓글의 갯수를 구하기 위한 과정입니다.
select * from board;
delete from board;

insert into board (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF ) values(1,'처음','admin',1);
insert into board (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF ) values(2,'둘째','admin',2);
insert into board (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF ) values(3,'셋째','admin',3);


insert into comm (num, id , comment_board_num) values(1,'admin',1);  -- 1번 게시물 댓글
insert into comm (num, id , comment_board_num) values(2,'admin',1);
insert into comm (num, id , comment_board_num) values(3,'admin',2); -- 2번 게시물 댓글
insert into comm (num, id , comment_board_num) values(4,'admin',2);

update board
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




    
   