-- JOIN문

--[1] 'SCOTT'이 근무하는 부서명, 지역 출력,

select * from emp
select * from DEPT

select deptno from emp
where ename = 'SCOTT'

select dname, loc from dept
where deptno = 20

--[2] join(조인) : 두 개 이상의 테이블에 나뉘어져 있는 데이터를 한 번의 SQL문으로 원하는 결과를 얻을 수 있는 기능
-- (1) cross join : 2개 이상의 테이블이 조인될 때 where 절에 의해 공통 되는 컬럼에 의한결합이 발생하지 않는 경우를 의미

select * from emp, dept

-- (2) equi join : 조인 대상이 되는 두 테이블에서 공통적으로 존재하는
--						컬럼의 값이 일치되는 행을 연결하여 결과는 생성하는 방법
select * from emp, dept
where emp.deptno = dept.deptno;

select ename, dname, loc, emp.deptno -- deptno로 쓸경우 에러
from emp, dept
where emp.deptno = dept.deptno 
and ename = 'SCOTT'

-- 컬럼명 앞에 테이블명을 기술하여 컬럼 소속을 명확히 밝힐수 있다.
select emp.ename, dept.dname, dept.loc, emp.deptno -- deptno로 쓸경우 에러
from emp, dept
where emp.deptno = dept.deptno 
and ename = 'SCOTT'

-- 테이블명에 별칭을 부여한 후 컬럼 앞에 소속테이블을 지정하고 할때는 반드시 붙여야함
select e.ename, d.dname, d.loc, e.deptno
from  emp e, dept d
where e.deptno = d.deptno
and ename = 'SCOTT'

-- (3) non-equi join
--		동일 컬럼이 없이 다른 조건을 사용하여 join
--      조인 조건에 특정 범위 내에 있는지를 조사하기 위해서 조건절에
--		조인 조건을 = 연산자 이외의 비교 연산자를 이용

select * from emp;
select * from SALGRADE;

select ename, sal, grade
from emp, salgrade
where sal >= losal and sal <= hisal;

select ename, sal, grade
from emp, salgrade
where sal between losal and hisal;

-- emp, dept, salgrade 3개 테이블 조인
select ename, sal, grade, dname
from emp, dept, salgrade
where emp.deptno = dept.deptno
and sal between losal and hisal;


-- (4) self join: 하나의 테이블 내에서, 자기 자신과 조인을 통해 원하는
-- 					 자료를 얻는 방법
select * from emp;
-- 사원의 담당 매니저 사원 번호(mgr)
select emplyee.ename, emplyee.mgr, manager.ename
from emp emplyee, emp manager
where emplyee.mgr = manager.empno;

-- (5) outer join : 조인 조건에 만족하지 못해서 해당 결과를 출력시에
--						누락이 되는 문제점이 발생한다. 해당 레코드를
--						출력하고 싶을 때 사용하는 join 방법
select emplyee.ename, emplyee.mgr, manager.ename
from emp emplyee, emp manager
where emplyee.mgr = manager.empno(+);

--[3] ANSI join
--		(1) Ansi Cross join
select * from emp cross join dept;
select * from emp;
select * from dept;

--		(2) Ansi Inner join > 조인의 조건은 on으로 준다. > 조건을 주고싶을시에는 inner join을 사용해라
select ename, dname
from emp inner join dept
on emp.deptno = dept.deptno;

select ename, dname
from emp inner join dept
on emp.deptno = dept.deptno
where ename = 'SCOTT';

-- using(테이블명)사용하면 테이블명으로 이어서 출력
select ename, dname
from emp inner join dept
using(deptno);

-- natural join > 같은이름 매칭해서 바로 출력해준다.  > 단순 테이블 조인을 원하면 이것
select ename, dname
from emp natural join dept;

-- (3) Ansi Outer join
drop table dept01 purge;

create table dept01(
	deptno number(2),
	dename varchar2(14)
	
);

insert into dept01 values(10,'ACCOUNTS');
insert into dept01 values(20,'dwij');
create table dept02(
	deptno number(2),
	dename varchar2(14)
	
);

insert into dept02 values(10,'ACCOUNTS');
insert into dept02 values(30,'dwds');
select * from dept02;

-- 기존방법
select * from dept01, dept02
where dept01.deptno = dept02.deptno;

select * from dept01, dept02
where dept01.deptno = dept02.deptno(+);

select * from dept01, dept02
where dept01.deptno(+) = dept02.deptno;

select * from dept01, dept02
where dept01.deptno(+) = dept02.deptno(+);

-- ansi

select * from dept01 left outer join dept02
on dept01.deptno = dept02.deptno

select * from dept01 right outer join dept02
on dept01.deptno = dept02.deptno

select * from dept01 full outer join dept02
on dept01.deptno = dept02.deptno
