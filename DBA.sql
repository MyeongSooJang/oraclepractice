SELECT * FROM DBA_USER;
SELECT * FROM TAB;
-- 주석설정 
-- CTRL+/ 한줄주석 
-- 데이터베이스 사용하기
-- 사용할 계정을 생성해야함 -> 관리자 계정에서만 가능
-- CREATE USER 사용자명 IDENTIFIED BY 비밀번호 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- C##를 붙이지말고 계정명 생성하기 
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER SCOTT IDENTIFIED BY SCOTT DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 생성된 계정 확인하기
SELECT * FROM DBA_USERS; -- 데이터베이스를 이용하는 사용자 정보를 조회 
-- 사용자계정이 DB를 이용할 수 있는 권한을 부여해야 한다. --> 관리자 계정 (SYSTEM)
--GRANT 권한명 / ROLE명 TO 사용자계정명 
--접속권한(CONNECT) 부여하기
GRANT CONNECT TO SCOTT;

-- CHUNJAE 계정으로 실행 
SELECT * FROM TAB;
CREATE TABLE TEST1 (
   TEST_NAME VARCHAR2(20),
   TEST_AGE NUMBER
);
--저장소를 생성(RESOURCE) 할 수 있는 권한 부여
GRANT RESOURCE TO SCOTT;

--새로운 계정을 만들었을때 계정에 대한 사용권한을 부여해야 한다.
--기본적으로 접속(CONNECT),저장소생성(RESOURCE)권한을 부여 

--BS/BS 계정을 생성하기 
--이용까지 가능하게 할 것 (접속,저장소 생성)
--CREATE TABLE BASIC1(
--BASIC_NAME VARCHAR(20)
--);
--SELECT * FROM TAB;
--SELECT * FROM BASIC1;

--실습용 BS계정 만들기 
CREATE USER BS IDENTIFIED BY BS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
--생성된 계정 권한 부여 
GRANT CONNECT, RESOURCE TO BS;

CREATE TABLE BASIC1(
   BASIC_NAME VARCHAR(20)
   );

   SELECT * FROM TAB;
   SELECT * FROM BASIC1;
   

-- 실습용 DB생성하기 
--실습용 테이블(저장소) 확인하기
SELECT * FROM TAB;
--사원관리 데이터
--EMPLOYEE -> 사원정보를 저장한 테이블 
SELECT * FROM EMPLOYEE;
--DEPARTMENT -> 부서정보를 저장한 테이블 
SELECT * FROM DEPARTMENT;
--JOB -> 직책에 대한 정보를 저장한 테이블 
SELECT * FROM JOB;
--NATIONAL -> 지역의 국가정보를 저장한 테이블 
SELECT * FROM NATIONAL; 
--SAL_GRADE -> 급여수준에 대한 정보를 저장한 테이블 
SELECT * FROM SAL_GRADE;

--SELCECT문 활용하기 
--테이블에 저장된 데이터(ROW)를 조회하는 명령허 
--SELECT 컬럼명 , 컬럼명1,컬럼명2.. OR * (전체컬럼)
--FROM 테이블명 

--EMPLYOEEEE의 테이블의 전체 데이터 조회하기 
SELECT*
FROM EMPLOYEE;

SELECT EMP_NAME,SALARY,BONUS,HIRE_DATE
FROM EMPLOYEE;

--DEPARTMENT테이블에 있는 전체 데이터 조회하기 
SELECT * FROM DEPARTMENT;
--JOB테이블에 저장된 직챙명 조회하기
SELECT JOB_NAME FROM JOB;

--SELECT 문을 이용해서 연산처리하기 
--산술연산(+,-,,/)
SELECT JOB_NAME, 10+10 FROM JOB;
SELECT 10+2,10-3,34,10/4 FROM JOB;

--오라클에서 테스트용 테이블 제공
--DUAL테이블
SELECT 10+4,10-20,5*10,6/3 FROM DUAL;

--산술연산을 테이블의 특정 컬럼과 같이 하기 
SELECT EMP_NAME,SALARY+1000 FROM EMPLOYEE;

--사원의 연봉을 조회하는 구문 작성하기 
--사원번호, 사원명, 급여, 연봉 조회하기 
SELECT EMP_ID,EMP_NAME,SALARY,SALARY*12 FROM EMPLOYEE;

--사원이 받는 보너스 금액 출력하기 
--사원번호 사원명 급여 보너스 보너스 금액 
--NULL값을 다른값으로 대체해주는 함수 -> NVL(컬럼명,대체값)
SELECT EMP_ID,EMP_NAME,SALARY,NVL(BONUS,0),SALARY*NVL(BONUS,0) FROM EMPLOYEE;

--SELECT문에 리터럴값 작성하기 
--숫자:10,20,180.5,65.65
--문자열 : '문자열' -> "안됌!" 문자열은 반드시 홀따움표 사용
--날짜 : 'YY/MM/DD'
SELECT '우와','가','abCDE',10,20,180.5,65.5,'25/03/27' FROM DUAL;

-- 리터럴간 연산처리하기 
--문자열+문자열,숫자+문자열 -> 수치로 계산함. 사용할 수 없다! 
SELECT '오라클'+'너무너무 쉽다' FROM DUAL;
SELECT 10+'오라클' FROM DUAL;

-- 문자열 결합은 어떻게 할까?  -> 연산자, 함수 
-- //:문자열을 결합해주는 연산자 
SELECT '오라클'||'너무너무쉽다' FROM DUAL;

-- 리터럴과 컬럼 연산하기 
SELECT EMP_NAME||'님',SALARY||'원' FROM EMPLOYEE;

--EMPLOYEE테이블에서 사원명,부서코드,월급,연봉(보너스금액을 포함)을 조회 
SELECT EMP_NAME,DEPT_CODE,SALARY,(SALARY+SALARYNVL(BONUS,0))*12 FROM EMPLOYEE;

--SELECT문에 작성하는 컬럼은 테이브에 있는 컬럼만 가능하다.
SELECT DEPT_TITLE FROM EMPLOYEE;

--RESULT SET 컬럼에 별칭 부여하기 
--AS 예약어를 이용, 띄어쓰기 이용 
SELECT EMP_NAME AS 이름,SALARY AS 급여,DEPT_CODE AS 부서코드 FROM EMPLOYEE;
SELECT EMP_NAME 이름, SALARY 급여, DEPT_CODE 부서코드 FROM EMPLOYEE;

--별칭에 띄어쓰기, 특수기호 사용가능할까 
--""을 사용하면 가능함.
SELECT EMP_NAME AS  "이 름",SALARY*12 AS YEAR_SAL  FROM EMPLOYEE;

--DISTINCT 예약어 사용하기 
--조회된 컬럼값의 중복을 제거 
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

--DISTINCT 두번째 커럼위치에 작성하기 -> 불가능, 첫번째에 작성해야한다.
--SELECT EMP_NAME,DISTICTY DEPT_CODE FROM EMPLOYEE;

--DISTINCT 예약어 뒤에 선언한 칼럼은  AND연산을 묶어서 처리 
SELECT EMP_NAME,DISTICTY DEPT_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE,JOB_CODE FROM EMPLOYEE;

