-- * 오라클 : 사용자(User) 권한(Role)
--                       (DCL:Data Control Language)
--   
----[1] 권한의 역할과 종류
--        -권한:사용자가 특정 테이블에 접근할 수 있도록 하거나
--                 해당 테이블에 sql(select/insert/update/delete)문을
--                 사용할 수 있도록 제한을 두는 것.
--        - 데이터베이스 보안을 위한 권한은 시스템 권한과
--           객체 권한으로 나눌 수 있다.
--        - 시스템 권한 : 사용자의 생성과 제거, DB 접근 및 각종
--                             객체를 생성할 수 있는 권한등 주로 DBA에
--                             부여됨.
--        - 객체 권한 : 객체를 조작할 수 있는 권한.

--[2] ilsu 계정 생성(system 연동 )
create user ilsu identified by ilsu;

--[3] 접속권한부여
grant create session to ilsu;

SQL>create table emp01( --error
		empno number(2),
		ename varchar2(20),
		job	  varchar2(20),
		deptno number(2)
);

-- [4] 테이블 생성권한 부여
grant create table to ilsu

--[5] 테이ㅡㄹ스페이스 확인
--		: 테이블 스페이스(table space)는 디스크 공간을 소비하는 테이블과
--		  뷰 그리고 그 밖의 다른 데이터베이스 객체들이 저장되는 장소
--		cf) 오라클 xe 버전의 경우 메모리 영역은 system으로 할당
--			오라클 full 버전의 경우 메모리 영역은 user으로 할당
alter user ilsu quota 2m on system;

SQL> select * from tab;
SQL> desc emp01;

-- 계정 생성 및 테이블 생성까지의 권한 부여 정리
C:\User>sqlplus system/admin1234
SQL> create user ilsu identified by ilsu
SQL> grant create session to ilsu;
SQL> grant create table to ilsu
SQL> alter user ilsu quota 2m on system;


--[6] with admin option

-- tester1 계정생성 및 권한부여
create user tester1 identified by tiger
grant create session to tester1;
grant create table to ilsu
alter user tester1 quota 2m on system;

SQL> conn tester2/tiger
SQL> grant create session to ilsu

--[7] 테이블 객체에 대한 select 권한 부여 (scott/emp-> ilsu)
SQL> conn scott/tiger
SQL> grant select on emp to ilsu;
SQL> conn ilsu/ilsu
SQL> select * from emp

--[8] 스키마 : 객체를 소유한 사용자 명을 의미
select * from scott.emp;

--[9] 사용자에게 부여된 권한 조회
-- .user_tab_privs_made: 현재 사용자가 다른 사용자에게 부여한 권한정보확인
-- .user_tab_privs_recod : 자신에게 부여된 사용자 권한을 알고 싶을떄.
 
SQL> select * from user_tab_privs_made;
SQL> select * from user_tab_privs_recd;

--[10] 비밀번호 변경시
SQL> conn system/admin1234
alter user ilsu identified by ilsu

--[11] 객체 권한 제거하기
SQL> conn scott/tiger
SQL> revoke select on emp from ilsu

--[12] with grant option
--		:  사용자에게 객체 권한을 with grant option과 함께 부여하면
--			사용자는 객체를 접근할 권할을 부여 받으면서 그 권한을 다른
--			사용자에게 부여할 수 있는 권한도 함께 부여받게 됨.

SQL> conn scott/tiger
SQL> grant select on emp to ilsu

SQL>conn


--[13] 사용자 계정 제거
SQL> conn system/admin1234
drop user tester2;

--[14] 롤(Role)
----    . 사용자에게 보다 효율적으로 권한을 부여할 수 있도록
--         여러개의 권한을 묶어 놓은 것.
----    . 사용자를 생성했으면  그 사용자에게 각종 권한을 
--         부여해야만 생성된 사용자가 데이터베이스를 사용할
--         수 있음.

--   1) connect Role
--       . 사용자가 데이터베이스에 접속 가능하도록 하기 
--         위해서 다음과 같이 가장 기본적인 시스템 권한
--         8가지 묶어 놓은 권한.
--       . alter session, create cluster, create database link,
--         create sequence, create session, create synonym,
--         create table, create view

--   2) resource Role
--       . 사용자가 객체(테이블, 시퀀스, 뷰)를 생성할 수 있도록
--         시스템 권한을 묶어 놓은 것.
--       . create cluster, create procedure, create sequence,
--         create table, create trigger

--   3) DBA Role
--       . 사용자들이 소유한 데이터베이스 객체를 관리하고 
--         사용자들이 작성하고 변경하고 제거할 수 있도록 하는
--         모든 권한을 가짐.

SQL> conn system/admin1234; 




