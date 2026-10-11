  
  --1.  Write create table syntax for employee table and Incentive table
CREATE TABLE EMPLOYEE
(EMP_ID INT,FIRST_NAME VARCHAR2(20),LAST_NAME VARCHAR2(20),SALARY NUMBER
 ,JOINING_DATE DATE,DEPARTMENT VARCHAR2(30));
 
INSERT INTO EMPLOYEE VALUES (1, 'JOHN', 'ABRAHAM', 1000000, TO_DATE('01-JAN-13','DD-MON-YY'), 'BANKING');

INSERT INTO EMPLOYEE VALUES (2, 'MICHAEL', 'CLARKE', 800000, '01-JAN-13', 'INSURANCE');

INSERT INTO EMPLOYEE VALUES (3, 'ROY', 'THOMAS', 700000, TO_DATE('01-FEB-13','DD-MON-YY'), 'BANKING');

INSERT INTO EMPLOYEE VALUES (4, 'TOM', 'JOSE', 600000, '01-FEB-13', 'INSURANCE');

INSERT INTO EMPLOYEE VALUES (5, 'JERRY', 'PINTO', 650000, '01-FEB-13', 'INSURANCE');

INSERT INTO EMPLOYEE VALUES (6, 'PHILIP', 'MATHEW', 750000, '01-JAN-13', 'SERVICES');

SELECT * FROM EMPLOYEE;

CREATE TABLE INCENTIVES
(EMPLOYEE_REF_ID NUMBER ,INCENTIVE_DATE DATE ,INCENTIV_AMOUNT NUMBER );

INSERT INTO INCENTIVES VALUES ( 1, TO_DATE('01-FEB-13','DD-MON-YY'),5000);
INSERT INTO INCENTIVES VALUES ( 2, TO_DATE('01-FEB-13','DD-MON-YY'),3000);
INSERT INTO INCENTIVES VALUES ( 3, TO_DATE('01-FEB-13','DD-MON-YY'),4000);
INSERT INTO INCENTIVES VALUES ( 1, TO_DATE('01-JAN-13','DD-MON-YY'),4500);
INSERT INTO INCENTIVES VALUES ( 2, TO_DATE('01-JAN-13','DD-MON-YY'),3500);
SELECT * FROM INCENTIVES;

--4.	Get First_Name,Last_Name from employee table
SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEE;

--5.Get First_Name from employee table using alias name “Employee Name”
SELECT FIRST_NAME AS EMPLOYEE_NAME FROM EMPLOYEE;

--6.	Get First_Name from employee table in upper case
SELECT UPPER(FIRST_NAME) FROM EMPLOYEE;

--7.Select first 3 characters of FIRST_NAME from EMPLOYEE
SELECT SUBSTR(FIRST_NAME, 1, 3) AS FIRST_3_CHARS
FROM EMPLOYEE;

--8.	Get position of 'o' in name 'John' from employee table
SELECT INSTR(FIRST_NAME, 'O') AS POSITION_OF_O
FROM EMPLOYEE
WHERE FIRST_NAME = 'JOHN';

--9.	Get FIRST_NAME from employee table after removing white spaces from right side.
SELECT RTRIM(FIRST_NAME) FROM EMPLOYEE;

--10.	Get First_Name from employee table after replacing 'o' with '$'.
SELECT REPLACE(FIRST_NAME ,'O','$') FROM EMPLOYEE;

--11.	Get First_Name and Last_Name as single column from employee table separated by a '_'
SELECT FIRST_NAME||'_'||LAST_NAME AS FULL_NAME FROM EMPLOYEE;

--12.	Get FIRST_NAME, Joiningyear, Joining Month and Joining Date from employee table
SELECT FIRST_NAME ,
EXTRACT(YEAR FROM JOINING_DATE) AS JONINGYEAR ,
TO_CHAR(JOINING_DATE , 'MONTH' )AS JOINING_MONTH ,
EXTRACT(DAY FROM JOINING_DATE) AS JONING_DATE FROM EMPLOYEE ;

