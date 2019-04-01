-- 오라클 명령문(SQL)  : 데이터 입력/출력(select)/ 수정/ 삭제
-- 					(DML : Data Manipulaion Language)

--[1] 샘플 테이블 생성
create table exam01(
	deptno number(2),
	dname varchar2(14),
	loc		  varchar2(14)
);

select * from tab;

--[2] 데이터입력(저장) : insert into ~ values()
insert into exam01(deptno, dname, loc)
values(10, 'ACCOUNT','NEWYORK');

insert into exam01(dname,deptno,loc)
values('research',20,'dallas')

select * from exam01;

--[3] 데이터 입력 : 행 생략
insert into exam01 values(30,'research','dallsk');

--[4] null 값 입력
insert into exam01 values (40,'OPERATION', null);

--[5] 데이터 출력 : select문
--					/03_select_command.sql 참조

--[6] 필드의 데이터를 변경 : 부서 번호 변경
update exam01 set deptno = 30;

update exam01 set deptno = 77
where dname = 'ACCOUNT'

select * from exam01

--[7] 급여 10% 인상 금액반환
update exam02 set sal = sal * 1.1
select * from exam02;

--[8] 부서 번호가 10인 사원의 부서번호를 20으로 변경
update exam02 set deptno = 20 where deptno = 10;

--[9] 급여가 3000이상인 사원들만 급여를 10%인상
update exam02 set sal = sal * 1.1 where sal >= 3000;

-- [10] 사원 이름이 scott인 자료의 부서번호를 10, 직급을MANAGER로 번경
update exam02 set deptno = 10, job = 'MANAGER' where ename = 'SCOTT'

-- [11] 부서번호가 30인 사원 삭제
delete from exam02
where deptno = 20;

delete from exam02;
select * from exam02;

