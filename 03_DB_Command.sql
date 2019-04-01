-- * 오라클 명령어 : select 문(검색)

-- [1] scott 사용자가 관리하는 테이블 목록
select * from tab;

--[2] 특정 테이블의 구조 (필드 리스트/ 데이터 형식/ 제약조건)
desc dept; --dos command 창에서 확인.

--[3] 특정 테이블의 data 표시
select * from dept;
select * from emp;

-- [4] 모든 컬럼(필드명)이 아닌, 필요한 컬럼(필드명) 내용만 출력
select dname, loc from dept

-- [5] 각각의 필드명에 별칭을 부여해서 출력
select deptno as 부서번호,dname as 부서명, loc as 위치 from dept;

select deptno 부서번호, dname 부서명, loc 위치 from dept;

-- 주의
select deptno 부서 번호, dname 부서명, loc 위치 from dept; - error
select deptno "부서 번호", dname "부서명", loc "위치" from dept;
-- 명칭을 붙일떄 "" 을 붙여 부여하는게 에러회피하기 좋다.

--[6] 사원들의 직업명을 중복 제거후 출력
select * from emp;
select distinct job from emp; -- 중복제거 명령어 distinct

--[7] 급여가 3000 이상인 사원정보 출력 // 조건절 where 조건
select empno, ename, sal from emp where SAL>=3000;

--[8] 이름이 scott 사원의 정보 출력
select * from emp where ename = 'SCOTT';
-- 데이터는 대소문자구분

--[9] 1985년도 이후로 입사한 사원정보

select empno, ename, hiredate from emp where hiredate >= '1985-01-01'

--[10] 부서번호가 10이고 그리고 직업이 'MANAGER'인 사원 출력
select * from emp where deptno = 10 or job = 'MANAGER'
select * from emp where deptno = 10 and job = 'MANAGER'

--[12] 부서번호가 10이 아닌 사원
select * from emp where not (deptno = 10)
select * from emp where deptno <> 10

--[13] 급여가 1000 ~3000
select * from emp where sal >= 1000 and sal <= 3000
select * from emp where sal between 1000 and 3000
-- [14] 급여가 1300 또는 1500 또는 1600인 사원 정보출력
select * from emp where sal in (1300,1500,1600)
--[15] 이름이 'K'로 시자가는 사원 출력
select empno, ename from emp where ename like 'K%'

--[16] 이름이 'k'로 끝나는 사원 출력
select empno, ename from emp where ename like '%K'

--[17] 이름이 'K'가 포함된 경우
select empno, ename from emp where ename like '%K%'

--[18] 2번째 자리에 'A'가 포함된 경우
select empno, ename from emp where ename like '_A%'

-- [19] 커미션을 받지 않는 사원 출력
select * from emp where comm is null or comm = 0;

-- [20] 커미션을 받는 사원 출력
select empno, ename, comm from emp 
where comm is not  null or comm <> 0;

-- [21] 사번의 정렬(오름차순)
select empno, ename, comm from emp 
order by empno asc;-- asc생략가능

-- [21] 사번의 정렬(내림차순)
select empno, ename, comm from emp 
order by empno desc;

-- [22] 사원의 연볼 출력
select ename, sal, sal*12 as "연봉" from emp;

-- [24] 커미션을 포함한 최종 사원의 원봉 출력
select ename, sal, sal*12+comm from emp;

-- [25] [24]의 오류 해결법
select ename, sal, sal*12 + nvl(comm, 0) as "연봉" from emp;