--13.	Get all employee details from the employee table order by First_Name Ascending
SELECT * FROM EMPLOYEE 
ORDER BY FIRST_NAME ASC;

--14.	Get all employee details from the employee table order by First_Name Ascending and Salary Descending?
SELECT * FROM EMPLOYEE
ORDER BY FIRST_NAME ASC ,SALARY DESC;

--15.	Get employee details from employee table whose employee name is “John”
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME='JOHN' ;

--16.	Get employee details from employee table whose employee name are “John” and “Roy”
SELECT * FROM EMPLOYEE 
WHERE FIRST_NAME ='JOHN' AND 'ROY';

--17.	Get employee details from employee table whose employee name are not “John” and “Roy”.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME NOT IN ('JOHN', 'ROY'); 
--18.	Get employee details from employee table whose first name starts with 'J'.
SELECT * FROM EMPLOYEE 
WHERE FIRST_NAME LIKE 'J%' ;

--19.	Get employee details from employee table whose first name contains 'o'.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME LIKE 'O%' ;

--20.	Get employee details from employee table whose first name ends with 'n'.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME LIKE'%N';

--21.	Get employee details from employee table whose first name ends with 'n' and name contains 4 letters.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME LIKE '%___N';

--22.	Get employee details from employee table whose first name starts with 'J' and name contains 4 letters.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME LIKE 'J%___';
--23.	Get employee details from employee table who’s Salary greater than 600000.
SELECT * FROM EMPLOYEE
WHERE SALARY >600000 ;
--24.	Get employee details from employee table whose joining year is “2013”.
SELECT * FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM JOINING_DATE)=2013;
--25.	Get employee details from employee table whose joining month is “January”.
SELECT * FROM EMPLOYEE
WHERE JOINING_DATE = TO_CHAR(JOINING_DATE ,'MONTH');

--26.	Get employee details from employee table who joined before January 1st 2013.
SELECT *
FROM EMPLOYEE
WHERE JOINING_DATE < TO_DATE('01-JAN-2013', 'DD-MON-YYYY');

--28.	Get Joining Date and Time from employee table
SELECT TO_CHAR(JOINING_DATE ,'DD-MM-YYYY HH24:MI:SS')AS JOINING_DATE_TIME FROM EMPLOYEE;

--29.	Get Joining Date, Time including milliseconds from employee table
SELECT TO_CHAR(JOINING_DATE ,'DD-MM-YYYY HH24:MI:SS')AS JOINING_DATE_TIME FROM EMPLOYEE;
--30.	Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table.
SELECT EMP_ID,JOINING_DATE, INCENTIVE_DATE ,
(JOINING_DATE - INCENTIVE_DATE)AS DIFF_IN_DAYS FROM EMPLOYEE E
JOIN INCENTIVES I
ON E.EMP_ID =I.EMPLOYEE_REF_ID ;
--31.	Get department, total salary with respect to a department from employee table.
SELECT DEPARTMENT ,SUM(SALARY) AS TOTAL_SALARY FROM EMPLOYEE 
GROUP BY DEPARTMENT;
--32.	Get department, total salary with respect to a department from employee table order by total salary descending.
SELECT DEPARTMENT , SUM(SALARY) AS TOTAL_SALARY FROM EMPLOYEE
GROUP BY DEPARTMENT 
ORDER BY TOTAL_SALARY DESC;

--33.	Get department, no of employees in a department, total salary with respect to a department from employee table order by total salary descending.
SELECT DEPARTMENT ,COUNT(EMP_ID)AS NO_OF_EMPLOYEES ,SUM(SALARY) AS TOTAL_SALARY FROM EMPLOYEE
GROUP BY DEPARTMENT
ORDER BY TOTAL_SALARY DESC;
--34.	Get department wise average salary from employee table order by salary ascending?
SELECT DEPARTMENT ,AVG(SALARY) AS AVG_SALARY FROM EMPLOYEE
GROUP BY DEPARTMENT
ORDER BY AVG_SALARY ASC;
--35.	Get department wise maximum salary from employee table order by salary ascending?
 SELECT DEPARTMENT,MAX(SALARY) AS MAX_SALARY FROM EMPLOYEE 
