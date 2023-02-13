drop table vacation cascade constraints purge;


CREATE TABLE vacation(
id	            varchar2(15) references members(id) on delete cascade, --	아이디
startDate	    varchar2(8),	 -- 휴가시작일 20230202 -> 2023년02월02일
endDate	        varchar2(8),	 -- 휴가마지막일 20230202
vacation_num	number ,	     --휴가갯수
emergency	    varchar2(13),	--비상연락망 010-0000-0000
details	        varchar2(2000)	--세부사항
);

delete from vacation;

select * from vacation;

