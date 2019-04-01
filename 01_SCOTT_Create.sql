c:\>sqlpuls system/admin

SQL>@c:\scott.sql
SQL>alter user scott identified by tiger; -- 비밀번호 변경
SQL>conn scott/tiger -- scott 계정으로 변환
SQL>show user;
SQL>select * from tap; -- scott 계정 테이블 목록
SQL>select * from dept;
SQL>select * from emp;
SQL>quit; -- 종료