GROUP BY DEPARTMENT
ORDER BY MAX_SALARY ASC;

--36.	Get department wise minimum salary from employee table order by salary ascending?
SELECT DEPARTMENT,MIN(SALARY) AS MIN_SALARY FROM EMPLOYEE
GROUP BY DEPARTMENT
ORDER BY MIN_SALARY ASC;
--37.	Select no of employees joined with respect to year and month from employee table.
SELECT JOINING_DATE, COUNT(EMP_ID) AS NO_OF_EMPLOYEES FROM EMPLOYEE
GROUP BY JOINING_DATE;
--OR
SELECT EXTRACT(YEAR FROM JOINING_DATE) AS JOINING_YEAR,
EXTRACT(MONTH FROM JOINING_DATE)AS JOINING_MONTH ,
COUNT(EMP_ID) AS NO_OF_EMPLOYEE FROM EMPLOYEE
GROUP BY EXTRACT(YEAR FROM JOINING_DATE),EXTRACT(MONTH FROM JOINING_DATE)
ORDER BY JOINING_YEAR ,JOINING_MONTH ASC;
--38.	Select department,total salary with respect to a department from employee table where total salary greater than 800000 order by Total_Salary descending
SELECT DEPARTMENT ,SUM(SALARY) AS TOTAL_SALARY FROM EMPLOYEE 
GROUP BY DEPARTMENT
HAVING SUM(SALARY) > 800000
ORDER BY TOTAL_SALARY DESC;
--39.	Select employee details from employee table if data in incentive table?
SELECT * FROM EMPLOYEE E
JOIN INCENTIVES I
ON E.EMP_ID = I.EMPLOYEE_REF_ID ;
--40.	Select 20 % of salary from John, 10% of Salary for Roy and for other 15 % of salary from employee table
SELECT FIRST_NAME ,SALARY,
CASE
  WHEN FIRST_NAME = 'JOHN' THEN SALARY*0.20
  WHEN FIRST_NAME = 'ROY' THEN SALARY*0.10
ELSE
  SALARY*0.15
END AS CALCULATED_AMT
FROM EMPLOYEE;

--41.	Select Banking as 'Bank Dept', Insurance as 'Insurance Dept' and Services as    'Services Dept' from employee table.
SELECT DEPARTMENT,
CASE 
  WHEN DEPARTMENT ='BANKING' THEN 'BANK DEPT '
  WHEN DEPARTMENT='INSURANCE' THEN 'INSURANCE DEPT '
  WHEN DEPARTMENT ='SERVICES' THEN 'SERVICE DEPT ' 
 END AS DEPARTMENTS
 FROM EMPLOYEE;
--42.	Delete employee data from employee table who got incentives in incentive table
DELETE FROM EMPLOYEE E
WHERE EXISTS( SELECT 1 FROM  INCENTIVES I
              WHERE E.EMP_ID =I.EMPLOYEE_REF_ID);
--43.	Select first_name, incentive amount from employee and incentives table for those employees who have incentives.
SELECT E.FIRST_NAME,I.INCENTIV_AMOUNT FROM EMPLOYEE E
JOIN INCENTIVES I
ON E.EMP_ID =I.EMPLOYEE_REF_ID;
 SELECT * FROM EMPLOYEE;
--44.	Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000
SELECT E.FIRST_NAME ,I.INCENTIV_AMOUNT FROM EMPLOYEE E
JOIN INCENTIVES I
ON E.EMP_ID =I.EMPLOYEE_REF_ID
WHERE I.INCENTIV_AMOUNT >3000;
--45.	Select first_name, incentive amount from employee and incentives table for all employees even if they didn't get incentives
SELECT E.FIRST_NAME ,I.INCENTIV_AMOUNT FROM EMPLOYEE E
LEFT JOIN INCENTIVES I
ON E.EMP_ID =I.EMPLOYEE_REF_ID ;
--46.	Select first_name, incentive amount from employee and incentives table for all employees even if they didn't 
--get incentives and set incentive amount as 0 for those employees who didn't get incentives.
SELECT E.FIRST_NAME ,NVL(I.INCENTIV_AMOUNT ,0 ) AS INCENTIVE_AMOUNT FROM EMPLOYEE E
LEFT JOIN INCENTIVES I
ON E.EMP_ID =I.EMPLOYEE_REF_ID ;

