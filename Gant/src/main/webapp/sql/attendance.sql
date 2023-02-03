drop table attendance cascade constraints purge;

CREATE TABLE attendance(
id	                varchar2(15), --아이디
overtime	        varchar2(8), -- 초가 근무시간
work_today	        varchar2(8), -- 하루 근무시간
work_week           varchar2(8), -- 주간 근무시간
overtime_content	varchar2(2000), -- 근태신청 작업내용
overtime_reason	    varchar2(2000) -- 근태신청 사유
);

select * from attendance;
