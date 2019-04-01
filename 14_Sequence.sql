-- 시퀀스
-- : 테이블 내의 유일한 숫자를 자동으로 생성하는 자동 번호 발생기.
-- : 테이블 생성 후 시퀀스(일련번호)를 따로 만들어야 한다.

--[1] 샘플 테이블 생성
create table memos(
	num 		number(4) constraint memos_num_pk primary key,
	name 	varchar2(20) constraint memos_name_nn not null,
	pdstDate Date default(sysdate)
)


--[2] 해당 테이블의 시퀀스생성
create sequence memos_seq
start with 1 increment by 1;

--[3] 데이터 입력: 일련번호 포함
insert into memos(num, name) values(memos_seq.nextVal, '홍길동');
insert into memos(num, name) values(memos_seq.nextVal, '송일수');
insert into memos(num, name) values(memos_seq.nextVal, '강감찬');
insert into memos(num, name) values(memos_seq.nextVal, '신원호');
insert into memos(num, name) values(memos_seq.nextVal, '이순신');

-- [4] 현재 시퀀스가 어디까지 증가되어져 있는지 확인.
--

--[5] 시퀀스 수정 : 최대 증가값을 8까지 제한
alter sequence memos_seq maxvalue 10;
insert into memos(num, name) values(memos_seq.nextVal, '안중근');
insert into memos(num, name) values(memos_seq.nextVal, '김구');
insert into memos(num, name) values(memos_seq.nextVal, '세종대왕');


insert into memos(num, name) values(memos_seq.nextVal);

select * from memos

--[6] 시퀀스 삭제
drop sequence memos_seq;

--[7] 시퀀스 없는 상태에서 자동증가값 구현?
select max(num) from memos;

insert into memos(num, name) values(max(num), '정조')