--47.	Select first_name, incentive amount from employee and incentives table for all employees who got incentives using left join
SELECT E.FIRST_NAME , I.INCENTIV_AMOUNT FROM EMPLOYEE E
LEFT JOIN INCENTIVES I
ON E.EMP_ID = I.EMPLOYEE_REF_ID
WHERE INCENTIV_AMOUNT IS NOT NULL;


 
--48.	Select max incentive with respect to employee from employee and incentives table using sub query.
SELECT 
    E.EMP_ID,
    E.FIRST_NAME,
    (SELECT MAX(I.INCENTIV_AMOUNT)
     FROM INCENTIVES I
     WHERE I.EMPLOYEE_REF_ID = E.EMP_ID
    ) AS MAX_INCENTIVE
FROM EMPLOYEE E
WHERE E.EMP_ID IN (SELECT EMPLOYEE_REF_ID FROM INCENTIVES);

--------------------------------------------------------------
CREATE TABLE EMP 
(ID INT ,SALARY INT);

INSERT INTO EMP VALUES(101,200);
INSERT INTO EMP VALUES(102,300);
INSERT INTO EMP VALUES(103,400);

SELECT * FROM EMP;

SELECT TO_CHAR(ID),SALARY FROM EMP
UNION ALL
SELECT 'TOTAL',SUM(SALARY) FROM EMP;
-----
SELECT * FROM HR.DEPARTMENTS;
SELECT DEPARTMENT_ID ,FIRST_NAME FROM HR.EMPLOYEES 
UNION
SELECT DEPARTMENT_ID,'NA' FROM HR.DEPARTMENTS;


SELECT * FROM (
SELECT DEPARTMENT_ID,COUNT(*) TOTAL_EMPLOYEES FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID)
WHERE TOTAL_EMPLOYEES >10;

SELECT INSTR('THIS IS PLAYLIST','IS') FROM DUAL;


SELECT FIRST_NAME ,LENGTH(FIRST_NAME) FROM HR.EMPLOYEES;

--CASE STATEMENT

SELECT EMPLOYEE_ID,FIRST_NAME ,SALARY ,
CASE
    WHEN SALARY>20000
     THEN 'HIGH  PAID EMPLOYEE '
    WHEN SALARY <=20000 AND SALARY> 10000
     THEN 'MEDIAM PAID EMPLOYEE'
    ELSE
      'LOW PAID EMPLOYEE'
      END EMP_CAT
FROM HR.EMPLOYEES;

--CONCATATION OPERATOR
SELECT EMPLOYEE_ID ,FIRST_NAME||' '||LAST_NAME  AS FULL_NAME FROM HR.EMPLOYEES; 

SELECT EMPLOYEE_ID,FIRST_NAME ||' '|| LAST_NAME ||' '|| 'HAS A SALARY'||' '||SALARY AS FULL_NAME FROM HR.EMPLOYEES;

--COLESCE - RETURNS THE FIRST NON NULL VALUE 
SELECT COALESCE(NULL,5,2,3) FROM DUAL;

CREATE  VIEW DEPT_50 AS
SELECT * FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID =50 ;
 
 SELECT * FROM ALL_VIEWS
 WHERE VIEW_NAME = 'DEPT_50' ;
 
--COMMON TABLE EXPRESSION - WE CAN STORE TEMPORARY DATA OR RECORD

WITH AVG_CTE AS
(SELECT AVG(SALARY) FROM HR.EMPLOYEES
 GROUP BY DEPARTMENT_ID )
 SELECT * FROM AVG_CTE ;