--SELECT COUNT(*) FROM (SELECT DISTINCT DEFT_CODE FROM EMPLOYEE

--원하는 ROW가져오기
--WHETE 절을 사용 
--SELECT 컬럼명
--FROM 테이블명
--WHERE 조건식 (TRUE,FALSE)
--비교연산
--동등비교 : =,!=, <>=
--대소비교 : >= , <=, >, <
--논리연산 : AND(&&),OR(||)
--BETWEEN AND : 범위설정 
--LIKE / NOT LIKE : 문자열 패턴을 비교 
--IS NULL / IS NOT NULL : NULL값 비교 
--IN / NOT IN : 다수 값을 한번에 비교 (OR로 동등비교)

--부서가 D5인 사원의 전체 칼럼 조회하기 .
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

--급여가 300만원이상인 사원의 사원명,이메일,급여를 조회하기 
SELECT EMP_NAME,EMAIL,SALARY
FROM EMPLOYEE
WHERE SALARY>=3000000;

--사원중 직책코드가 J2가 아닌 사원의 사원번호 사원명, 직책코드를 조회 
SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE!='J2'; --컬럼값은 대소문자 구분함 / 컬럼명, 테이블명은 구분하지 않음 
select emp_id,emp_name,job_code
from employee
where job_code!='J2';

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE <> 'J2';

--날짜값에 대한 대소비교하기
--'YY/MM/DD'
--00/01/02 이후 입사자 조회하기 
SELECT EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE>'00/01/01';

--논리연산자 활용하기 
--사원 중 부서가 D5이고 급여가 300만원이상인 사원의 사원명,부서코드,급여 조회하기 
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY>=3000000;

--사원 중 직책이 J7이거나 J6인 사원의 사원명, 이메일, 직책코드 조회하기 
SELECT EMP_NAME,EMAIL,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J7'OR JOB_CODE='J6';

--사원 중 급여를 200만원이상 300만원이하로 받고 있는 사원
-- 사원명, 급여,보너스,입사일 조회\
SELECT EMP_NAME,SALARY,BONUS,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY>=2000000 AND SALARY<=3000000;

--특정 범위를 조회할때는 BETWEEN AND 연산을 이용
--WHERE 컬럼명 BETWEEN 값 AND 값
SELECT EMP_NAME,BONUS,SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000;

--00/01/01부터 02/12/31 사이에 입사한 사원 조회하기 
--사원명, 입사일 
SELECT EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '00/01/01' AND '02/12/31';

--LIKE 연산자 이용하기 
--문자열의 패턴을 검색하는 연산자 
--패턴을 표시하는 기호 
--% : 문자가 0개 이상 있다는 표시 
--'%강' : 강으로 끝나는 문자열 -> 한강 O 두만강 O 강 O 한강공원 X 두강강 O 
--'한%' : 한으로 시작하는 문자열 -> 한강 O 한국 O 대한민국 X 
--'%병%' : 병을 포함한 문자열 -> 병 O 한병 O 병승 O 유병승 O 
--_  : 문자가 1개 있다는 표시 
--'강':강으로 끝나는 두글자 
--'한':한으로 시작하는 두글자 

--'_강%' : 두글자 이상 , 두번째 글자가 강인 문자열 

--WHERE 컬럼명 LIKE '문자열 패턴';

--유씨 성을 가진 사원을 조회하기 
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '유_%';

--이메일에 yo가 포함된 사원 조회하기 
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%yo%';

--이메일에 j가 포함되고 유씨성을 가진 사원 조회하기 
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%j%' AND EMP_NAME LIKE '유__';

--LIKE절 부정하기 
--NOT LIKE 
--유씨성이 아닌 사원들 출력하기 
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '유%';

--사원 중 이메일주소의 문 앞이 3글자인 사원 조회하기 
--ESCAPE 처리하기 
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___!%'ESCAPE'!';

--SELECT*
--FROM EMPLOYEE
--WHERE EMAIL LIKE '%'||'y'||'%';

--NULL값 처리하기 
--NULL값은 아무 의미 없는 값 -> 연산처리가 불가능 
--NULL값을 조회할때 동등비교 불가능 , 불일지 비교 불가능 
--IS NULL, IS NOT NULL 을 이용해서 비교 
--부서없는 사원조회하기 
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

-- 보너스를 받는 사원만 조회하기 
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NOT NULL AND SALARY>=3000000;

--다수값을 동등비교할때 연산자 
--다수값을 OR연산으로 동등비교 
--IN(값,값2,값3) -> =값 OR  = 값 1 OR = 값2 
--WHERE 컬럼명 IN (값,값.....) WHERE 컬럼명 IN (SELECT문)

--사원 중 부서가 D5,D6,D8인 사원의 사원명, 부서코드 조회 
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D8');

--NOT IN 사용하기 
SELECT EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D5','D6','D8');

--논리연산 사용시 주의 
--직책이 J7이거나 J2인 사원 중 급여가 280만원 이상인 사원 조회하기 
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7','J2') AND SALARY>=2800000;

--오라클에서 제공하는 함수 이용하기 
--단일행 함수 : 조회된 ROW 전체에 대해 각각 실행하는 함수 -> 결과가 ROW만큼 출력 
--그룹함수 : 조회된 ROW전체에 대해 한개의 결과를 반환하는 함수 -> 집계 (평균,합계,최대값,최소값,갯수(ROW수))

--단일행 함수 이용하기 
--단일행 함수를 선언하는 위치 
--1.SELCET문의 컬럼을 작성하는 위치 
--2. SELECT문의  WHERE절 
--3. INSERT, UPDATE,DELETE문에서도 작성이 가능 

--데이터베이스에 값을 저장할때 타입이 있음 
--문자열 : VARCHAR2 
-- 숫자 : NUMBER(정수,실수 모두 저장)
-- 날짜 : DATE,TIMESTAMP 
 
 
 
 ------------------- 3월 31일(월)---------------------------
 
 
 
--  문자열 함수 -> java의 String 메소드와 유사하다

-- 문자열의 길이를 알려주는 함수 : LENGTH(문자열 또는 컬럼명)

SELECT LENGTH('오늘은 월요일') FROM DUAL;
SELECT EMAIL, LENGTH(EMAIL) FROM EMPLOYEE; 
-- EMAIL 다음 할때 쉼표를 해주어야 한다.

-- 이메일주소의 길이가 15이상인 사원의 사원명 이메일 조회하기
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE LENGTH(EMAIL)>=15;

-- 지정문자에서 특정문자의 인덱스번호를 반환해주는 함수 : INSTR(문자열 또는 컬럼명, 찾을 문자) --> JAVA의 INDEXOF() 메소드와 유사
-- 문자열의 인덱스번호가 1부터 시작

SELECT INSTR('천재교육','천재'), INSTR('천재교육' , '교') FROM DUAL;
-- 다른함수와 같이 사용

SELECT INSTR(EMAIL,'@') FROM EMPLOYEE;
-- FROM 전에 쉼표 붙이면 오류가 남


-- INSTR(문자열 또는 컬러명, 찾을문자, 시작위치, 찾을 횟수)
SELECT INSTR('천재IT교육센터 천재교육초등개발부 천재교육본사','천재'),
            INSTR('천재IT교육센터 천재교육초등개발부 천재교육본사','천재',2),
            INSTR('천재IT교육센터 천재교육초등개발부 천재교육본사','천재',2,2),
            INSTR('천재IT교육센터 천재교육초등개발부 천재교육본사','천재',-2,2),
            INSTR('천재IT교육센터 천재교육초등개발부 천재교육본사','병승')
FROM DUAL;

-- 이메일에서 Y를 포함하고 있는 사원의 사원명과 이메일, Y의 위치값을 조회하기

SELECT EMP_NAME, EMAIL, INSTR(EMAIL,'y')
FROM EMPLOYEE
WHERE INSTR(EMAIL,'y') !=0;
--WHERE EMAIL LIKE '%y%';

-- 특정 공간을 정하고 그공간에 데이터가 없을 때 지정한 값으로 채우는 함수
-- LPAD /RPAD (대상문자열, 전체공간, 대체 문자열)
-- 전체공간 -> BYTE로 설정
-- 한글은 2BYTE, 영어, 숫자 1BYTE

SELECT LPAD('오늘월요일',14,'X'),RPAD('오늘월요일',14,'X')
    ,LPAD('유병승',10,' ') AS NAME
FROM DUAL;

-- 문자열의 좌우에 있는 특정문구, 공백을 제거해주는 함수 : 
-- LTRIM, RTRIM(대상문자열, [문자])
-- 두번째 매개변수가 없으면 공백을 제거 한다.

SELECT '                   월요일 힘냅시다!',
    LTRIM('                   월요일 힘냅시다!'),
  '월요일 힘냅시다!                   ',
    RTRIM('월요일 힘냅시다!                   '),
    'AAAAABBBBBCCCCC월요일도 화이팅!',
    LTRIM('AAAAABBBBBCCCCC월요일도 화이팅!','A'),
    LTRIM('AAAAABBBBBCCCCC월요일도 화이팅!','B') 
    -- 처음 부터 B가 아니므로 B가 지워지지 않고 출력이 된다.
FROM DUAL;

SELECT
     LTRIM('AAAbAABBBBBCCCCC월요일도 화이팅!','A'),
     -- 나머지 A가 뒤에 있더라도 b가 중간에 있으면 그만 지우게 된다.
     LTRIM('AAAbAABBBBBCCCCC월요일도 화이팅!','Ab'),
     -- Ab로 하게 되면 or로 묶이게 되기 때문에 b를 만나도 지워지게 된다.
     LTRIM('AAAbAABBBBBCCCCC월요일도 화이팅!','AbBC'),
     -- 원하는 문자를 제거 하려면 다 넣어주게 된다.
     RTRIM('월요일 화이팅!AAAABBBBCCCCC','C'),
     RTRIM('월요일 화이팅!A AAABBBBCCCCC','ABC'),
     -- 공백이 있으면 멈추게 된다. 자바에서 FALSE가 나오는 것과 비슷하다.
     'AAAAAABBBBBBBBCCCCCC우와 재밌다AAAAAAAABBBBCCCC',
     RTRIM(LTRIM('AAAAAABBBBBBBBCCCCCC우와 재밌다AAAAAAAABBBBCCCCEEEEE','A'),'E')
FROM DUAL;
 
 
 -- 1232232132132321321321321화이팅!13212332132131312321312321312313
 -- 화이팅만 출력하기
 
 SELECT RTRIM(LTRIM('1232232132132321321321321화이팅!13212332132131312321312321312313','123'),'123')
 FROM DUAL;
 
 -- 양쪽의 공백, 문자를 제거하는 함수 : 
 -- TRIM(대상문자열) --> 문자열 좌우 공백을 제거
 -- TRIM(LEADING / TRAILING / BOTH '문자'(1글자) FROM 대상문자열 -> 왼쪽 / 오른쪽 / 양쪽에서 제거
 
 SELECT TRIM ('    안녕   ') AS A,
            TRIM(LEADING 'Z' FROM 'ZZZZZZ안녕ZZZZZ') AS B,
            TRIM(TRAILING 'Z' FROM 'ZZZZZZ안녕ZZZZZ') AS C,
            TRIM(BOTH 'Z' FROM 'ZZaZZZ안녕ZZZZZ') AS D
            -- 트림은 문자 한개만 가능하다.
 FROM DUAL;
 
 -- 문자열을 잘라내는 함수 : SUBSTR() -> JAVA SUBSTRING() 메소드와 유사
 -- SUBSTR(대상문자열,시작인덱스(길이))
 
 SELECT SUBSTR('오늘 가장 쉬운 날 히히히히히히힣 웃엉',14),
            SUBSTR('오늘 가장 쉬운 날 히히히히히히힣 웃엉',14,5),
            SUBSTR('오늘 가장 쉬운 날 히히히히히히힣 웃엉',-3,3),
            SUBSTR('오늘 가장 쉬운 날 히히히히히히힣 웃엉',INSTR('오늘 가장 쉬운 날 히히히히히히힣 웃엉','쉬'),4)
 -- 14는 인덱스 번호입니다.
 FROM DUAL;
 
 
 


-- 일단 처음에는 데이터 베이스를 확인한다 SELECT * FROM EMPLOYEE;
--  사원의 이메일에서 아이디만 출력하기 --? 
 SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
 -- 맨 마지막 숫자이기 때문에 숫자이기 때문에 연산이 가능 @는 필요 없으니 -1
 -- 컬럼 다음에는 쉼표를 한다.
 FROM EMPLOYEE;
 -------------------------------------------------------------------------------------------------
  -- 사람의 이메일아이디가 7글자 이상인 사원의 사원명, 이메일 조회하기 --?
 SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL, '@')-1) AS ID,
        LENGTH(SUBSTR(EMAIL,1,INSTR(EMAIL, '@')-1)) AS EMAIL_ID_LENGTH
        -- AS 뒤에 다가 컬럼명을 설정할 수 있음
        -- ID가 생성된다.
 FROM EMPLOYEE
 WHERE LENGTH(SUBSTR(EMAIL,1,INSTR(EMAIL, '@')-1))>=7;
 
--  WHERE LENGTH(EMAIL_ID_LENGTH>=7; -- 1. FROM 2. WHERE 3. SELECT 순서로 되기 때문에 순서가 역전이 되어서 잘 안된다.
 
 -- 사원 중 여사원의 사원명,부서코드 , 급여 조회하기
 
 SELECT SUBSTR(EMP_NO,8,1) FROM EMPLOYEE; -- 데이터 확인하기
 
 SELECT EMP_NAME, DEPT_CODE,SALARY
 FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO,8,1) IN(2,4); -- 자기가 알아서 형변환을 햇음 2,4를 문자열로
 
 -- 영문자를 대문자 소문자로 변경해주는 함수 : UPPER / LOWER ()
 -- 첫글자만 대문자로 변경해주는 함수 : INITCAP()
 SELECT 'WELCOME TO oRACLE world',
 UPPER ('WELCOME TO oRACLE world'),  -- 대문자로 바꾸어준다.
 LOWER('WELCOME TO oRACLE world'),  -- 소문자로 바꾸어준다
 INITCAP('WELCOME TO oRACLE world')  -- 우리가 쓰는 형식으로 바꾸어줌
 FROM DUAL;
 
