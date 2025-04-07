SELECT * FROM DBA_USERS;
SELECT * FROM TAB;

--  주석설정 
-- ctrl + / 한줄 주석
-- 데이터베이스 사용하기
-- 사용할 계정을 생성해야함 -> 관리자 계정에서만 가능하다.
-- CREATE USER 사용자명 IDENTIFIED BY 비밀번호 DEFAULT USERS QUOTA UNLIMITED ON USERS;
-- C##를 붙이지 않고 계정명 생성하기

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER CHUNJAE IDENTIFIED BY CHUNJAE DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 생성된 계정 확인하기
SELECT  * FROM DBA_USERS; -- 데이터베이스를 이용하는 사용자 정보 조회
-- 사용자계정이 DM를 이용할 수 있는 권한을 부여해야한다. -> 관리자계정(SYSTEM)
-- GRANT 권한명 || ROLE명 TO 사용자계정명
-- 접속권한(CONNECT) 부여하기
GRANT CONNECT TO CHUNJAE;

-- CHUNJAE 계정으로 실행
SELECT * FROM TAB;
CREATE TABLE TSET1(
   TEST_NAME VARCHAR2(20),
   TEST_AGE NUMBER
);

-- 저장소를 생성(RESOURCE) 할 수 있는 권한 부여
GRANT RESOURCE TO CHUNJAE;

-- 새로운 계정을 만들었을 때 계정에 대한 사용권한을 부여해야 한다.
-- 기본적으로 접속(CONNECT), 저장소생성(RESOURCE) 권한을 부여

-- BS/BS 계정을 생성하기
-- 이용까지 가능하게 할 것(접속, 저장소생성)
-- CREATE TABLE BASIC1(
--BASIC_ID NUMBER,
--BASIC_NAME VARCHAR2(20)
--)
-- SELECT * FROM TAB;
-- SELECT * FROM BASIC1;

-- 세션은 한번했으면 안해도된다. 닫으면 다시 실행해야한다.
CREATE USER BS IDENTIFIED BY BS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS; 
-- 위에를 실행할때에는 관리자 계정(system) 계정으로 실행한다.

GRANT CONNECT TO BS;
GRANT RESOURCE TO BS;
-- GRANT CONNECT,RESOURCE TO BS; 도 가능하다. -- 생성했을때 여기까지 기본 명령어

CREATE TABLE BASIC1(
    BASIC_ID NUMBER,
    BASIC_NAME VARCHAR2(20)
);

SELECT * FROM TAB;
SELECT * FROM BASIC1;

-- 실습용 DB생성하기
-- 실습용 테이블(저장소) 확인하기
SELECT * FROM TAB;

-- 사원관리 데이터
-- EMPLOYEE - > 사원정보를 저장한 테이블
SELECT *FROM EMPLOYEE;
-- DEPARTMENT -> 부서정보를 저장한 테이블
SELECT *FROM DEPARTMENT;
-- JOB -> 직책에 대한 정보를 저장한 테이블
SELECT * FROM JOB;
-- NATIONAL -> 지역의 국가정보를 저장한 테이블
SELECT * FROM NATIONAL;
-- LOCATION -> 부서의 지역정보를 저장한 테이블
SELECT * FROM LOCATION;
-- SAL_GRADE -> 급여수준에 대한 정보를 저장한 테이블
SELECT * FROM SAL_GRADE;

-- cloumn 과 row는 하나의 객체라고 생각을 하면 된다.

-- SELECT문 활용하기
-- 테이블에서 저장된 데이터(ROW)를 조회하는 명령어
-- SELECT 컬럼명,컬럼명1,컬럼명2..... OR *(전체컬럼)
-- FROM테이블형



--EMPLOYEE 테이블의 전체 데이터 조회하기

SELECT * 
-- 띄워쓰기 한칸 꼭 하기
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 특정컬럼의 데이터만 조회하기
-- 사원명,급여, 보너스,고용일

SELECT EMP_NAME, SALARY, BOUNUS, HIRE_DATE
FROM EMPLOYEE;

-- DEPARTMENT테이블에 있는 전체 데이터 조회하기

-- JOB테이블에 저장된 직책명 조회하기

SELECT * FROM department;

-- JOB테이블에 저장된 직책명 조회하기;

SELECT JOB_NAME  FROM JOB;

-- SELECT문을 이용해서 연산처리하기
-- 산출연산(+,-,*,.)

SELECT JOB_NAME, 10+10 FROM JOB;    
SELECT 10+2,10-3,3*4,10/4 FROM JOB;

-- 오라클에서 테스트용 테이블 제공
-- Dual 테이블
SELECT 10+4, 10-20, 5*10, 6/3 FROM DUAL;

-- 산술연산을 테이블의 특정컬럼 값과 같이 하기
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME,SALARY +1000 FROM EMPLOYEE; -- 실제로 존재하지 않는 값

-- 사원의 연봉을 조회하는 구문작성
-- 사원번호, 사원명, 급여, 연봉

SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 FROM EMPLOYEE;
-- 사원이 받는 보너스 금액 출력하기
-- 사원번호 사원명 급여 보너스 보너스 금액
-- NULL값을 다른 값으로 대체해주는 함수 -> NULL(컬럼명,대체값)

SELECT EMP_ID,EMP_NAME,SALARY,NVL(BONUS,0),SALARY*NVL(BONUS,0) FROM EMPLOYEE;

-- SELECT 문에 리터럴값 작성하기
-- 숫자 : 10,20, 180, 65.5
-- 문자열 : '문자열' -> "안됨" 문자열은 반드시 작은 따음표하게 사용
-- 날짜 : 'YY/MM/DD'
SELECT '우와','4113','djiJ','130.4','25/03/27' FROM DUAL;

