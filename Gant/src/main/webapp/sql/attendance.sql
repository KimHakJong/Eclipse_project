CREATE TABLE attendance(
id                 varchar2(15) references members(id) on delete cascade, --아이디
starTtime          varchar2(8),       --출근시간
endTime              varchar2(8),       --퇴근시간
overTime          varchar2(8),       --초과근무시간
work_today          varchar2(8),       --오늘 근무시간
work_week          varchar2(8),       --주간 근무시간
work_date          varchar2(8),     -- 출근일 ex) 20220203
overtime_date      varchar2(8),     -- 초가근무 날짜
overtime_content   varchar2(2000),   --작업내용
overtime_reason      varchar2(2000),   --사유
checkbutton         varchar2(5) check (checkbutton in ('true','false')), -- 출근 퇴근 버튼 클릭시 체크 / true일때 출근버튼 비활성화상태 , false일때 퇴근버튼 비활성화 상태
check_work_week   number  DEFAULT 1 -- 매주 월요일은 주간 총 근무시간이 리셋되어야한다. 하지만 한번만 리셋되어야하기때문에 체크를 해준다.check_work_week 가 1일때만 리셋 
);

drop table attendance cascade constraints purge;

delete from attendance;

select * from attendance;