-- SELECT * 
-- FROM TEST
-- WHERE FLAG = UPPER(?);
 
 SELECT UPPER(EMAIL)
 FROM EMPLOYEE;
 
 -- 문자열을 결합해주는 함수 : CONCAT() == ||
 SELECT CONCAT('이번시간 끝나면','점심시간') FROM DUAL;
 SELECT CONCAT(CONCAT(EMP_NAME,'님'),'환영합니다')FROM EMPLOYEE;
 
 -- 문자열을 변경해주는 함수 : REPLACE()
 -- REPLACE(대상 문자열, 찾을 문자, 대체 문자)
 SELECT 'DB는 너무 어려워' , REPLACE('DB는 너무 어려워','어려워','쉬울까?')
 FROM DUAL;
 
 SELECT EMAIL, REPLACE(EMAIL, 'BS', 'CHUNJAE')
 FROM EMPLOYEE;
 
 -- 문자열을 거꾸로 만들어주는 함수 : REVERSE
 SELECT EMAIL, REVERSE(EMAIL), REVERSE(REVERSE(EMP_NAME))
 FROM EMPLOYEE;
 
-- 숫자처리함수
-- 절대값을 출력하는 함수 : ABS()

SELECT ABS(10) , ABS(-10)
FROM DUAL;

-- 나머지 값을 구하는 함수 : MOD() -> JAVA의 % 연산자와 비슷하다.

SELECT MOD(3,2) FROM DUAL;
 
 
 -- 소수점을 처리하는 함수 
 -- ROUND : 소수점을 반올림(자릿수를 정할 수 있다.)
 -- CEIL : 소수점을 올림
 -- FLOOR : 소수점 버림
 -- TRUNC : 소수점 버림(자릿수 결정)
 
 SELECT 125.467, ROUND(125.467),ROUND(125.467,2)
 FROM DUAL;
SELECT 125.123 ,CEIL(125.123)
FROM DUAL;
SELECT 125.567, FLOOR(125.567)
FROM DUAL;
SELECT 125.567, TRUNC(125.567), TRUNC(125.567,2)
FROM DUAL;

SELECT ROUND(125.567,-2), ROUND(1234567.1234, -3), TRUNC(123456.123,-2)
FROM DUAL;

-- 오라클에서 제공하는 랜덤함수 이용하기
-- DBMS_RANDOM.VALUE() -> 0~1 사이의 랜덤숫자 출력


SELECT DBMS_RANDOM.VALUE(), FLOOR(DBMS_RANDOM.VALUE()*10)+1,
            FLOOR (DBMS_RANDOM.VALUE(1,11))
FROM DUAL;

-- DBMS_RANDOM.STRING('기호' : 개수) -> 문자열을 랜덤을 출력
-- 'X' :숫자,대문자 랜덤 출력
-- 'P': 숫자, 영문자, 특수기호
-- 'U': 대문자
-- 'L' : 소문자

SELECT DBMS_RANDOM.STRING('P',10),
            DBMS_RANDOM.STRING('X',10), 
            DBMS_RANDOM.STRING('U',10), 
            DBMS_RANDOM.STRING('L',10)
FROM DUAL;


-- 날짜 처리 함수 
-- DATE: 년,월,일 저장하는 타입 -> JAVA의 java.sql.Date객체와 매핑
-- TIMESTAMP : 년,월,일,시,분,초, 저장타입 -> JAVA의 java.sql.Timestamp 객체와 매핑

-- DB에서 현재 날짜를 출력해주는 예약어
-- SYSDATE, SYSTIMESTAMP  -> 오라클이 설치된 컴퓨터의 시간

SELECT SYSDATE,SYSTIMESTAMP
FROM DUAL;

-- 날짜에 산술연산 처리하기
-- +,-, : 날짜의 일수가 증가, 차감되는 연산처리

SELECT SYSDATE,SYSDATE +1, SYSDATE-40
FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, HIRE_DATE -10
FROM EMPLOYEE;

-- 가장 가까운 요일에 날짜를 출력하는 함수 : NEXT_DAY(요일)

SELECT NEXT_DAY(SYSDATE,'월'), NEXT_DAY(SYSDATE,'수') 
FROM DUAL;

SELECT NEXT_DAY(SYSDASTE,'MON') FROM DUAL;


SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

-- LAST_DAY() : 그달의 마지막날 출력하는 함수
SELECT LAST_DAY(SYSDATE), LAST_DAY('99/06/17') FROM DUAL;


-- ADD_MONTH() : 개월수를 더하는 함수

SELECT ADD_MONTHS(SYSDATE,5) FROM DUAL;
SELECT ADD_MONTHS(HIRE_DATE,12)FROM EMPLOYEE;

-- MONTH_BETWEEN() : 두 날짜의 개월수 차이를 계산해주는 함수

SELECT FLOOR(MONTHS_BETWEEN(SYSDATE,'99/04/27'))FROM DUAL;

-- 각 사원의 근무개월수 조회하기
-- 사원명, 입사일, 근무개월수

SELECT EMP_NAME, HIRE_DATE, 
FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) AS 근무개월수
FROM EMPLOYEE;


-- 날짜와 날짜 산술연산

SELECT SYSDATE - TO_DATE('25/02/27','YY/MM/DD') FROM DUAL;

-- 오늘부로 우식님이 군대로 끌려가게 되었습니다.
-- 군복무기간 1년 6개월
-- 우식님 먹어야할 짬밥수 (하루 3끼)

SELECT ADD_MONTHS(SYSDATE,18) AS 전역일, ADD_MONTHS(SYSDATE,18)-SYSDATE AS 근무일수,
(ADD_MONTHS(SYSDATE,18)-SYSDATE )*3 AS 짬밥수
FROM DUAL;

-- 년, 월, 일을 따로 출력하는 함수 ;: EXTRACT()

-- EXTRACT ( YEAR FROM 날짜) : 년도를 숫자로 반환
-- EXTRACT ( MONTH FROM 날짜) : 월 숫자로 반환
-- EXTRACT ( DAY FROM 날짜) : 일 숫자로 반환

SELECT EXTRACT(YEAR FROM SYSDATE) AS YEAR, EXTRACT(MONTH FROM SYSDATE) AS MONTH, EXTRACT(DAY FROM SYSDATE) AS DAY
FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, EXTRACT (DAY FROM HIRE_DATE) AS 입사일자
FROM EMPLOYEE;

-- 사원 중 12월에 입사한 사원을 조회하기

SELECT EMP_NAME, HIRE_DATE, EXTRACT(MONTH FROM HIRE_DATE) AS 입사월

FROM EMPLOYEE

WHERE EXTRACT(MONTH FROM HIRE_DATE) =12;

-- 형변환 함수
-- 오라클에서 자동형변환이 잘 작동함

-- '25/02/27' -> 자동으로 형변환해서 날짜로 취급

SELECT SYSDATE - '25/02/27' FROM DUAL;
SELECT LAST_DAY('25/02/27') FROM DUAL; -- 형변환해서 날짜로 취급됨
SELECT  *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) =1;

-- TO CHAR() : 숫자, 날짜타입을 문자열타입으로 변경해주는 함수
-- 변경문자열은 패턴으로 표시
-- 숫자를 문자로 변경하기
-- 단위별 쉼표로 구분,화폐를 표시할때
-- 0: 해당자리에 숫자가 없으면 0으로 표시
-- 9: 해당자리에 숫자가 없으면 생략
-- L: 화폐를 표시할때 설정 * LOCALE을 기준으로 표시

SELECT 1234567,
        TO_CHAR(1234567,'000,000,000'),
        TO_CHAR(1234567,'999,999,999'),
        TO_CHAR(1234567,'L999,999,999')
FROM DUAL;

-- 소수점 표시하기

SELECT 180.5, TO_CHAR(180.5,'000'),TO_CHAR(180.5,'FM000,000.00'), TO_CHAR(180.5,'FM999,999.99') 
-- 쉼표를 찍자
FROM DUAL;


-- 날짜를 물자열로 변경하기
-- Y/R 년 M 월 D : 일 H : 시 MI:분 S :초

SELECT SYSDATE,
    TO_CHAR(SYSDATE,'YYYY,MM,DD'),
    TO_CHAR(SYSDATE,'YYYY,MM,DD'),
    TO_CHAR(SYSDATE,'YYYY"년" MM"월" DD"일"'),
    TO_CHAR(SYSDATE,'HH:MI:SS')
FROM DUAL;


-- 사원의 급여를 화폐단위를 호활하고, 단위별로 ,로 구분해서 출력,
-- 입사일 0000년 00월 00일로 출력
-- 사원명, 급여, 입사일

SELECT EMP_NAME AS 이름 , TO_CHAR(SALARY,'L999,999,999,999') AS 연봉,  TO_CHAR(HIRE_DATE, 'YYYY"년 "MM"월 "DD"일"') AS 입사일

FROM EMPLOYEE;


-- 문자열을 숫자로 변경하기 

-- TO_NUMBER(대상 문자열,패턴)
SELECT 1000 + 10000, 1000 +TO_NUMBER('1,000','9,999') FROM DUAL;
-- 날짜를 숫자로 변경하기 -> X불가능

-- 문자열을 날짜형으로 변경
-- 숫자를 날짜형으로 변경
-- TO_DATE(대상문자열, 대상숫자, '날짜패턴')

SELECT TO_DATE('99/01/08','YY/MM/DD') - 10,
            TO_DATE('99-05-05','YY/MM/DD'),
            TO_DATE(250227,'YY/MM/DD'),
            TO_DATE(TO_CHAR(001104,'000000'),'YY/MM/DD')
FROM DUAL;

-- 문자열 저장할대는 형변환함수를 사용해서 저장하는 것이 좋다.

-- '24/11/11' -> TO_DATE()

-- NULL 처리함수
-- NVL : 지정된 컬럼에 NULL이 존재하면 대체값으로 출력하는 함수

SELECT EMP_NAME ,BONUS , NVL(BONUS,0), NVL(DEPT_CODE,'인턴')
FROM EMPLOYEE;

-- NVL2() : NULL일때 출력할 값, NULL이 아닐때 출력할 값을 설정하는 함수
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE,'정규직','인턴') AS DIV
FROM EMPLOYEE;