-- 리터럴간 연산처리하기
-- 문자열+문자열, 숫자 + 문자열 -> 수치로 계산할 사용할 수 없다!
SELECT '오라클' + '도전중' FROM DUAL;

SELECT 10 +'오라클' FROM DUAL;

-- 문자열 결합은 어떻게 할까? -> 연산자, 함수
-- || : 문자열을 결합해주는 연산자

SELECT '오라클'||' 1일차' FROM DUAL;

-- 리터럴과 컬럼 연산하기
SELECT EMP_NAME||'님', SALARY || '원' FROM EMPLOYEE;


--EMPLOYEE 테이블에서 사원명, 부서코드, 월급, 연봉(보너스 금액을 포함)을 조회

SELECT EMP_NAME, DEPT_CODE, SALARY, (SALARY + SALARY*NVL(BONUS,0))*12 || '원' FROM EMPLOYEE;

--SELECT 문에서 작성하는 컬럼은 테이블에 있는 컬러만 가능하다.

-- RESULT SET 컬럼에 별칭 부여하기
-- AS 예약어를 이용 , 띄워쓰기 이용

SELECT EMP_NAME AS 이름, SALARY AS 급여 ,DEPT_CODE AS부서코드 FROM EMPLOYEE;
SELECT EMP_NAME 이름, SALARY  급여, DEPT_CODE 부서코드 FROM EMPLOYEE;
SELECT EMP_NAME 이름, SALARY 급여, DEPT_부서코드 FROM EMPLOYEE;

-- 별칭에 띄워쓰기, 특수기호 사용가능할까
-- ""를 사용하면 가능함
SELECT EMP_NAME AS "이 름", SALARY * 12 AS YEAR_SAL FROM EMPLOYEE;

-- DISTINCT 예약어 사용하기
-- 조회된 컬럼값의 중복을 제거 

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- 두번째 컬럼 위치에 작성하기 -> 불가능,첫번째에 작성해야한다.
-- SELECT EMP_NAME,DISTINCT DEPT_CODE FROM EMPLOYEE;
-- DISTINCT예약어 뒤에 선언한 컬럼은 AND연산을 묶어서 처리
SELECT DISTINCT DEPT_CODE,  EMP_NAME FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;

-- 사원에게 부여된 부서수 구하기
-- SELECT COUNT(*) FROM (SELECT DISTINCT DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE IS NOT NULL);
-- 사원들에게 부여된 부서명 구하기
-- SELECT DEPT_TITLE FROM DEPARTMENT 
-- WHERE DEPT_ID NOT IN(SELECT DISTINCT DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE IS NOT NULL); 

-- 원하는 ROW 가져오기
--WHERE 절을 사용
-- SELECT 컬럼명
-- FROM 테일블명
-- WHIERE 조건식("TRUE,FALSE)
-- 비교연산
-- 동등비교 = =, *< ,/,>,<
-- 대소비교 >=,=<,M
-- 논리연산(AND,OR)
-- BETWEEN AND : 범위 설정
-- LIKE/ NOT LIKE : 문자열 패턴을 비교
-- is Null / IS NOT NULL: NULL값 비교
-- IN/ OUT IN : 다수 값을 한번에 비교(OR 동등비교)

-- 부서가 D5인 사원의 전체 컬럼 조회하기
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

-- 급여가 300만원 이상인 사원의 사원명,이메일,급여를 조회하기

SELECT EMP_NAME, EMAIL, SALARY
FROM EMPLOYEE
WHERE SALARY >=3000000;

-- 사원 중 직책코드가 J2가 아닌 사원의 사원번호, 사원명,직책코드 조회

SELECT EMP_ID,EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE != 'J2';
-- 컬럼값은 대소문자 구분함 j2로 하게 되면 J2도 나오게 된다.
-- 컬럼명,테이블명은 구분하지 않음
select emp_id, emp_name, job_code
from employee
where job_code ='J2';

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE <> 'J2';

-- 날짜값에 대한 대소비교하기
-- 'YY/MM/DD'
-- 00/01/01이후 입사자 조회하기

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE>'00/01/01';

-- 논리연산자 활용하기
-- 사원 중 부서가 D5이고 급여가 300만원이상인 사원의 사원명,부서코드 , 급여를 조회하기

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY >=3000000; -- &&이거는 없습니다.

-- 사원 중 직책이 J7이거나 J6인 사원의 사원명,이메일,직책코드 조회하기

SELECT EMP_NAME,EMAIL,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE ='J7' OR JOB_CODE='J6';

-- 사원 중 급여를 200만원 이상 300만원이하로 받고 있는 사원의 사원명,급여,보너스,입사일

SELECT EMP_NAME, SALARY, NVL(BONUS,0), HIRE_DATE
FROM EMPLOYEE
WHERE 2000000<= SALARY AND SALARY<=3000000;

-- 특정 범위를 조회할때는 BETWEEN AND 연산을 이용
-- WHERE 컬럼명 BETWEEN 값 AND 값

SELECT EMP_NAME, BONUS,SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000;

-- 00/01/01 부터 02/12/31 사이에 입사한 사원 조회하기
-- 사원명, 입사일 

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '00/01/01' AND '02/12/31';


alter session set "_ORACLE_SCRPIT"=TRUE;
DROP USER SCOTT CASCADE
CREATE USER SCOTT IDENTIFIED BY SCOTT DEFAULT TABLESPACE USER QUOTA UNLIMITED ON USERS;
GRANT CONNECT, RESOURCE TO SCOTT;

