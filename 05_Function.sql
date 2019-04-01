--* 오라클 명령어: 

-- [1] 샘플 테이블인 dual 테이블
select * from dept;
select * from friend;
select * from tab;
select * from dual;

--[2] 임시 데이터 출력
select sal*12+nvl(comm,0) "연봉" from emp;
select 1234*1234 "곱셈" from dual;
--특정테이블을 만들고 싶을떄 dual이라는 가상의 테이블을 사용하면된다.

--[3] lower() : 모든 문자를 소문자로 변환.
--     upper() : 대문자로 변환
--     initcap(): 첫글자를 대문자로 변환
select lower('HONG GIL DONG') as "소문자" from dual;
select upper('hong gil dong') as "대문자" from dual;
select initcap('HONG GIL DONG') as "첫대문자" from dual;

-- [4] concat(): 문자열 연결
select concat('더조은',' IT아카데미') from dual;

--[5] length() : 문자열의 길이
select length('더조은IT아카데미'), length('더조은아이티아카데미') from dual;

--[6] substr(데이터, 인덱스(1), 카운트): 문자열 추출
select substr('더조은아이티아카데미',3,4) from dual;

-- [7] instr(): 문자열 시작 위치
select instr('홍길동 만세','동') from dual;

-- [8] lpad(),rpad() : 자리채우기
select lpad('Oracle',20,'#') from dual; -- 앞으로채우기 ''으로 처리하면 빈값으로 처리
select rpad('Oracle',20,'#') from dual; -- 뒤로 채우기

-- [9] trim(): 컬럼이나 대상 문자열에서 특정 문자가 첫번쨰 글자이거나 마지막글자이면 잘라내고 남은 문자열만 반환
select trim('u' from 'uuuuuuduuuuu') from dual;
select trim(' ' from ' dsdwd dsd ') from dual;

-- ** 수식 처리 관련 함수 

-- [12] round(값, 숫자(음수,양수) ): 반ㅇ올림(음수: 소수점 이상 자리)
select round(12.3456 ,3 ) from dual;

select deptno, sal, round(sal, -3) from emp
where deptno = 30;

--[13] abs() : 절대값반환
select ab(-10) from dual;

--[14] floor() : 소수자리 버리기
select floor(12.23425) from dual;

--[15] trunc(): 특정자리 버리기
select trunc(12456,-2) from dual;
select trunc(12456.125456789,2) from dual;

--[16] mod(): 나머지
select mod(8, 5 ) from dual;

-- ** 날짜 처리관련 함수

--[17] sysdate : 날짜
select sysdate from dual;

-- 날짜 포맷 출력 변경
alter session set nis_date_format = 'yyyy/mm/dd hh24:mi:ss';
-- system 으로 접속해서 이렇게 설정하면 다음부터 이렇게 나온다.

-- [18] months_between(): 개월수 구하기
select ename, hiredate, trunc(months_between(sysdate, hiredate),-1) "입사경과개월수" from emp
where deptno = 10;

--[19] add_months(): 개월수 더하기
select add_months (sysdate, 200) from dual;

--[20] next_day() : 다가올 요일에 해당하는 날자
select next_day(sysdate, '일요일') from dual;

--[21] last_day(): 해달달의 마지막날짜
select last_day(sysdate) from dual;

--[22] to_char() :  문자열로 바꿔서 반환
select to_char(sysdate,'yyyy-mm-dd') from dual;

--[23] to_date(): 날짜형(date)로 변환
select to_date('2009/12/31','yyyy/mm/dd') from dual;

--[24] nvl() : NULL인 데이터를 다른 데이터로 변경.
select ename, comm, nvl(comm, 0) from emp;

--[25] decode() : switch문과 같은 기능
select ename, deptno, decode(deptno,
											10, 'ACCOUNT',
											20, 'Research',
											30, 'SALES',
											40, 'operations') "부서명"
from emp;

--[26] case(): if ~ else if~
select ename, deptno, 
		case when deptno = 10 then 'AACOUNT'
				when deptno = 20 then 'research'
				when deptno = 30 then 'sales'
				when deptno = 40 then 'operations'
		end "부서명"
from emp;