-- 선택함수 
-- 출력값을 분기처리할 수 있는 함수
-- DECODE(컬럼명, '비교값', '출력값','비교값','출력값'): JAVA의 switch문과 유사
-- CASE WHEN 조건문 THEN절
-- CASE
--         WHEN 조건문
--            THEN 출력할 값
--         WHEN 조건문2
--            THEN 출력할값2
--END

SELECT EMP_NAME,
        DECODE(DEPT_CODE,'D9','총무부','D6','영엉부','D5','인사부','부서없음') AS 부서명,
        CASE
            WHEN SALARY >= 4000000
                THEN '급여를 좀 받으시네요'
            WHEN SALARY >= 3000000
                THEN '급여 받으시네요.'
            ELSE '열심히 다니자'
            END
FROM EMPLOYEE;

-- 성별 컬럼(가상컬럼)을 추가해서 성별에 남자,여자로 출력하기
-- 사원번호, 사원명, 주민번호, 급여, 성별(GENDER)

SELECT EMP_ID, EMP_NAME, EMP_NO, SALARY, 
DECODE(SUBSTR(EMP_NO,8,1),'남자',SUBSTR(EMP_NO,8,2),'여자',SUBSTR(EMP_NO,8,3),'남자',SUBSTR(EMP_NO,8,4),'여자') AS GENDER,
CASE
    WHEN SUBSTR(EMP_NO,8,1) IN('1','3')
        THEN '남자'
    WHEN SUBSTR(EMP_NO,8,1) IN('2','4')
        THEN '여자'
        END AS GENDER2
FROM EMPLOYEE;

-- 사원테이블에서 현제 나이를 구하기

SELECT EMP_NAME, 
EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY')),
EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY')) AS 년생,
EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS 년생2,
EXTRACT(YEAR FROM SYSDATE) - 
(SUBSTR(EMP_NO,1,2) +
CASE 
               WHEN SUBSTR(EMP_NO, 8, 1) IN ('1', '2') THEN 1900
               WHEN SUBSTR(EMP_NO, 8, 1) IN ('3', '4') THEN 2000
END )AS 나이
FROM EMPLOYEE;

-- RR로 년도를 출력할때 
--현재년도       입력년도     계산년도
--00~49         00~49       현세기
--00~49         50~99       전세기
--50~99         00~49       다음세기
--50~99         50~99       현세기

insert into EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE, ENT_DATE,ENT_YN) 
values ('252','옛사람','320808-2123341','go_dm@kh.or.kr',null,'D2','J2','S5',4480000,null,null,to_date('94/01/20','RR/MM/DD'),null,'N');

ROLLBACK;

-- 그룹함수
-- 그룹함수의 결과는 한개 ROW로 출력

-- SELECT문에서 그룹함수를 사용하면 컬럼을 선택하는 것이 제한됨.
-- 합계, 평균, ROW갯수, 최댓값, 최솟값
-- SUM(컬럼) : 컬럼 값의 총 합계를 조회
-- AVG(컬럼) : 컬럼 값의 평균을 조회
-- COUNT(컬럼) : ROW수를 조회 * 컬럼값이 NULL인 ROW제외
-- MAX(컬럼) : 컬럼값의 최댓값을 조회
-- MIN(컬럼) : 컬럼값의 최솟값을 조회

-- 전체 사원의 급여 합계를 조회하기

SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 부서가 D5인 사워들의 급여한계 조회하기

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE ='D5';

--SELECT EMP_NAME SUM(SALARY)
--FROM EMPLOYEE;

-- 사원급여 평균 조회하기
SELECT TO_CHAR(FLOOR(AVG(SALARY)),'L999,999,999')AS SAL_AVG FROM EMPLOYEE;
-- D9부서의 평균 급여를 조회하기

SELECT AVG(SALARY)
FROM EMPLOYEE WHERE DEPT_CODE ='D9';

-- 최고급여 조회, 최소급여 조회
SELECT MAX(SALARY)
FROM EMPLOYEE;
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- 사원수 구하기
SELECT COUNT (*)
FROM EMPLOYEE;
-- 하나만 값이 있어도 갯수를 센다.

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;
--  DEPT 코드에 NULL이 저장되면 제외 시킨다.

SELECT SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*)
FROM EMPLOYEE;

-- 계산시 NULL값 처리는????????
SELECT AVG(BONUS),AVG(NVL(BONUS,0)) 
FROM EMPLOYEE;

SELECT AVG(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;




-- 급여를 400만원 이상 받는 사원 수 조회하기
SELECT COUNT(*) 
FROM EMPLOYEE
WHERE SALARY >=4000000;

-- 부서가 D6,D7,D5인 사원의 수,급여합계 , 급여평균 조회하기
SELECT COUNT(*),SUM(SALARY),AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D7');

-- J2 직책의 급여 합계, 평균 조회하기
SELECT SUM(SALARY)AS SUM ,AVG(SALARY) AS AVG
FROM EMPLOYEE
WHERE JOB_CODE IN ('J2');


-- 최고급여를 받는 사원 조회

SELECT *
FROM EMPLOYEE
WHERE SALARY = MAX(SALARY);
-- 그룹함수는 WHERE절에 사용할수 없다!! --> 다른 구문을 사용해야 한다.

-- GROUP BY 절 이용하기
-- 동일한 컬럼값을 묶어주는 기능

-- SELECT 컬럼명
-- FROM 테이블명
-- [WHERE 조건문]
-- [GROUP BY 컬럼명,[컬럼명,.....]]
-- [HAVING 조건문(그룹함수의 결과로 조건문생성)]

-- 부서별 급여합계 조회하기
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE 
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE; -- 그룹 바이에 적힌 컬럼들만 SELECT쓰는 것이 가능하다.

-- 직책별 급여 평균구하기

SELECT JOB_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 부서별 평균급여, 급여합계, 사원수 조회하기
-- 부사가 없는 사원은 인턴으로 표시할 것

SELECT NVL(DEPT_CODE,'사원'), AVG(SALARY),SUM(SALARY),COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


-- GROUP BY에 여러 컬럼 설정하기
-- 다수의 컬럼을 설정하면 한개 그룹으로 처리 
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- 부서 평균 급여가 300만원이상인 부서 조회하기
-- HAVING절을 이용한다.


SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- 직책별 인원수가 3명이상인 직책조회
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*)>=3;

-- 매니저가 관리하는 사원이 2명이상인 매니저 아이디 조회하기
SELECT MANAGER_ID, COUNT(MANAGER_ID)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(MANAGER_ID)>=2;

SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남자','2','여자','3','남자','4','여자') AS 성별,
              TO_CHAR(AVG(SALARY),'L999,999,999') AS 평균급여,
              COUNT(*) AS 사원수
              FROM EMPLOYEE
             GROUP BY DECODE (SUBSTR(EMP_NO,8,1),'1','남자','2','여자','3','남자','4','여자');




-- 1900년에 입사한 사원 수 와 2000년대에 입사한 사원수 조회하기
-- 년도 인원수

SELECT DECODE (SUBSTR(EXTRACT(YEAR FROM HIRE_DATE),1,2),19,'1900',20,'2000') AS 년도
, COUNT(*) 
FROM EMPLOYEE
GROUP BY SUBSTR(EXTRACT(YEAR FROM HIRE_DATE),1,2);

SELECT COUNT(*) AS " 1900년도", COUNT(*) AS "2000년도"
FROM EMPLOYEE;

SELECT COUNT (DECODE(SUBSTR(EXTRACT(YEAR FROM HIRE_DATE),1,2),'19','우와')),
          COUNT ( DECODE(SUBSTR(EXTRACT(YEAR FROM HIRE_DATE),1,2),'20','와우'))
FROM EMPLOYEE;

-- 1900 8
-- 2000 15

--SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY')) AS 년생 ,
--COUNT(*)
--WHERE EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY'))
--
--OR EXTRACT(YEAR FROM HIRE_DATE) BETWEEN 2000 AND 2099
--GROUP BY 
--    EXTRACT(YEAR FROM HIRE_DATE)
--FROM EMPLOYEE;

-- 집계 함수 ROLLUP() / CUBE() 함수
-- GROUP BY 절에 사용하는 그룹함수
-- 부서별 평균 + 총평균까지 조회
SELECT NVL(DEPT_CODE,'TOTAL'), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
--GROUP BY DEPT_CODE  ;

-- GROUP BY DEPT_CODE
--0 GROUP BY ROLLUP(DEPT_CODE)
GROUP BY  CUBE(DEPT_CODE);

