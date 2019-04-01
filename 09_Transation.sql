--  * 오라클 - 트랜잭션(transation)
----     : 데이터 처리의 한 단위.
----     : 오라클에서 발생하는 여러 개의 SQL 명령문들을
--          하나의 논리적인 작업 단위로 처리.
----     : 데이터의 일관성을 유지하면서 안정적으로 데이터를 복구.

--     . commit : 명령어 완전 실행(DB 최종 적용).
--     . rollback : 명령어 되돌리기(실행 해제).

-- 유의 사항
---- . DDL 자동 트랜젝션이 적용(commit).
---- . DML : 정상적으로 종료되었다면 자동으로 commit.
---- . 정전이 발생하거나 컴퓨터가 다운시 자동으로 rollback.

--[1] 테이블 생성
create table dept01
as 
select * from dept;

--[2] command 창에서 실습 진행 할 것.
--     . 두 개의 command 창을 띄워서 scott 계정으로 접속.
delete from dept01; -- command 창에서 실행 및 데이터 확인.
select * from dept01;

--command(2)에서 실행 및 데이터 확인.
select * from dept01; -- command(1)에서 실행 내용 반영x.

--command(1)에서 
commit; -- 명령을 실행하면 최종 반영.

--command(2)에서 실행 및 데이터 확인.
select * from dept01; -- command(1)에서 실행 내용 반영0.

--[3] 되돌리기 : command 창에서 실습 진행 할 것.
-- [2]번과 동일 실습 진행.
rollback;  -- 명령을 실행하면 마지막의 commit 단계로 복원.

select * from exam01;

--     . 두 개의 command 창을 띄워서 scott 계정으로 접속.
delete from exam01; -- command 창에서 실행 및 데이터 확인.
select * from exam01;

--command(2)에서 실행 및 데이터 확인.
select * from exam01; -- command(1)에서 실행 내용 반영x.

--command(1)에서 
rollback; -- 명령을 실행하면 최종 반영.

--command(2)에서 실행 및 데이터 확인.
select * from exam01; -- command(1)에서 실행 내용 반영0.



