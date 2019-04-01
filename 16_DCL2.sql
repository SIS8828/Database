-- * 오라클 : 사용자(User) 권한(Role)
--                       (DCL:Data Control Language)
--   
--   [1] 권한의 역할과 종류
--        -권한:사용자가 특정 테이블에 접근할 수 있도록 하거나
--                 해당 테이블에 sql(select/insert/update/delete)문을
--                 사용할 수 있도록 제한을 두는 것.
--        - 데이터베이스 보안을 위한 권한은 시스템 권한과
--           객체 권한으로 나눌 수 있다.
--        - 시스템 권한 : 사용자의 생성과 제거, DB 접근 및 각종
--                             객체를 생성할 수 있는 권한등 주로 DBA에 부여됨.
--        - 객체 권한 : 객체를 조작할 수 있는 권한.

--   [2] thomas 계정 생성(system 연동)
create user thomas identified by tiger;

--   [3] 데이터베이스 접속 권한 부여
grant create session to thomas;

-- thomas 계정에서 작업
SQL>create table emp01( -- error
		empno   number(2),
		ename   varchar2(20),
		job        varchar2(20),
		deptno   number(2)
);

--   [4] 테이블 생성 권한 부여
grant create table to thomas;

--   [5] 테이블스페이스 확인
--       : 테이블 스페이스(table space)는 디스크 공간을 소비하는 테이블과
--         뷰 그리고 그 밖의 다른 데이터베이스 객체들이 저장되는 장소.
--       cf) 오라클 xe 버전의 경우 메모리 영역은 system으로 할당.
--            오라클 full 버전의 경우 메모리 영역은 users으로 할당.
alter user thomas quota 2m on system;

SQL>select * from tab;
SQL>desc emp01;


-- 계정 생성 및 테이블 생성까지의 권한 부여 정리
C:\User>sqlplus system/admin1234
SQL>create user thomas identified by tiger;
SQL>grant create session to thomas;
SQL>grant create table to thomas;
SQL>alter user thomas quota 2m on system;



--   [6] with admin option
--        : 사용자에게 시스템 권한을 with admin option과 함께 부여하면
--          그 사용자는 데이터베이스 관리자가 아닌데도 불구하고 부여받은
--          시스템 권한을 다른 사용자에게 부여할 수 있는 권한도 함께 부여 
--          받게 됨.

-- tester1 계정 생성 및 권한 부여
create user tester1 identified by tiger;
grant create session to tester1;
grant create table to tester1;
alter user tester1 quota 2m on system;

SQL>conn tester1/tiger
SQL>grant create session to thomas; -- error


-- tester2 계정 생성 및 권한 부여
create user tester2 identified by tiger;
grant create session to tester2 with admin option;
grant create table to tester2;
alter user tester2 quota 2m on system;

SQL>conn tester2/tiger
SQL>grant create session to thomas;

--   [7] 테이블 객체에 대한 select 권한 부여(scott/emp -> thomas)
SQL>conn scott/tiger
SQL>grant select on emp to thomas;
SQL>conn thomas/tiger
SQL>select * from emp; -- error

--   [8] 스키마(SCHEMA) : 객체를 소유한 사용자명을 의미.
SQL>select * from scott.emp;

--   [9] 사용자에게 부여된 권한 조회
--        . user_tab_privs_made : 현재 사용자가 다른 사용자에게 부여한 
--                                            권한 정보를 알려줌.
--        . user_tab_privs_recd : 자신에게 부여된 사용자 권한을 알고 
--                                             싶을 때.
SQL>conn thomas/tiger
SQL>select * from user_tab_privs_made;
SQL>select * from user_tab_privs_recd;

--   [10] 비밀번호 변경 시 
SQL>conn system/admin1234
alter user thomas identified by thomas;
alter user thomas identified by tiger;

--   [11] 객체 권한 제거하기
SQL>conn scott/tiger
SQL>revoke select on emp from thomas;


--   [12] with grant option
--          : 사용자에게 객체 권한을 with grant option과 함께 부여하면
--            사용자는 객체를 접근할 권한을 부여 받으면서 그 권한을 다른
--            사용자에게 부여할 수 있는 권한도 함께 부여받게 됨.