-- 다수컬럼 그룹으로 선택하기
-- ROLLUP 집계 : 1가지
-- 1-> 전체 매개변수 컬럼 (DEPT_CODE,JOB_CODE)를 기준으로 집계
-- SELECT AVG(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE, JOB_CODE;
-- 2.-> 첫번째 매개변수 (DEFP_CODE)에 있는 컬럼으로 집계
-- SELECT AVG(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE
-- 3-> 전체집계(TOTAL)
-- SELECT AVG(SALARY) FROM EMPLOYEE
SELECT DEPT_CODE, JOB_CODE, FLOOR(AVG(SALARY)) AS AVG_SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE, JOB_CODE;

-- CUBE집계
-- 4가지 집계
-- 첫번째 매개변수(DEPT_CODE)기준으로 집계
-- 두번째 매개변수(JOB_CODE)기준으로 집계
-- 세번째 매개변수(DEPT_CODE,JOB_CODE) 기준으로 집계
-- 네번째 전체기준으로 집
SELECT DEPT_CODE,JOB_CODE, FLOOR(AVG(SALARY)), COUNT(*), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- 데이터 정렬하기
-- ORDER BY 절 이용하기
-- SELECT 컬럼명,컬럼명.....
-- FROM 테이블명
--[WHERE 조건문]
-- [GROUP BY]
-- [HAVING]
-- [ORDER BY 컬럼명/인덱스번호 (정렬방식(ASC(DEFAULT)/DESC)]

-- 사원 내림차순으로 정렬해서 출력하기

SELECT EMP_NAME
FROM EMPLOYEE
ORDER BY EMP_NAME DESC;

SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;


-- 정렬기준을 여러개 설정하기
-- DEPT_CODE를 기준으로 내림차순정렬하고 같은 값이면 SALARY가 높은 순으로 정렬하기

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE, SALARY DESC;
-- 부서먼저 정렬을하고 SALARY를 그안에서 내림차순 정렬로 정렬한다.

-- SELECT 인덱스 번호로 불러오기

SELECT EMP_NAME, DEPT_CODE, SALAR
--  세번째
FROM EMPLOYEE
-- 첫번째
-- 두번째 WHERE/ HAVING 같은거
ORDER BY 1 DESC;
-- 마지막
-- 순서대로 컬럼에 순서가 부여된다.

-- NULL값 정렬하기
-- DESC : NULL값이 맨위로 설정
-- ASC : NULL값이 맨 아래로 설정
-- NULL 값 정렬 설정 - NULLS FIRST/LAST
SELECT BONUS
FROM EMPLOYEE
ORDER BY BONUS DESC NULLS FIRST;

-- 가상컬럼을 기준으로 정렬할 수 있을까? --> 이용할 수 있다 / 별칭 사용 가능하다.

SELECT EMP_NAME,SALARY,SALARY*12 AS YEAR_SAL
FROM EMPLOYEE
ORDER BY YEAR_SAL DESC;

-- GROUPING() 함수 이용하기
-- 어떤 값으로 집계를 했는지 알려주는 함수
-- 매개변수컬럼으로 집계한 결과면 0아니면 1

SELECT CASE
        WHEN GROUPING(DEPT_CODE) =1 AND GROUPING(JOB_CODE) =1
            THEN 'TOTAL'
        WHEN GROUPING(DEPT_CODE) =0 AND GROUPING(JOB_CODE) =1
            THEN 'DEPT_TOTAL'
        WHEN GROUPING(DEPT_CODE) =1 AND GROUPING(JOB_CODE) =0
            THEN 'JOB_TOTAL'
        WHEN GROUPING(DEPT_CODE) =0 AND GROUPING(JOB_CODE) =0
            THEN 'DEPT_JOB_TOTAL'
    END AS DIV,
    DEPT_CODE,JOB_CODE,COUNT(*)


FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE (DEPT_CODE ,JOB_CODE)
ORDER BY DIV;
SELECT GROUPING(DEPT_CODE),GROUPING(JOB_CODE),DEPT_CODE,JOB_CODE,COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- 집합 연산자
-- 여러개의 SELECT 문을 한개의 결과로 출력해주는 연산자
-- 첫번째 SELECT문의 컬럼수가 기준이 됨.
-- 집합연산할 다른 SELECT문은 첫번째 SELECT문의 컬럼수와 컬럼타입을 맞춰야 연산이 가능하다.

-- SELECT 컬럼명, 컬럼명2....
-- FROM 테이블명
-- 집합연산자(UNION,UNION ALL,INTERSECT,MINUS)
-- SELECT 컬럼명, 컬럼명2....
-- FROM 테이블명

-- UNION / UNION ALL

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION ALL
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY >=3000000;


-- UNION으로 CUBE 만들기

SELECT DEPT_CODE,JOB_CODE,COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE,JOB_CODE
UNION
SELECT DEPT_CODE,NULL, COUNT(*) -- 갯수만 맞춰주면된다.
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
UNION
SELECT NULL, JOB_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
UNION
SELECT NULL,NULL,COUNT(*)
FROM EMPLOYEE;

-- 다른테이블에 있는 값과 연결하기 
SELECT '부서' AS NAME, DEPT_TITLE AS TITLE
FROM DEPARTMENT
UNION
SELECT '직책',JOB_NAME
FROM JOB;

SELECT '사원',EMP_NAME, SALARY
FROM EMPLOYEE
UNION
SELECT '부서',DEPT_TITLE,0
FROM DEPARTMENT;

-- INTERSECT -> 중복값 가져오기
SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
INTERSECT
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY >=3000000;

-- MINUS -> 중복값을 제거하고 가져오기 -- 위를 기준으로 중복되는것을 제거
SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
MINUS
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY >=3000000;

SELECT EMP_ID,EMP_NAME
FROM EMPLOYEE
UNION
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
UNION
SELECT JOB_CODE,JOB_NAME
FROM JOB
MINUS
SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_ID IN ('D5','D6','D7')
INTERSECT
SELECT EMP_ID,EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%유%';


-- INNER JOIN OUTTER  차이?

-->JAVA에서 HAS A 관계? 

-- JOIN
-- 두개 이상의 테이블을 특정컬럼을 기준으로 ROW를 연결하는 것
-- INNERJOIN : 특정컬럼과 일치하는 ROW들만 연겷하는 것 -> 일치하는게 없는 ROW는 생략을 한다. 
--(제거하고 출력)
-- OUTTE JOIN : 특정컬럼과 일치하는 ROW가 없는 것도 연결해서 출력하는 것 --> 모든 것을 볼 수 있음 

-- INNER JOIN
--SELECT(컬럼명)
--FROM 테이블명 A
-- JOIN 테이블명B ON 조건식 -> 조건식이 참이 경우에 ROW와 연결을 한다.
-- 오라클표현
-- FROM 테이블 A,테이블 B
-- WHERE테이블명 A, 컬럼 = 테이블B, 컬럼
-- [WHERE]
-- [GROUP BY]
-- [ORDER BY]

-- 사원명 , 급여 , 부서명 조회하기 
SELECT EMP_NAME , SALARY, DEPT_CODE
FROM EMPLOYEE ;

SELECT DEPT_TITLE, DEPT_ID
FROM DEPARTMENT;

SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;


-- 부서명, 부서지역의 국가 코드를 조회하기
-- DEPARTMENT, LOCATION

SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

SELECT DEPT_TITLE, NATIONAL_CODE
FROM DEPARTMENT 
JOIN LOCATION ON DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE; -- 이름이 중복되지 않으면 알아서 찾아서 실행이 된다.

-- 사원명,직책명 조회하기

SELECT E.JOB_CODE, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;
--ON EMPLOYEE. JOB_CODE = JOB.JOB_CODE;

-- 연결 기준되는 컬럼명이 동일할때 USING()을 이용할 수 있다.

SELECT JOB_CODE,EMP_NAME,JOB_NAME -- 별도의 별칭을 사용하지 않는다.
FROM EMPLOYEE E
JOIN JOB J USING (JOB_CODE); -- USING을 사용했을 때는 JOB_CODE가 하나만 나오게 된다.

-- ORACLE 방식
--SELECT *
--FROM EMPLOYEE , DEPARTMENT
--WHERE DEPT_CODE = DEPT_ID;

-- 사원 중 회계 관리부에서 근무하는 사원의 사원명,부서명,급여,보너스

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME,DEPT_TITLE,SALARY,BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
WHERE DEPT_TITLE LIKE '%영업%';

-- JOIN문에서 GROUP BY절 이용하기
-- 부서별(부서명) 평균급여, 사원수를 조회하기
-- 평균급여가 300만원이상인 부서 조회하기

SELECT DEPT_TITLE, AVG(SALARY), COUNT(*)
FROM EMPLOYEE
JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
GROUP BY DEPT_TITLE
-- GROUP BY 쓴걸 위에서 사용한것만 사용이 가능하다.
HAVING AVG(SALARY) >= 3000000;


-- ASIA에서 근무하는 사원의 사원명, 부서명 조회하기

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

SELECT  *
FROM DEPARTMENT JOIN LOCATION ON  LOCAL_CODE = LOCATION_ID;
--WHERE LOCAL_NAME LIKE 'AISA1';

-- 사원명 부서명
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- OUTER.JOIN 이용하기
-- 기준 테이블의 모든 ROW를 가져오고 다른 테이블과 일치하는 값이 잇으면 일치하는 ROW를 연결하고 
-- 없으면 NULL값으로 처리한다.
-- LEFT JOIN : 
-- RIGHT JOIN : 
SELECT *
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT *
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_CODE;

-- 언제 INNER JOIN/ OUTTER JOIN 사용?

-- 학생---> 사물함 (선택 관계) 신청하면 갖고 아니면 안갖는다. -> OUTTER JOIN      NULL?
-- 학생 ---> 선생님 (필수 관계) 한명의 담임을 가지게 된다. --> INNTER JOIN


-- 사원에게 부여되지 않은 직책 조회하기 
-- 직책코드, 직책명
SELECT * FROM EMPLOYEE;
INSERT INTO JOB VALUES('J8','반장');
SELECT * FROM JOB;

SELECT JOB_NAME
FROM EMPLOYEE
RIGHT JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IS NULL;

-- PK(PRIMARY KEY) 값 : 레코드를 구분해주는 값 (NULL일수 없는값)

-- SELF JOIN
-- 한개의 테이블을 이용해서 조인을 하는 것
-- 동일한 값을 갖는 컬럼이 두개가 있어야함

SELECT *
FROM EMPLOYEE;
-- 사원의 매니저 정보 조회하기
SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;

-- 테이블을 하나가지고 조회한다. 여기서는 별칭이 중요하다. E는 직원 M은 매니저

-- 매니저가 없는 사원을 조회하기

SELECT *
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID
WHERE M.EMP_ID IS NULL;

---------------------------------------------------------------------------------------------------------------
-- 비동등 조인 
-- 대소,범위

SELECT * FROM SAL_GRADE;

SELECT E.EMP_NAME, SALARY, S.SAL_LEVEL
FROM EMPLOYEE E JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

------------------------------------------------------------------------------------------------------------------

-- 다중 조인
-- 3개 이상의 테이블을 조인하는 것
-- 사원명, 부서명, 직책명, 급여, 보너스 조회하기

SELECT EMP_NAME,DEPT_TITLE, JOB_NAME,SALARY, BONUS
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
    
-- 사원명,부서명,직책명,지역명(LOCAL_NAME),지역코드(LOCAL_CODE),국가코드(NATIONAL_CODE) 조회하기
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, DEPT_TITLE,JOB_NAME, LOCAL_NAME, LOCAL_CODE, NATIONAL_CODE
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN LOCATION  ON LOCAL_CODE = LOCATION_ID;

-- 연결되어 있는 데이터를 조인해서 가지고 오게 된다면 모두다 OUTTER 조인을 해줘야한다.
-- 조인도 순서가 있다 위에 부터 하나씩 만들어 가는 과정이라고 생각하면 됨
-- 제일 먼저 FROM과 제일 위에 있는 조인과 합친다. (순서가 중요 컬럼 있어야지 JOIN이 된다.)
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;
-------------------------------------------------------------------------------------------------------------------------
--쪼아~--
-- 주민번호가 1970년대 생이면서 성별이 여자이고, 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명 조회하기
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SUBSTR(EMP_NO,1,2) BETWEEN '70' AND '79' AND EMP_NAME LIKE '전%'AND SUBSTR(EMP_NO,8,1) IN ('2','4') ;
-- SUBSTR(EMP_NO,8) -> 2665412를 가져온다. 8부터 쭉 가지고 오는것 뒤에 인덱스를 정해주지 않아서
-------------------------------------------------------------------------------------------------------------------------
-- 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오
SELECT EMP_NO,EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
WHERE EMP_NAME LIKE '%형%';

-------------------------------------------------------------------------------------------------------------------------
-- 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.

SELECT EMP_NAME,  JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
WHERE DEPT_TITLE LIKE '해외영업%';

-- IN으로 하는것은 해외영업부로 배정받은 것이 있어야한다. 하지만 여기서는 해외영업1부 이기때문에 LIKE
-------------------------------------------------------------------------------------------------------------------------
-- 보너스를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명(LOCAL_NAME)을 조회하시오.
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;
-------------------------------------------------------------------------------------------------------------------------
-- 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명(LOCAL_NAME)을 조회하시오.
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE DEPT_CODE = 'D2';
-------------------------------------------------------------------------------------------------------------------------
-- 급여등급테이블의 최대급여(MAX_SAL)보다 많이 받는(보너스포함 급여, 세전) 직원들의 사원명,
-- 직급명, 급여, 연봉(세전)을 조회하시오.
-- (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 조인할 것)
SELECT EMP_NAME, JOB_NAME,SALARY,(SALARY + (SALARY * NVL(BONUS,0)))*12 AS 연봉 
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE (SALARY + (SALARY * NVL(BONUS,0))) > MAX_SAL;
-------------------------------------------------------------------------------------------------------------------------
-- 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국','일본');
-- 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
SELECT E1.EMP_NAME,DEPT_TITLE,E1.MANAGER_ID
FROM EMPLOYEE E1
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
JOIN EMPLOYEE E2 USING(DEPT_CODE)
WHERE EMP_ID !=EMP_ID;
--JOIN EMPLOYEE E2 ON E.EMP_NAME = E2.EMP_NAME;
--------------------------------------------------------------------------------------------------------------
-- 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
--SELECT COUNT((EMT_DATE),EMT_DATE IS NOT NULL, 1)  AS "재직중인 직원", COUNT(DECODE(EMT_DATE IS NOT NULL))  AS "퇴사한 직원의 수"

--SUM(CASE WHEN ENT_YN = 'N' THEN 1 ELSE 0 END)  AS "재직중인 직원",
--SUM(CASE WHEN ENT_YN = 'Y' THEN 1 ELSE 0 END) AS "퇴사한 직원의 수"
SELECT
COUNT(DECODE(ENT_YN, 'N', 1))  AS "재직중인 직원",
COUNT(DECODE(ENT_YN, 'Y', 1))  AS "퇴사한 직원의 수"
FROM EMPLOYEE;
--WHERE ENT_DATE IS NOT NULL;

-- 서브쿼리에 대해 알아보자
-- SELECT문에 다른 SELECT문을 작성하는 것
-- 주SELECT(MAIN) 보조SELECT(SUB)
-- 서브쿼리는 반드시 괄호로 묶어서 표현을 함
-- 서브쿼리는 컬럼, FROM 절, WHERE절에 사용이 가능
-- INSERT, UPDATE, DELETE, CREATE문에서도 사용이 가능함

-- SELECT 컬럼명,(SELECT 컬럼명 FROM 테이블명) -> 단일행서브쿼리, 스칼라서브쿼리 사용가능
-- FROM (SELECT 컬럼명, 컬럼명2 FROM 테이블명) -> 다중행 다중열서브쿼리(가상컬럼을 포함한 쿼리문) : INLINE VIEW
-- WHERE 컬럼명 연산자 (SELECT문) ->단일행, 다중행, 다중열, 스칼라 서브쿼리

-- 윤은해 사원과 동일한 급여를 받고 있는 사원 조회하기
SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='윤은해';
SELECT * 
FROM EMPLOYEE
--WHERE SALARY=2000000;
WHERE SALARY=(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='윤은해')
        AND EMP_NAME!='윤은해';
        
-- D5부서의 평균급여보다 급여를 많이 받는 사원의 사월명, 급여, 부서코드 조회하기
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY>(SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE='D5');

-- 단일 행 서브커리
-- 서브커리의 결과(RESULT SET)가 1개열,1개행인 경우
-- 컬럼작성부, WHERE절에 비교 대상값으로 사용 
-- 전체 사원의 평균급여보다 많은 급여를 받는 직원의 이름 급여 평균 급여 조회하기

-- AVG(SALARY) 그룹함수라서 같이 사용 XXXXXXXXXXXXXX
SELECT EMP_NAME, SALARY, (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE) AS SAL_AVG
FROM EMPLOYEE
WHERE SALARY > (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);


-- 부서가 총무부인 사원을 조회하기 --> JOIN 말고 서브쿼리 사용하기

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE ='총무부');

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE  JOB_NAME='과장');

-- 2. 다중행 서브 커리
-- 서브쿼리의 결과가 1개컬럼, 1개이상의 행을 찾는것
-- 직책이 과장,부장인 사원 조회하기

SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN('과장','부장');

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN('과장','부장'));

