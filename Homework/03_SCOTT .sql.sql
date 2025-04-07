-- 1. EMP 테이블에서 COMM 의 값이 NULL이 아닌 정보 조회

SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

-- 2. EMP 테이블에서 커미션을 받지 못하는 직원 조회

SELECT *
FROM EMP
WHERE NVL(COMM,0) = 0;

-- 3. EMP 테이블에서 관리자가 없는 직원 정보 조회
SELECT *
FROM EMP
WHERE MGR IS NULL;

-- 4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회
SELECT *
FROM EMP
ORDER BY SAL DESC;

-- 5. EMP 테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회 --- ??

SELECT *
FROM EMP
ORDER BY SAL DESC, COMM DESC;

-- 앞의 SAL을 정렬한뒤, COMM으로 한번뒤 내림차순으로 한번더 정렬을 한번 더 하면
-- SAL이 같은 경우 COMM으로 내림차순으로 조회 가능하다.

-- 6. EMP 테이블에서 사원번호, 사원명, 직급, 입사일 조회 (단, 입사일 오름차순 정렬 처리)
SELECT EMPNO, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE;

-- 7. EMP 테이블에서 사원번호, 사원명 조회(사원번호 기준 내림차순 정렬)
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;

-- 8. EMP 테이블에서 사번, 입사일, 사원명, 급여 조회
-- (부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)

SELECT EMPNO, DEPTNO, HIREDATE, ENAME, SAL
FROM EMP
ORDER BY DEPTNO, HIREDATE DESC;

-- 9. 오늘 날짜에 대한 정보 조회
SELECT SYSDATE AS 오늘날짜
FROM DUAL;


-- 10. EMP 테이블에서 사번, 사원명, 급여 조회
-- (단, 급여는 100단위 까지의 값만 출력 처리하고 급여 기준 내림 차순 정렬)

SELECT EMPNO,ENAME,FLOOR (SAL/100) * 100 AS SAL
FROM EMP
ORDER BY SAL DESC;

--> 소수점을 없애가 거나 올림 하는 함수들 ROUND CEIL FLOOR 같은 걸 이용하기 위해서 
--> 소수점을 만들어준다.

-- 11. EMP 테이블에서 사원번호가 홀수인 사원들을 조회

SELECT *
FROM EMP
WHERE MOD(EMPNO,2) !=0;

--12. EMP 테이블에서 사원명,입사일 조회( 단 입사일을 년도와 월을 분리 추출해서 출력)

SELECT ENAME,  EXTRACT(YEAR FROM HIREDATE) AS 입사년도, 
EXTRACT(MONTH FROM HIREDATE) AS 입사월
FROM EMP;

-- 13. EMP 테이블에서 9월에 입사한 직원의 정보 조회

SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;

-- 14. EMP 테이블에서 81년도 입사한 직원조회

SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;

-- 15.EMP 테이블에서 이름이 E로 끝나는 직원 조회

SELECT *
FROM EMP
WHERE ENAME LIKE '%E';

-- 16. EMP테이블에서 이름의 세번째 글자가 R인 직원의 정보 조회

SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

SELECT *
FROM EMP
WHERE SUBSTR(ENAME,3,1) = 'R';

-- 17. EMP 테이블에서 사번, 사원명, 입사일 입사일로부터 40년 되는 날짜 조회

SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE,480)
FROM EMP;

-- 18. EMP 테이블에서 입사일로부터 38년이상 근무한 직원의 정보 조회 
SELECT *
FROM EMP
WHERE SYSDATE - TO_DATE(HIREDATE,'RR/MM/DD')  >365*38;

-- 19. 오늘 날짜에서 년도만 추출
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;