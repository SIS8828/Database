-- 서브쿼리(Sub-Query)

-- .SQL>:Structured Query Language
-- . Sub-Query: 하나의 select문장의 절 안에 포함된 또 하나의 select문
-- .메인쿼리/ 서브쿼리
-- 서브쿼리는 비교 연산자의 오른쪽에 기술해야 되고, 반드시 괄호로 둘러 쌓아야 한다.
-- 단일형 서브쿼리/ 다중형 서브쿼리

select deptno from emp
where ename = 'SCOTT'

select dname, loc from dept
where deptno = 20

select dname, loc from dept
where deptno = (select deptno from emp
						where ename = 'SCOTT');

--[예제] scott과 동일한 직급(job)를 가진 사원을 출력하는 sql문을 서브쿼리 사용
						
select ename,job from emp
where job = (select job from EMP
					where ename = 'SCOTT') ;

--[예제] scott의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여를 출력
					
select ename, sal from emp
where sal >= (select sal from emp where ename = 'SCOTT');

-- [서브쿼리&그룹함수]
-- ex) 전체 사원 평균 급여보다 더 많은 급여를 받는 사원을 출력하세요
select ename, sal from emp where sal > (select avg(sal) from emp);

--[다중행 서브쿼리[
-- ex) 급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원들의 정보를 추력
select ename, sal, deptno 
from emp 
where deptno = (select deptno 
						from emp 
						where sal >= 3000); --error

select ename from emp where sal >= 3000;

-- (1) [in 연산자]
--		: 메인 쿼리의 비교조건 ('=' 연산자로 비교할 경우)이 서브쿼리의
--		결과 중에서 하나라도 일치하면 참이다.
select ename, sal, deptno 
from emp 
where deptno in (select deptno 
						from emp 
						where sal >= 3000);

-- in연산자를 사용하여 부서별로 가장 급여를 많이 받는 사원의 정보를 출력
-- 사원번호, 사원명, 급여, 부서
select * from EMP;

select empno, ename, sal, deptno from emp 
where sal in (select max(sal) from emp
					group by deptno);
-- (2) all 연산자
-- .		메인 쿼리의 비교 조건이 서브쿼리의 검색결과와 모든 값이 일치하면 참이다.
--			찾아진 값에대해서 and 연산을 해서 모두 참이면 참이되는 셈이된다.
--			>all은 '모든 비교값보다 크냐?'라고 물어보는 것이 되므로 최대값보다 더 크면 참이된다.

-- ex) 30번(부서번호) 소숙 사원들 중에서 급여를 가장 많이 받는 사원보다
--		더 많은 급여를 받는 사원의 이름과 급여를 출력하세요
select ename, sal from emp 
where sal > ALL (select max(sal)
						from EMP
						where deptno = 30);
					
-- (3) [any 연산자]
-- 		.any 조건은 메인쿼리의 비교 조건이 서브쿼리의 검색 결과와 하나
--	  	이상만 일치하면 참이다.
--		> any는 찾아진 값에 대해서 하나라도 크면 참이된다.
--		그러므로 찾아진 값에서 가장 작은 값, 즉 최소값보다 더 크면 참이 된다.

-- ex) 30번(부서번호) 소숙 사원들 중에서 급여가 가장 낮은 급여보다
--		더 많은 급여를 받는 사원의 이름과 급여를 출력하세요
select ename, sal
from EMP where sal > ANY ( select sal
									from emp
									where deptno = 30);
									
select ename, sal
from EMP where sal >  ( select min(sal)
									from emp
									where deptno = 30);
									
-- 영원사원들(Salesman)들보다 급여를 많이 받는 사원들의 이름과 급여를 출력하되
									-- 영업사원은 출력하지 않게 명령문

select ename, sal from emp 
where sal > ALL (select sal
					from emp
					where deptno = 30) and deptno <> 30;
					
-- 영업 사원들의 최소 급여보다 많이 받는 사원들의 이름과 금여와 직급을 출력하되 영업사원은 c출력 x
select ename, sal
from EMP where sal > ANY ( select sal
									from emp
									where deptno = 30) and deptno <> 30;
									
select * from emp;
select * from dept;