-- 다중행에 대한 비교 연산자
-- ANY(), : 행의 값을 OR 묶어서 연산
-- ALL() : 행의 값을 AND 묶어서 연산

-- 컬럼<[=] ANY() : 다중행 서브쿼리의 값 중 최댓값보다 작으면 참
-- 컬럼>[=] ANY() : 다중행 서브쿼리의 값 중 최솟값보다 크면 참
-- D5,D6 사원의 급여보다 많이 받는 사원

SELECT EMP_NAME, SALARY FROM EMPLOYEE 
--WHERE SALARY > ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D6'));
--WHERE SALARY > (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D6'));
--WHERE SALARY < (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D6'));
WHERE SALARY <(SELECT MAX(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D6'));

-- 컬럼 >=(=) : ALL() 다중행 서크붜리의 값 중 최댓값보다 크면 참
-- 컬럼 <=(=) : ALL() 다중행 서브쿠리의 값 중 최소값보다 작으면 참


SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY < ALL(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D6'));

-- 다중열 서브쿼리
-- 서브쿼리의 결과가 1개행 다수컬럼인 경우
-- 퇴직한 여사원과 같은 부서 같은 직급인 사원 조회하기

SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE ENT_YN ='Y';

SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) =(SELECT DEPT_CODE, JOB_CODEFROM EMPLOYEEWHERE ENT_YN ='Y');


--  기술지원부이고 급여가 200만원 이상인 사원을 찾아 사원명, 부서코드, 급여 조회하기

SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE,SALARY) = 
(SELECT DEPT_ID,SALARY 
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
WHERE DEPT_TITLE='기술지원부' AND SALARY =2000000);

-------------------------------------------------------------------------------------------------------

-- 기술지원부이고 급여가 200만원인 사원을 찾아 사원명, 부서코드, 급여 조회하기
SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE,SALARY) = (SELECT DEPT_ID, SALARY FROM DEPARTMENT WHERE DEPT_TITLE='기술지원부' AND SALARY=2000000);

-- 

--WHERE (DEPT_CODE,SALARY) = (SELECT DEPT_ID, SALARY 
--                                                    FROM EMPLOYEE JOIN DEPARTMENT
--                                                   ON DEPT_CODE=DEPT_ID WHERE DEPT_TITLE='기술지원부' AND SALARY=2000000);
--WHERE (DEPT_CODE,SALARY)=(SELECT DEPT_CODE, SALARY 
--                                                FROM EMPLOYEE
--                                                WHERE SALARY=2000000 
--                                                        AND DEPT_CODE=(SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE='기술지원부'));


-- 다중행 다중열 서브커리
-- 여러행, 여러컬럼을 가지는 서브쿼리
-- 테이블을 생성할때 , 가상테이블(INLINE_VIEW STORED VIEW)을 만들때

SELECT *
FROM(SELECT E.*, 
            DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2', '여') AS GENDER, 
       SALARY * 12 AS YEAR_SAL
        FROM EMPLOYEE E 
        )
WHERE GENDER ='여';
-- CREATE TABLE TEST2
-- AS SELECT * FROM EMPLOYEE;


-- 상관서브쿼리(스칼라서브쿼리)
-- 서브쿼리를 작성할때 메인쿼리의 특정 값을 가져와 사용하는것
-- 본인이 속한 부서의 사원수를 조회
-- 상품의 작성된 댓글수, 좋아요 수 ?

SELECT * 
FROM EMPLOYEE;
------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM EMPLOYEE WHERE DEPT_CODE='D9';
SELECT E.*,(SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS DEPT_COUNT
FROM EMPLOYEE E;

-- 사원이 속한 부서의 사원수가 3명이상인 사원만 조회하기

SELECT E.*-- 3
FROM EMPLOYEE E --1 
WHERE (SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) > 3 ---2 
ORDER BY DEPT_CODE DESC; --4 

-- FROM -> WHERE-> GROUP BY-> HAVING -> SELECT ->ORDER BY

-- EXIST 연산자를 이용할수 있다
-- 서브 쿼리의 ROW가 있으면 (ROW 1개 이상) TRUE, 없으면(ROW가 1개) FALSE
-- 매니저인 사원 조회하기
SELECT *
FROM EMPLOYEE E
WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);


SELECT *
FROM EMPLOYEE
WHERE EXISTS (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE ='총무부');

-- 바뀌는 값을 받을때 EXISTS 사용을 한다.

-- 최고 급여를 받는 사원 조회하기

SELECT EMP_NAME,SALARY
FROM EMPLOYEE E 
--WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);
WHERE SALARY >= ALL(SELECT SALARY FROM EMPLOYEE);
--WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE SALARY>E.SALARY);

SELECT EMP_NAME, JOB_NAME, SALARY, 
(SELECT AVG(SALARY) FROM EMPLOYEE WHERE JOB_CODE = E.JOB_CODE)
FROM EMPLOYEE E
JOIN JOB  J ON E.JOB_CODE = J. JOB_CODE
WHERE E. SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE JOB_CODE = E. JOB_CODE);

SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY, 
(SELECT AVG(SALARY) FROM EMPLOYEE WHERE JOB_CODE = E.JOB_CODE)
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE JOB_CODE = E.JOB_CODE);

-- INLINE VIEW에서 사용한 컬럼을 MAIN SELECT 문에서 사용할 수 있음

SELECT EMP_NAME,PHONE,SALARY
    FROM (SELECT EMP_NAME, EMAIL, PHONE, SALARY*12 AS YEAR_SAL FROM EMPLOYEE);

-- 부적합한 식별자 뜬다.

