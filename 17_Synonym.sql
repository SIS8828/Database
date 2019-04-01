--  * 오라클 - 동의어(Synonym)
--     · 객체를 조회할 때마다 일일이 객체의 소유자를 지정하는 것이 번거로울 경우 동의어를 정의하면 
--       긴 이름대신 간단한 이름으로 접근할 수 있다.

--   - 종류
--         · 비공개 동의어
--            - 객체에 대한 접근 권한을 부여 받은 사용자가 정의한 동의어로 해당 사용자만 사용할 수 있다.
--         · 공개 동의어
--            - 권한을 주는 사용자가 정의한 동의어로 누구나 사용할 수 있다.
--            - 공개 동의어는 DBA 권한을 가진 사용자만이 생성할 수 있다.
--            - SYNONYM 앞에 PUBLIC를 붙여서 정의한다.
--            - ex) dual은 원래 sys가 소유하는 테이블 명이므로 다른 사용자가 dual 테이블에 접근하려면
--                    sys.dual로 표현해야 하는 것이 원칙. 모든 사용자가 sys. 을 생략하고 접근한 것이 공개
--                    동의어로 지정되어 있기 때문.

--[1] 테이블 생성 후 객체 권한 부여하기
SQL> conn system/admin1234
SQL> create table table_systbl(
	ename varchar2(20)
);

SQL> insert into table_systbl values('이순신');
SQL> insert into table_systbl values('강감찬');
SQL> select * from table_systbl;

-- scott 사용자에게 table_systbl이란 테이블에 select 할 권한을 부여한다.

SQL> grant select on table_systbl to scott;

SQL> conn scott/tiger
SQL> select * from table_systbl; --error
SQL> select * from system.table_systbl; -- 스키마를 이용해 호출

--[2] 동의어 생성 및 의미 파악하기
SQL> conn system/admin1234
SQL> grant create synonym to scott;
SQL> conn scott/tiger
SQL> create synonym systab for system.table_systbl; -- 권한부여시  'create synonym 별칭 for 테이블명' 으로 설정하면 별칭으로 스키마를 사용하지 않고 호출 가능하다.
SQL> select * from systab;

--[3] 비공개 동의어 생성 및 의미
--		: 사용자 정의롤을 생성한 후에 사용자 정의 롤에 connect, resource role 과 create sysnonym 권한과 scott소유자의 
--		  emp테이블과 dept 테이블에 대한 select 객체 권한을 role에 부여
SQL> conn system/admin1234
SQL> create role test_role;
SQL> grant connect, resource, create synonym to test_role;
SQL> grant select on scott.dept to test_role;

-- 사용자 생성
SQL> create user tester10 identified by tiger;
SQL> create user tester11 identified by tiger;


-- 사용자에게 롤 부여
SQL> grant test_role to tester10;
SQL> grant test_role to tester11;

SQL> conn scott/tiger
SQL> grant select on dept to tester10;

SQL> conn tester10/tiger
SQL> select * from dept; -- error
SQL> select * from scott.dept;

-- 사용자 tester10 비공개 동의어 생성
SQL> conn tester10/tiger
SQL> create synonym sdept for scott.dept;
SQL> select * from sdept;

SQL> conn test11/tiger;
SQL> select * from sdept; -- error(비공개 동의어)

--[4] 공개 동의어 정의하기
SQL> conn system/admin1234
SQL> create public synonym PubDept for scott.dept;

-- 사용자 생성
SQL> create user tester12 identified by tiger;

-- 사용자에게 권한 부여
SQL>grant test_role to tester12;

SQL> conn tester12/tiger
SQL> select * from PubDept; -- 공개동의어 사용

--[5] 비공개 동의어제거하기
--  	: 비공개 동의어인 dept는 동의어를 소유한 사용자로 접속한 후
--		  제거해야한다.

SQL> conn tester10/tiger
SQL>	 drop synonym sdept;

--[6] 공개 동의어 제거하기
SQL> conn system/admin1234
SQL> drop synonym PubDept; -- error
SQL> drop public synonym PubDept;  -- 공개동의어 제거시 public을 붙여줘야된다.


