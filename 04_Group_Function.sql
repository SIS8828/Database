--* 오라클 명령어 : Group 함수

-- sum() : 합계
select sum(sal) "총급여" from emp;

-- count(): 카운트
select count(*) "사원수" from emp;

-- avg() 평균
select avg(sal) "평균급여" from emp;

--max(), min()
select max(sal) "높은 급여" from emp;
select min(sal) "낮은 급여" from emp;

select distinct job from emp;
select job, avg(sal) from emp group by job; 

-- Having 절 : 직업별 급여 평균( 단, 급여 평균 2000이상 직업)
select job,avg(sal) from emp
group by job
having avg(sal) >= 2000;