SELECT EMP_NAME,PHONE,YEAR_SAL
    FROM (SELECT EMP_NAME, EMAIL, PHONE, SALARY*12 AS YEAR_SAL FROM EMPLOYEE);

-- INLINE VIEW라고 한다.


SELECT 
    E.*, 
    DECODE(SUBSTR(EMP_NO, 1, 1), '1', '남', '2', '여') AS GENDER 
    FROM EMPLOYEE E ;

-- 연봉을 포함한 사원의 사원명 부서명 직책명 자신이 속한 부서의 평균 급여(버림 원화)
-- 부서가 없으면 인턴으로 표시
-- INLINE VIEW 설정하기

SELECT 
    E.EMP_NAME, 
    DEPT_TITLE, 
    JOB_NAME, 
    SALARY * 12
FROM (
    SELECT 
        EMP_NAME, 
        DEPT_TITLE, 
        JOB_NAME, 
        (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.DEPT_CODE = DEPT_CODE) AS DEPT_AVG
    FROM 
        EMPLOYEE E 
    JOIN 
        DEPARTMENT ON E.DEPT_CODE = DEPT_ID
    JOIN 
        JOB USING (JOB_CODE)
) T;

-- 집합연산을 INLINE VIEW로 이용

SELECT *
FROM(
    SELECT EMP_ID AS ID, EMP_NAME AS NAME FROM EMPLOYEE
    UNION
    SELECT DEPT_ID,DEPT_TITLE FROM DEPARTMENT
    UNION
    SELECT JOB_CODE,JOB_NAME FROM JOB)
WHERE NAME LIKE '%장%';

SELECT *
FROM (
    SELECT EMP_ID AS ID, EMP_NAME AS NAME FROM EMPLOYEE
    UNION
    SELECT DEPT_ID AS ID, DEPT_TITLE AS NAME FROM DEPARTMENT
    UNION
    SELECT JOB_CODE AS ID, JOB_NAME AS NAME FROM JOB
)
WHERE NAME LIKE '%장%';


-- 다수의 INLINE VIEW 만들기
-- 중첩에서 INLINE VIEW 생성할 수 있음 -> LEVEL

SELECT A.*
FROM (
    SELECT 
        T.*, 
        (SELECT AVG(SALARY) FROM EMPLOYEE WHERE JOB_CODE = T.JOB_JOB_CODE) AS AVG_SALARY
    FROM (
        SELECT 
            SALARY * 12 AS YEAR_SAL,
            E.*, D.*, J.JOB_CODE AS JOB_JOB_CODE
        FROM EMPLOYEE E
        JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
        JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
    ) T
) A;

-- ROW를 TOP-N으로 조회하기 
-- 두가지 방법
-- 오라클이 기본으로 제공하는 ROWNUM이라는 가상컬럼을 이용하는 방법
-- 오라클이 제공하는 함수를 이용하는 방법 -> RANK() OVER(),DENSE_RANK() OVER()

SELECT E.* , ROWNUM
FROM EMPLOYEE E
ORDER BY SALARY DESC;

-- ROWNUM은 FROM절이 끝났을때 숫자를 부여하게 된다. -- > 결국 ORDER BY가 되지 않는다.
SELECT EMP_NAME,SALARY
FROM EMPLOYEE
--WHERE ROWNUM BETWEEN 1 AND 5
ORDER BY SALARY DESC;

SELECT E.* , ROWNUM
FROM (SELECT E.* 
FROM EMPLOYEE E
ORDER BY SALARY DESC) E
WHERE ROWNUM BETWEEN 1 AND 5;

SELECT E.*, ROWNUM

FROM (SELECT E.*FROM EMPLOYEE E ORDER BY SALARY) E

WHERE ROWNUM BETWEEN 1 AND 5;

-- 급여를 많이 받는 5~10위에 사원을 조회하기
SELECT *
    FROM(SELECT E.*, ROWNUM AS RNUM
        FROM(SELECT * FROM EMPLOYEE E ORDER BY SALARY) E)
WHERE RNUM BETWEEN 6 AND 10;

-- INLINEVIEW에 고정시킨다음에 사용한다..?--??

-- 함수를 이용해서 조회하는 방법
-- RANK(), OVER(정렬 - ORDER BY 컬럼명) : 동일값이 있으면 번호를 생략 -> 누락되는 번호가 있음
-- DENSE_RANK()OVER(ORDER BY 컬럼) : 동일값이 있어도 번호를 생략하지 않는다. -> 누락번호 X

SELECT RANK() OVER(ORDER BY SALARY) AS RANK,
        E.SALARY, E.EMP_NAME,
        DENSE_RANK() OVER(ORDER BY SALARY) AS DENSE
FROM EMPLOYEE E;

-- 급여를 많이 받는 5등까지 조회 하기
SELECT *
FROM ( 
        SELECT RANK() OVER(ORDER BY SALARY) AS RANK,
        E.SALARY, E.EMP_NAME,
        DENSE_RANK() OVER(ORDER BY SALARY) AS DENSE
        FROM EMPLOYEE E)
WHERE RANK BETWEEN 10 AND 20;

-- 평균급여가 많은 부서 3개 출력하기
SELECT *
FROM(
    SELECT DEPT_TITLE, FLOOR(AVG(SALARY)) AS 평균급여, 
    RANK() OVER(ORDER BY AVG(SALARY)DESC ) AS DDD
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
    GROUP BY DEPT_TITLE)
WHERE DDD <=3;

-- 부서코드
SELECT * 
FROM (
            SELECT DEPT_CODE, AVG(SALARY), RANK() OVER(ORDER BY AVG(SALARY) DESC) AS AVG_ORDER
            FROM EMPLOYEE
            WHERE DEPT_CODE IS NOT NULL
            GROUP BY DEPT_CODE)
WHERE AVG_ORDER <=3;
SELECT * 
FROM (
    SELECT E.*,ROWNUM AS RNUM
    FROM(
        SELECT DEPT_CODE, AVG(SALARY) AS AVG_SAL
                FROM EMPLOYEE
                WHERE DEPT_CODE IS NOT NULL
                GROUP BY DEPT_CODE
            ORDER BY 2 DESC)E
    )
WHERE RNUM <=3;

-- WITH구문 이용하기
-- SELECT문 안에서 사용할 SELECT 문을 저장하여 재사용하는 구문

WITH
    TEST_WITH AS (SELECT EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC),
    TEST_WITH2 AS (SELECT * FROM EMPLOYEE),
    TEST_WITH3 AS (SELECT * FROM  DEPARTMENT)
SELECT EMP_NAME,SALARY
FROM TEST_WITH
MINUS
SELECT EMP_NAME, SALARY
FROM TEST_WITH2
WHERE DEPT_CODE='D5'
UNION
SELECT DEPT_ID, 0
FROM TEST_WITH3;


--SELECT * FROM TEST_WITH;

-- DDL활용하기
-- 테이블을 생성하는 방법에 대해 알아보자!

-- 테이블은CREATE TABLE 명령어를 이용해서 생성
-- 테이블은 데이터를 저장하는 저장소
-- 데이터(값)는 컬럼에 저장 -> 컬럼에 값에 맞는 타입을 설정
-- 오라클에서 사용하는 타입
-- 숫자 : NUMBER
-- 문자 : CHAR , VARCHAR2, NCHAR,NVARCHAR2,CLOB,LONG
-- 날짜 : DATE, TIMESTAMP

-- 테이블을 생성하는 명령어
-- CREATE TABLE 테이블명(
-- 컬럼명 타입명[(길이)] [제약조건, 제약조건]
-- 컬럼명2 타입명2[(길이)] [제약조건, 제약조건]
-- [제약조건] )
--
-- 문자열 타입 이용하기
-- CHAR : 고정 크기의 문자열
-- VARCHAR2 : 가변 크기로 문자열 저장
-- NVARCHAR2 : 가변크기로 VARCHAR2보다 많은 문자열 표현이 가능하다.

CREATE TABLE TBL_STR(
A CHAR(6),
B VARCHAR2(6),
C NVARCHAR2(6) -- 문자수라고 생각하면 좀 편함
);

SELECT * FROM TBL_STR;
DESC TBL_STR;

INSERT INTO TBL_STR VALUES ('ABC','ABC','ABC');
SELECT * FROM TBL_STR;
-- A는 무조건 6 나머지 공간을 공란으로 함
SELECT LENGTH(A),LENGTH(B),LENGTH(C) FROM TBL_STR;

INSERT INTO TBL_STR VALUES ('ABCDEF','ABCDEF','ABCDEF');
SELECT * FROM TBL_STR;
INSERT INTO TBL_STR VALUES ('ABCDEFG','ABCDEF','ABCDEF');
INSERT INTO TBL_STR VALUES ('가니','점심','메뉴');
INSERT INTO TBL_STR VALUES ('가나다','점심뭐','메뉴뭐'); 
-- 한글은 3바이트로 저장이 된다.(CHAR나 VARCHAR에대 해서)
INSERT INTO TBL_STR VALUES ('가나','점심','메뉴뭐'); 
INSERT INTO TBL_STR VALUES ('가나','점심','메뉴뭐먹을까'); 


SELECT *
FROM TBL_STR
WHERE A = 'ABC'; -- 자바에서는 공백까지 가져와서 처리한다.

-- 숫자형 자료형
-- NUMBER : 정수,실수 모두 저장하는 타입
-- NUMBER[(저장가능한 자리수, 소수점자리수)]
-- 지정가능한 자리수 : 1~ 38 가능
-- 소수점 : -84 ~-127 가능

CREATE TABLE TBL_NUM(
A NUMBER, -- 정수,실수
B NUMBER(3), -- 정수만
C NUMBER(3,1),  -- 정수,실수(한자리만)
D NUMBER(3,-1), -- 정수만 , 일의 자리를 0
E NUMBER(32)  --- 정수 자리수 32개
);

SELECT * FROM TBL_NUM;
DESC TBL_NUM;

INSERT INTO TBL_NUM VALUES(12.567,12.567,12.567,12.567,12.567);
INSERT INTO TBL_NUM VALUES(123.567,123.567,12.467,123.567,123.567);
INSERT INTO TBL_NUM VALUES(123.567,123.467,12.417,123.567,123.567);
SELECT * FROM TBL_NUM;


-- 날짜타입 활용하기
-- DATE : 년,월,일을 저장하는 자료형
-- TIMESTAMP : 년,월,일,시,분,초 저장하는 자료형

CREATE TABLE TBL_DATE(
BIRTH_DAY DATE,
RENT_START TIMESTAMP
);

