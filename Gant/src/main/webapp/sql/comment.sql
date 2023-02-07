drop table comment cascade constraints purge;
CREATE TABLE comment(
num               NUMBER primary key,           
id                 varchar2(15) references members(id) on delete cascade,     
content           VARCHAR2 (200), 
reg_date          date,
comment_board_num NUMBER references board(board_num) on delete cascade, --comm 테이블이 참조하는 보드 글번호
comment_re_lev    NUMBER(1) check(comment_re_lev in (0,1,2)), -- 원문이면 0 답글이면 1 답글의 답글은 2
comment_re_seq    NUMBER, --원문이면 0 , 1 레벨이면 1레벨 시퀀스 +1
comment_re_ref    NUMBER -- 원문은 자신 글번호 , 답글이면 원문 글 번호
);

-- 게시판 글이 삭제되면 참조하는 댓글도 삭제됩니다.


drop sequence comment_seq; --시퀀스삭제


create sequence comment_seq;--시퀀스생성


select * from comment;


--member에 있는 memberfile이 필요합니다.
--1. comment_re_ref asc , comment_re_seq asc (등록순)
--2. comment_re_ref desc , comment_re_seq asc (최신순)

select comment.* , member.memberfile
from comment inner join member
on comment.id=member.id
where comment_board_num = ?
order by comment_re_ref desc , comment_re_seq asc;

   
    
    
  