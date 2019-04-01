-- * 오라클 : 인덱스(index)
--     - 조회를 빠르게(빠른 검색)하도록 도와줌.
--     - sql 명령문의 처리 속도를 향상시키기 위해서 컬럼에 
--       생성하는 오라클 객체.

--     - 장점
--        . 검색 속도가 빨라진다.
--        . 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을
--          향상시킨다.
--     - 단점
--        . 인덱스를 위한 추가적인 공간이 필요하다.
--        . 인덱스를 생성하는데 시간이 걸린다.
--        . 데이터의 변경 작업(insert/update/delete)이 자주
--          일어날 경우에는 오히려 성능이 떨어진다.

-- [1] 인덱스 정보 조회
select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP','DEPT')

--[2] 조회속도 비교하기
--		. 사원 테이블 복사하기
-- 무결성제약조거때문에 기본키복사는 되지않는다.
drop table emp01 purge;
create table emp01
as
select * from emp;

select * from emp01;

select table_name, index_name, column_name
from user_ind_columns
where table_name in ('EMP','EMP01')

-- cmd 창에서 실행
insert into emp01 select * from emp01

insert into emp01 (empno,ename)
values(8010,'ANGEL');

SQL > set timing on 

--[3] 인덱스 생성
--		: 기본키나 유일키가 아닌 컬럼에대해서 인덱스를 지정하려먼
--		create index 명령어를 사용

create index idx_emp01_ename
on emp01(ename);

select table_name, index_name, column_name
from user_ind_columns
where table_name in ('EMP01')

commit;

drop table emp01;
purge recyclebin;