SELECT * FROM TBL_DATE;
INSERT INTO TBL_DATE VALUES(SYSDATE,SYSTIMESTAMP);

-- 날짜를 저장해서 저장하기
-- 1. 문자열로 저장하기 -> 특정패턴으로 맞춰서 저장
-- YY/MM/DD / YY/MM/DD HH:MI:SS
-- 2. TO_DATE / TO_TIMESTAMP 함수를 이용하기
-- 문자, 숫자를 날짜로 변환해서 사용
INSERT INTO TBL_DATE VALUES('00/09/03','00/11/04 10:30');
SELECT * FROM TBL_DATE;

INSERT INTO TBL_DATE 
VALUES (
    TO_DATE('99-06-17', 'RR-MM-DD'),
    TO_TIMESTAMP('99-04-27 03:33:33', 'RR-MM-DD HH24:MI:SS')
);

-- 많은 문자열 저장할때
-- VARCHAR2 : 최대 4000BYTE까지 저장이 가능
-- CLOB(2GB)을 이용해서 저장하자

CREATE TABLE TBL_STR2(
TEST_STR VARCHAR2(4000),
TEST_CLOB CLOB
);

-- 테이블 생성시 컬럼에 제약 조건 설정하기
-- NOT NULL : 컬럼에 NULL값을 허용하지 않을때 기본적으로 컬럼은 NULLABLE상태로 생성이됨
-- UNIQUE : 컬럼에 중복값을 허용하지 않을 때
-- PRIMARY KEY : 컬럼 중복값이 없고, NULL값이 없는 컬럼 중 하나는 선택해서 설정 * ROW를 구분하는 기준으로 사용
-- FOREIGN KEY : 다른 테이블의 컬럼에 있는 값만 저장이 가능하게 설정 * 데이터의 일관성, 참조물경성을 해결하기 위해 설정
-- CHECK : 지정된 값만 저장될 수 있게 하는 설정 * 동등비교, 대소비교 결과가 TRUE값만 저장
-- DEFAULT 설정 : 저장시 컬럼에 값을 설정하지 않았을때 저장되는 기본값

-- 제약조건을 설정하는 방식
-- 1. 컬럼레벨에서 설정 : 단일컬럼에 제약조건을 설정할때 , 컬럼 선언부 
-- 2. 테이블레벨에서 설정 : 단일, 다수컬럼에 제약조건을 설정할때 -> 복합키 다수 컬럼에 UNIQUE
-- CREATE TABLE 테이블명(
-- 컬럼명 타입 제약조건설정(컬럼레벨),
-- 제약조건설정
--> 

--> NOT NULL(C) 제약조건 NULL값을 허용하지 않는 컬럼에 설정
-- NOT NULL조건을 컬럼별로 설정이 가능
-- 다수로 설정할 수 없다 -> 테이블 레벨에서 설정이 불가능
CREATE TABLE CONS_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(50),
    MEMBER_PWD VARCHAR2(50)
    -- NOT NULL (MEMBER_NO,MEMBER_ID) -> 불가능
);

SELECT * FROM CONS_MEMBER;
INSERT INTO CONS_MEMBER VALUES(1,'ADMIN','1234');
INSERT INTO CONS_MEMBER VALUES(NULL,NULL,NULL);
-- 기본적으로는 NULLABLE

CREATE TABLE CONS_MEMBER_NN(
    MEMBER_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(50) NOT NULL,
    MEMBER_PWD VARCHAR2(50) 
    );
    
INSERT INTO CONS_MEMBER_NN VALUES(1,'ADMIN','1234');
INSERT INTO CONS_MEMBER_NN VALUES(NULL,'ADMIN','1234');
INSERT INTO CONS_MEMBER_NN VALUES(2,'USER01',NULL);
SELECT * FROM CONS_MEMBER_NN; 

-- UNIQUE ( U ) : 컬럼에 중복데이터를 저장할 수 없게 하는 제약조건

CREATE TABLE CONS_MEMBER_UQ(
    MEMBER_NO NUMBER UNIQUE,
    MEMBER_ID VARCHAR2(50) UNIQUE,
    MEMBER_PWD VARCHAR(50) NOT NULL
);



SELECT * FROM CONS_MEMBER_UQ;
INSERT INTO CONS_MEMBER_UQ VALUES(1,'ADMIN','1234');
INSERT INTO CONS_MEMBER_UQ VALUES(2,'USER01','1234');
INSERT INTO CONS_MEMBER_UQ VALUES(1,'ADMIN','1234');
INSERT INTO CONS_MEMBER_UQ VALUES(3,'USER02','1234');

-- UNIQUE 제약조건을 설정한 컬럼에 NULL값 대입하기
INSERT INTO CONS_MEMBER_UQ VALUES(NULL,'USER03','1234');
INSERT INTO CONS_MEMBER_UQ VALUES(NULL,'USER04','1234');
SELECT * FROM CONS_MEMBER_UQ;


-- CONSTRAINT

-- 다수 컬럼에 UNIQUE제약조건 설정하기
CREATE TABLE CONS_MEMBER_UQ2(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(50),
    MEMBER_PWD VARCHAR2(50),
    UNIQUE(MEMBER_NO,MEMBER_ID) 
    -- 두개를 같이 비교 하나로 둘다 달라야지 무결성에 위배 된다.
    -- 이예~
    -- 수강신청          조인               과목
    -- 학생 1              1 1                1
    -- 학생 2              1 2                2
    -- 학생 3              1 3                3
    -- 학생 4              1 1(X)             4 
    
    -- 1번학생이 1 과목 1을 여러번 신청하지 않게 할때
    -- 1,1 1,3 1,4 가능 1,1 / 1,3/ 1,4 --
    --> 이런경우 그룹으로 정해서 UNIQUE  --> 장바구니 같은 상품은 한개만!
);


INSERT INTO CONS_MEMBER_UQ2 VALUES(1,'ADMIN','1234');
INSERT INTO CONS_MEMBER_UQ2 VALUES(1,'ADMIN','4444');
INSERT INTO CONS_MEMBER_UQ2 VALUES(2,'ADMIN','4444');

-- PRIMARY KEY( P ) 설정하기 : 설정된 컬럼은 중복값, NULL 저장되지 X
-- 컬럼에 NOT NULL, UNIQUE 제약조건이 설정된 것과 동일함
-- 테이블에 필요한 컬럼에 설정하기 -> 회원테이블에 ID, EMAIL
-- 테이블에 필요하지 않은 컬럼에 설정 -> 회원 테이블에 회원번호
-- 일반적으로 테이블당 한개의 PK를 설정한다. --> 여러개 설정은 가능하다.

CREATE TABLE CONS_MEMBER_PK(
    MEMBER_NO NUMBER PRIMARY KEY, -- > 후보키, 자동 낫널~ 유니크
    MEMBER_ID VARCHAR(50), --> 후보키
    MEMBER_PWD VARCHAR(50),
    MEMBER_NAME VARCHAR(50)
);
SELECT * FROM CONS_MEMBER_PK;
INSERT INTO CONS_MEMBER_PK VALUES(1,'ADMIN','1234','관리자');
INSERT INTO CONS_MEMBER_PK VALUES(NULL,'ADMIN','1234','관리자');
INSERT INTO CONS_MEMBER_PK VALUES(1,'ADMIN','1234','관리자');
INSERT INTO CONS_MEMBER_PK VALUES(2,'USER01','1234','유저01');
SELECT * FROM CONS_MEMBER_PK WHERE MEMBER_NO =2;
-- 가져올때 PRIMARYKEY를 기준으로 가져온다.

CREATE TABLE CONS_MEMBER_PK2(
    MEMBER_ID VARCHAR(50) PRIMARY KEY, --> 후보키
    MEMBER_PWD VARCHAR(50) NOT NULL,
    MEMBER_NAME VARCHAR(50) NOT NULL
);

CREATE TABLE CONS_MEMBER_PK3(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(50), -- 후보키
    MEMBER_PWD VARCHAR2(50) NOT NULL,
    MEMBER_NAME VARCHAR2(50) NOT NULL,
    PRIMARY KEY(MEMBER_NO, MEMBER_ID)
);

SELECT * FROM CONS_MEMBER_PK3;
INSERT INTO CONS_MEMBER_PK3 VALUES(1,'ADMIN','1234','관리자');
INSERT INTO CONS_MEMBER_PK3 VALUES(1,'USER01','4444','관리');
INSERT INTO CONS_MEMBER_PK3 VALUES(NULL,'USER01','4444','관리');

-- FOREGIN KEY ( R ) : 컬럼에 저장되는 데이터가 다른 테이블이 있는 값만 가능하게 설정
-- 참조 관계
-- 부모 테이블 <-----> 자식테이블(FOREIGN KEY)로 구분할 수 있음
-- 값을 전달                값을 참조하는
-- 학생 <-->수강신청 테이블<--> 과목, 회원 <- 댓글 -> 개시글
-- 컬럼레벨, 테이블레벨에서 설정이 가능
-- 참조하는 테이블의 컬럼은 PRIMARY KEY, UNIQUE 제약조건이 설정되어야 한다.
-- 참조하는 컬럼에 여러개의 테이블값을 참조할 수 없다. -> 한개만 가능하다.

CREATE TABLE CONS_BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR(100) NOT NULL,
    BOARD_CONTENT VARCHAR(2000)
); -- 주는 PARENT

CREATE TABLE CONS_COMMENT(
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(2000),
    BOARD_REF REFERENCES CONS_BOARD(BOARD_NO)
); -- 받는 CHILD


INSERT INTO CONS_BOARD VALUES(1,'오라클 너무 쉽네(냉무)',NULL);
INSERT INTO CONS_BOARD VALUES(2,'상진님 힘내요!','미세먼지가 괴롭히나요? 에취에취!');
INSERT INTO CONS_BOARD VALUES(3,'오늘은 목요일','내일은 금요일');
SELECT * FROM CONS_BOARD;
INSERT INTO CONS_COMMENT VALUES(1,'진짜 너무 할만하네',1);
INSERT INTO CONS_COMMENT VALUES(2,'으잉 난 어려워',1);
SELECT * FROM CONS_COMMENT;
INSERT INTO CONS_COMMENT VALUES(3,'나는 새로운 댓글!',1);

-- 참조 컬럼에 NULL값을 넣기
INSERT INTO CONS_COMMENT VALUES(4,'나는 새로운 댓글!',NULL);

-- 필수 관계 꼭 있어야하는 관계 게시글과 댓글 


SELECT *
FROM CONS_BOARD LEFT JOIN CONS_COMMENT ON BOARD_REF = BOARD_NO;


