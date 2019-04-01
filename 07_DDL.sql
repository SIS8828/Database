-- * 오라클 SQL 문: 테이블 생성/수정/삭제
--					(DDL: Data Definition Language)

-- [1] 테이블 생성: create table 문
create table exam01(
	exno 			number(4),
	exname 		varchar2(20),
	exsal			number(7,2)
);
select * from tab;
select * from exam01

--[2] 기존 테이블과 동일한 테이블 만들기
create table exam02
as
select * from emp;

select * from exam02;

--[3] 기존 테이블에서 새로운 컬럼 추가 : alter문(필드추가)
alter table exam01 add (
								exjob varchar2(10)
								);
select * from exam01

--[4] 테이블 구조 수정: 필드 수정
alter table exam01 
modify(
	exjob varchar2(20)
);

desc exam01; --- cmd창에서 확인

--[5] 테이블 구조 수정 : 필스 삭제
alter table exam01
drop column exjob;

select * from exam01;
								
--[6] 테이블 수정: 이름변경
alter table exam01 rename to test01 -- 방법1

select * from tab;

rename test01 to exam01; -- 방법2

select * from tab;

--[7] 테이블 삭제
drop table exam01;
select * from tab;
-- 오라클 10g 부터는 테이블을 삭제하면
--  BIN$8/yCt8rQT9aWzZGpq9SdYA==$0와 같은 임시 테이블로 교체된다.
-- 임시테이블을 삭제하고 싶다면;
purge recyclebin;
select * from tab;

-- 처음부터 테이블을 완전 삭제하고 싶다면?
drop table exam02 purge;

--[8] 테이블 내의 모든 데이터(레코드) 삭제
truncate table exam02;
select * from exam02;

