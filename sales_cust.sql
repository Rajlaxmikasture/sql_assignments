CREATE TABLE SALESPEOPLE 
(SNUM INT PRIMARY KEY ,
 SNAME VARCHAR2(20),
 CITY VARCHAR2(20),
 COMM NUMBER );
 
INSERT INTO SALESPEOPLE VALUES (1001,'PEEL','LONDON',0.12);
INSERT INTO SALESPEOPLE VALUES (1002 ,'SERRES','SAN LOSE',0.13);
INSERT INTO SALESPEOPLE VALUES (1004,'MONIKA', 'LONDON',0.11);
INSERT INTO SALESPEOPLE VALUES (1007,'RIFKIN', 'BARCELONA',0.15);
INSERT INTO SALESPEOPLE VALUES (1003,'AXELROD', 'NEW YORK',0.10);
INSERT INTO SALESPEOPLE VALUES (1005,'FRANC', 'LONDON',0.26);
SELECT * FROM SALESPEOPLE ;



CREATE table customers 
(CNUM INT PRIMARY KEY ,
CNAME VARCHAR2(20),
CITY VARCHAR2(15),
RATING VARCHAR2(20),
SNUM INT , foreign KEY(SNUM)REFERENCES SALESPEOPLE(SNUM));

select * from customers;

insert into customers values (2001,'hoffman','london' ,100,1001);
insert into customers values (2002,'Giovanni','Rome' ,200,1003);
insert into customers values (2003,'Liu','San Jose' ,200,1002);
insert into customers values (2004,'Grass','Berlin' ,300,1002);
insert into customers values (2006,'Clemens','london' ,100,1001);
insert into customers values (2008,'Cisneros','San Jose' ,300,1007);
insert into customers values (2007,'Pereira','Rome' ,100,1004);

CREATE TABLE ORDERS 
(ONUM INT PRIMARY KEY ,
AMT NUMBER ,ODATE DATE ,
CNUM INT, FOREIGN KEY (CNUM) REFERENCES customers(CNUM),
SNUM INT,FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM));


INSERT INTO ORDERS VALUES (3001, 18.69,  TO_DATE('03-Oct-96 12:30','DD-MON-YY HH24:MI'), 2008, 1007);
INSERT INTO ORDERS VALUES (3003, 767.19, TO_DATE('03-Oct-96 13:45','DD-MON-YY HH24:MI'), 2001, 1001);
INSERT INTO ORDERS VALUES (3002, 1900.10,TO_DATE('03-Oct-96 12:05','DD-MON-YY HH24:MI'), 2007, 1004);
INSERT INTO ORDERS VALUES (3005, 5160.45,TO_DATE('03-Oct-96 14:00','DD-MON-YY HH24:MI'), 2003, 1002);
INSERT INTO ORDERS VALUES (3006, 1098.16,TO_DATE('03-Oct-96 13:37','DD-MON-YY HH24:MI'), 2008, 1007);

INSERT INTO ORDERS VALUES (3009, 1713.23,TO_DATE('04-Oct-96 15:21','DD-MON-YY HH24:MI'), 2002, 1003);
INSERT INTO ORDERS VALUES (3007, 75.75,  TO_DATE('04-Oct-96 16:02','DD-MON-YY HH24:MI'), 2002, 1003);

INSERT INTO ORDERS VALUES (3008, 4723.00,TO_DATE('05-Oct-96 12:07','DD-MON-YY HH24:MI'), 2006, 1001);
INSERT INTO ORDERS VALUES (3010, 1309.95,TO_DATE('06-Oct-96 13:12','DD-MON-YY HH24:MI'), 2004, 1002);
INSERT INTO ORDERS VALUES (3011, 9891.88,TO_DATE('06-Oct-96 13:09','DD-MON-YY HH24:MI'), 2006, 1001);

INSERT INTO ORDERS VALUES (3012, 3455.78,TO_DATE('04-Oct-96 15:21','DD-MON-YY HH24:MI'), 2002, 1003);
INSERT INTO ORDERS VALUES (3013, 1245.98,TO_DATE('03-Oct-96 13:32','DD-MON-YY HH24:MI'), 2002, 1003);

INSERT INTO ORDERS VALUES (3014, 3721.53,TO_DATE('05-Oct-96 12:45','DD-MON-YY HH24:MI'), 2006, 1001);
INSERT INTO ORDERS VALUES (3015, 734.50, TO_DATE('06-Oct-96 13:16','DD-MON-YY HH24:MI'), 2004, 1002);
INSERT INTO ORDERS VALUES (3016, 1729.67,TO_DATE('06-Oct-96 13:07','DD-MON-YY HH24:MI'), 2006, 1001);

SELECT * FROM ORDERS;

--1.	List all customers with a rating of 100.
SELECT * FROM customers 
where rating =100 ;

--2.	Find all records in the Customer table with NULL values in the city column.
SELECT * from customers 
where city is null ;

--3.	Find the largest order taken by each salesperson on each date.
SELECT S.SNAME,O.ODATE ,MAX(AMT) AS LARGEST_ORDER FROM ORDERS O
JOIN SALESPEOPLE S
ON S.SNUM =O.SNUM
GROUP BY S.SNAME,O.ODATE;

--4.	Arrange the Orders table by descending customer number.
SELECT *
FROM ORDERS
ORDER BY CNUM DESC;

--5.	Find which salespeople currently have orders in the Orders table.
 SELECT DISTINCT S.SNAME
FROM SALESPEOPLE S
JOIN ORDERS O
    ON S.SNUM = O.SNUM;
--6.	List names of all customers matched with the salespeople serving them.
SELECT C.CNAME,S.SNAME FROM customers C
JOIN SALESPEOPLE S
ON C.SNUM =S.SNUM;

--7.Find the names and numbers of all salespeople who had more than one customer.
SELECT S.SNUM,S.SNAME ,COUNT(C.CNUM) FROM SALESPEOPLE S
JOIN customers C
ON C.SNUM=S.SNUM
GROUP BY S.SNUM ,S.SNAME
HAVING COUNT(C.CNUM)>1 ;

--8.Count the orders of each of the salespeople and output the results in descending order.
SELECT COUNT(ONUM) AS ORDERS ,SNUM FROM ORDERS
GROUP BY SNUM  
ORDER BY ORDERS DESC;

--9.	List the Customer table if and only if one or more of the customers in the Customer tables are located in San Jose.
SELECT * FROM customers
where EXISTS (SELECT 1 FROM customers
      WHERE city ='San Jose');

--10.	Match salespeople to customers according to what city they lived in.
SELECT S.SNAME,C.CNAME ,S.CITY,C.CITY FROM SALESPEOPLE S
JOIN customers C
ON C.CITY=S.CITY;

--11.	Find the largest order taken by each salesperson.
SELECT MAX(AMT) AS LARGEST_ORDER ,SNUM FROM ORDERS 
GROUP BY SNUM;

--12.	Find customers in San Jose who has a rating above 200.
SELECT * FROM CUSTOMERS 
WHERE CITY = 'San Jose' and RATING >200 ;

--13.	List the names and commissions of all salespeople in London.
SELECT SNAME ,COMM FROM SALESPEOPLE
WHERE CITY= 'LONDON';

--14.	List all the orders of salesperson Monika from the Orders table
SELECT O.*,S.SNAME FROM ORDERS O
JOIN SALESPEOPLE S
ON S.SNUM=O.SNUM
WHERE S.SNAME ='MONIKA';

--15.	Find all customers with orders on October 3.
SELECT C.CNAME, O.*
FROM CUSTOMERS C
JOIN ORDERS O
    ON C.CNUM = O.CNUM
WHERE EXTRACT(MONTH FROM O.ODATE) = 10
  AND EXTRACT(DAY FROM O.ODATE) = 3;
  
--16.	Give the sums of the amounts from the orders table, grouped by date, 
SELECT SUM(AMT) AS SUM_OF_AMOUNTS ,ODATE FROM ORDERS 
GROUP BY ODATE ;
--17.	Eliminating all those dates where the SUM was not at least 2000.00 above the MAX amount.
SELECT 
    ODATE,
    SUM(AMT) AS TOTAL_AMOUNT,
    MAX(AMT) AS MAX_AMOUNT
FROM ORDERS
GROUP BY ODATE
HAVING SUM(AMT) >= MAX(AMT) + 2000;

--18.	Select all orders that had amounts that were greater than at least one of the orders from October 6.
SELECT * FROM ORDERS 
WHERE AMT > ANY
      (SELECT AMT FROM ORDERS
       WHERE EXTRACT(MONTH FROM ODATE)=10 AND EXTRACT(DAY FROM ODATE)=06);

--19.	Write a query that uses the EXISTS operator to extract all 
--salespeople who have customers with a rating of 300.
SELECT * FROM SALESPEOPLE S
WHERE EXISTS ( SELECT 1 FROM customers C
               WHERE C.SNUM =S.SNUM AND RATING =300);

--20.	Find all pairs of customers having the same rating.
SELECT c1.* ,c2.* FROM customers c1
cross join customers c2
where c1.rating =c2.rating
   and c1.CNUM <c2.CNUM;
--21.	Find all customers with CNUM, 1000 above the SNUM of Serres.
SELECT C.* ,S.SNAME,S.SNUM FROM customers C
JOIN SALESPEOPLE S
ON C.CNUM= S.SNUM+1000
WHERE S.SNAME ='SERRES'  ;

SELECT * FROM customers 
where CNUM = (SELECT SNUM + 1000 FROM SALESPEOPLE 
                 WHERE SNAME = 'SERRES');
                 
--22.	Give the salespeople’s commissions as percentage instead of decimal numbers.
SELECT 
    SNAME,
    (COMM * 100) || '%' AS COMMISSION_PERCENT
FROM SALESPEOPLE;

--23.	Find the largest order taken by each salesperson on each date, 
--eliminating those MAX orders, which are less than $3000.00 in value.
SELECT S.SNAME ,O.ODATE,MAX(O.AMT) AS LARGEST_ORDER FROM SALESPEOPLE S
JOIN ORDERS O
ON S.SNUM=O.SNUM
GROUP BY S.SNAME,O.ODATE
HAVING MAX(O.AMT)>3000.00;

--24.	List the largest orders on October 3, for each salesperson.
SELECT MAX(O.AMT) AS LARGEST_ORDER,S.SNAME FROM ORDERS O
JOIN SALESPEOPLE S
ON S.SNUM = O.SNUM 
WHERE EXTRACT (DAY FROM O.ODATE) =03 AND EXTRACT(MONTH FROM O.ODATE)=10 
GROUP BY S.SNAME ;
--25.	Find all customers located in cities where Serres (SNUM 1002) has customers.
SELECT * FROM customers
WHERE CITY IN( SELECT CITY FROM customers
        WHERE SNUM=1002 );
--26.	Select all customers with a rating above 200.00.
SELECT * FROM customers
WHERE RATING>200.00 ;  
      
--27.	Count the number of salespeople currently listing 
--orders in the Orders table.
SELECT COUNT(DISTINCT S.SNUM) AS NO_OF_SALESPEOPLE FROM SALESPEOPLE S
JOIN ORDERS O 
ON O.SNUM =S.SNUM ;

--28.	Write a query that produces all customers serviced by salespeople with a commission above 12%. Output the customer’s 
--name and the salesperson‘s rate of commission.
select C.CNAME, S.COMM *100 AS COMM from customers c
join SALESPEOPLE S 
ON S.SNUM = C.SNUM 
WHERE S.COMM *100 >12; 
 
--29.	Find salespeople who have multiple customers
SELECT SNAME FROM SALESPEEOPLE 
WHERE 


--30.	Find salespeople with customers located in their city.
SELECT SNAME,S.CITY,C.CITY FROM SALESPEOPLE S
JOIN customers c
ON S.SNUM =C.SNUM ;

--31.	Find all salespeople whose name starts with ‘P’ and the fourth character is ‘I’.
SELECT * FROM SALESPEOPLE
WHERE SNAME LIKE 'P%___I%';
                    
--32.	Write a query that uses a sub query to obtain all orders for the
-- customer named ‘Cisneros’. Assume you do not know his customer number.   
SELECT * FROM ORDERS
WHERE CNUM IN (SELECT CNUM FROM customers
                WHERE CNAME = 'Cisneros');
--33.	Find the largest orders for ‘Serres’ and ‘Rifkin’.
select MAX(O.AMT) AS LARGEST_ORDER  FROM ORDERS O
JOIN SALESPEOPLE S
ON S.SNUM =O.SNUM
WHERE S.SNAME = 'Serres' and S.SNAME ='Rifkin';            
                                                     
SELECT MAX(AMT) AS LARGEST_ORDER FROM ORDERS
WHERE SNUM = ( SELECT SNUM FROM SALESPEOPLE
               WHERE SNAME = 'Serres' and SNAME = 'Rifkin');

--34.Extract the Salespeople table in the following order: SNUM, SNAME, COMMISSION, CITY.
SELECT SNUM,SNAME,COMM,CITY FROM SALESPEOPLE;

--35.	Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.
SELECT * FROM CUSTOMERS 
WHERE CNAME BETWEEN 'A' AND 'G';

--36.	Select all the possible combinations of customers that you can assign.
SELECT C1.*,C2.* FROM CUSTOMERS C1
CROSS JOIN CUSTOMERS C2
WHERE C1.CNUM <C2.CNUM ;

--37.	Select all orders that are greater than the average for October 4.
SELECT * FROM ORDERS
WHERE AMT > (SELECT AVG(AMT) FROM ORDERS 
             WHERE  EXTRACT(DAY FROM ODATE) = 4 AND EXTRACT(MONTH FROM ODATE)=10);

--38.	Write a select command using a correlated sub query that selects the names 
--and numbers of all customers with ratings equal to the maximum for their city.
SELECT CNUM,CNAME FROM CUSTOMERS C
WHERE C.RATING = (SELECT MAX(C1.RATING) FROM CUSTOMERS C1
                 WHERE C.CITY=C1.CITY );

--39.	Write a query that totals the orders for each day and places the results in descending order.
SELECT ODATE ,SUM(AMT) AS TOTAL_ORDERS FROM ORDERS
GROUP BY ODATE
ORDER BY TOTAL_ORDERS DESC ;

--40.	Write a select command that produces the rating followed by the name of each customer in San Jose.
SELECT RATING ,CNAME FROM CUSTOMERS
WHERE CITY = 'San Jose' ;


--41.	Find all orders with amounts smaller than any amount for a customer in San Jose.
 SELECT * FROM ORDERS
 WHERE AMT < ANY ( SELECT O.AMT FROM ORDERS O
                   JOIN CUSTOMERS C
                   ON C.CNUM =O.CNUM
                  WHERE C.CITY ='San Jose');
--42.	Find all orders with above average amounts for their customers.
SELECT * FROM ORDERS O
WHERE O.AMT > ( SELECT AVG(O1.AMT) FROM ORDERS O1
                 WHERE O.CNUM =O1.CNUM );
--43.	Write a query that selects the highest rating in each city.
SELECT CITY,MAX(RATING) AS HIGHEST_RATING FROM CUSTOMERS
GROUP BY  CITY ;
--44.	Write a query that calculates the amount of the salesperson’s 
--commission on order by a customer with a rating above 100.00.
 SELECT O.ONUM,S.SNUM,C.CNUM,C.RATING ,S.COMM,O.AMT ,
 (O.AMT * S.COMM )AS COMM_AMT
 FROM ORDERS O 
 JOIN CUSTOMERS C
 ON C.CNUM =O.CNUM
 JOIN SALESPEOPLE S
 ON S.SNUM=C.SNUM ; 
 
--45.	Count the customers with rating above San Jose’s average.
SELECT COUNT(RATING) FROM CUSTOMERS 
WHERE RATING > ( SELECT AVG(RATING) FROM CUSTOMERS
                   WHERE CITY = 'San Jose') ;
 
--46.	Write a query that produces all pairs of salespeople with themselves 
--as well as duplicate rows with the order reversed.
SELECT S1.*,S2.* FROM SALESPEOPLE S1
CROSS JOIN SALESPEOPLE S2
ORDER BY S1.SNUM,S2.SNUM ;

--48.	Find all salespeople with only one customer.
SELECT S.SNUM,S.SNAME,S.CITY FROM SALESPEOPLE S
JOIN CUSTOMERS C
ON S.SNUM =C.SNUM 
GROUP BY S.SNUM ,S.SNAME ,S.CITY 
HAVING COUNT(C.CNUM)=1;
-- USING SUBQUERY
SELECT SNUM,SNAME,CITY FROM SALESPEOPLE
WHERE SNUM IN ( SELECT SNUM FROM CUSTOMERS
                 GROUP BY SNUM
                 HAVING COUNT(SNUM)=1);
--49.	Write a query that joins the Customer table to itself to find 
--all pairs of customers served by a single salesperson.
SELECT C1.CNUM,C1.CNAME,C1.CITY,C2.CNUM,C2.CNAME,C2.CITY,C1.SNUM,C2.SNUM FROM CUSTOMERS C1
 JOIN CUSTOMERS C2
 ON C1.SNUM =C2.SNUM
 AND C1.CNUM <C2.CNUM ;

--50.	Write a query that will give you all orders for more than $1000.00.
SELECT * FROM ORDERS
WHERE AMT > 1000.00 ;

--51.	Write a query that lists each order number followed by 
--the name of the customer who made that order.
SELECT O.ONUM,C.CNAME FROM ORDERS O
JOIN CUSTOMERS C
ON C.CNUM=O.CNUM ;

--52.	Write 2 queries that select all salespeople (by name and number) who have customers in 
--their cities who they do not service, one using a join and one a correlated subquery. 
--Which solution is more elegant?
SELECT S.SNUM,S.SNAME FROM SALESPEOPLE S
JOIN CUSTOMERS C
ON C.SNUM =S.SNUM
AND C.CITY != S.CITY ;

SELECT SNUM,SNAME FROM SALESPEOPLE 
WHERE SNUM IN ( SELECT C.SNUM FROM CUSTOMERS C
                 JOIN SALESPEOPLE S
                 ON C.CITY != S.CITY);

--53.	Write a query that selects all customers whose ratings are equal than ANY (in the SQL sense) of Serres.
SELECT * FROM CUSTOMERS
WHERE RATING  = ANY ( SELECT RATING FROM CUSTOMERS C
                       JOIN SALESPEOPLE S
                       ON c.snum =s.snum
                       WHERE S.SNAME = 'SERRES');
--54.	Write2 queries that will produce all orders taken on October3 or October 4.
SELECT * FROM ORDERS 
WHERE EXTRACT(DAY FROM ODATE)=03 AND extract(MONTH FROM ODATE)=10
OR
 EXTRACT(DAY FROM ODATE)=03 AND EXTRACT(MONTH FROM ODATE) =10;

--55.	Write a query that produces all pairs of orders by a given customer. 
--Name that customer and eliminate duplicates.
SELECT 
    C.CNAME,
    O1.ONUM AS ORDER1,
    O2.ONUM AS ORDER2
FROM ORDERS O1
JOIN ORDERS O2
    ON O1.CNUM = O2.CNUM        -- same customer
    AND O1.ONUM < O2.ONUM       -- eliminate duplicate pairs
JOIN CUSTOMERS C
    ON C.CNUM = O1.CNUM;        -- get customer name
-- 56.	Find only those customers whose ratings are higher than every customer in Rome.
SELECT CNUM,CNAME,RATING FROM CUSTOMERS 
WHERE RATING > all (SELECT RATING FROM CUSTOMERS
                 WHERE CITY ='Rome');
--57.	Write a query on the customers table whose output will exclude all
-- customers with a rating < = 100.00, unless they are located in Rome.
SELECT CNUM,CNAME,RATING FROM CUSTOMERS 
WHERE RATING >100 OR CITY ='Rome' ;
                 
--58.	Find all rows from the Customer table for which the salesperson number is 1001.
SELECT * FROM CUSTOMERS
WHERE SNUM=1001;

--59.	Find the total amount in Orders for each salesperson for which this total
-- is greater than the amount of the largest order in the table.
SELECT SNUM, SUM(AMT) AS TOTAL_AMT FROM ORDERS
GROUP BY SNUM 
HAVING SUM(AMT)> ( SELECT MAX(AMT) AS LARGEST_ORDER  FROM ORDERS );

--60.	Write a query that selects all orders that have Zeroes or NULL in the Amount field.
SELECT * FROM ORDERS 
WHERE  AMT =0 ;

--61.	Produce all combinations of salespeople and customer names such that the
-- former precedes the latter alphabetically, and the latter has a rating of less than 200
SELECT S1. SNAME,C.CNAME FROM SALESPEOPLE S1
JOIN CUSTOMERS C
ON C.SNUM=S1.SNUM
WHERE C.RATING <200
ORDER BY S1.SNAME ASC;

--62.	List all salespeople’s names and the commission they have earned.
SELECT SNAME,COMM FROM SALESPEOPLE ;

--63.	Write a query that produces the names and cities of all customers with the same rating as Hoffman.
-- Write the query using Hoffman’s CNUM rather than his rating, so that it would still be 
--usable if his rating changed.
SELECT CNAME,CITY,rating FROM CUSTOMERS
WHERE RATING = (SELECT RATING FROM CUSTOMERS
                 WHERE CNAME= 'hoffman') ;
--64.	Find all salespeople for whom there are customers that follow them in alphabetical order.
SELECT DISTINCT S.SNAME FROM SALESPEOPLE S
JOIN CUSTOMERS C
ON S.SNUM=C.SNUM
WHERE C.CNAME > S.SNAME;

--65.	Write a query that produces the names and ratings of all customers of all who have above average orders.
SELECT DISTINCT CNAME,RATING FROM CUSTOMERS C
JOIN ORDERS O
ON O.CNUM =C.CNUM
WHERE AMT > (SELECT AVG(AMT) FROM ORDERS);

--66.	Find the sum of all purchases from the Orders table.
SELECT SUM(AMT) AS TOTAL_PURCHASES FROM ORDERS;

--67.	Write a select command that produces the order number, amount, and date for all rows in the Order table.
SELECT ONUM,AMT,ODATE FROM ORDERS;

--68.	Count the number of not null rating fields in the Customer table including duplicates.
SELECT COUNT(RATING) FROM CUSTOMERS
WHERE RATING IS NOT NULL ;

--69.	Write a query that gives the names of both the salesperson and the
-- customer for each order after the order number.
SELECT C.CNAME,S.SNAME ,O.ONUM FROM ORDERS O
JOIN CUSTOMERS C
ON C.CNUM=O.CNUM
JOIN SALESPEOPLE S
ON S.SNUM=C.SNUM ;

--70.	List the commissions of all salespeople servicing customers in London.
SELECT COMM FROM SALESPEOPLE 
WHERE CITY ='LONDON';

--71.	Write a query using ANY or ALL that will find all salespeople who have no customers located in their city.
SELECT *
FROM SALESPEOPLE S
WHERE S.CITY <> ALL (
        SELECT C.CITY 
        FROM CUSTOMERS C
        WHERE C.SNUM = S.SNUM
      );
--72.	Write a query using the EXISTS operator that selects all salespeople with 
--customers located in their cities who are not assigned to them.
SELECT  * FROM SALESPEOPLE S 
WHERE EXISTS (SELECT 1 FROM CUSTOMERS C
               WHERE C.CITY =S.CITY 
               AND  C.SNUM <> S.SNUM); 

--73.	Write a query that selects all customers serviced by Peel or Motika.
SELECT * FROM  CUSTOMERS C
JOIN SALESPEOPLE S
ON S.SNUM = C.SNUM
WHERE S.SNAME = 'PEEL' OR S.SNAME ='MONIKA' ; 


--74.	Count the number of salespeople registering orders for each day. 
--(If a salesperson has more than one order on a given day, he or she should be counted only once.).
SELECT O.ODATE, COUNT(  DISTINCT S.SNUM) AS NO_OF_SALESPEOPLE FROM SALESPEOPLE S
JOIN ORDERS O
ON S.SNUM=O.SNUM 
GROUP BY O.ODATE ;

--75.	Find all orders attributed to salespeople in London.
SELECT O.* FROM ORDERS O 
JOIN SALESPEOPLE S
ON S.SNUM=O.SNUM
WHERE S.CITY ='LONDON' ;

--76.	Find all orders by customers not located in the same cities as their salespeople.
SELECT O.* FROM ORDERS O
JOIN CUSTOMERS C
ON C.CNUM =O.CNUM
JOIN SALESPEOPLE S
ON S.SNUM = C.SNUM
WHERE S.CITY <> C.CITY;

--77.	Find all salespeople who have customers with more than one current order.
SELECT S.SNUM,S.SNAME,S.CITY  FROM SALESPEOPLE S 
JOIN CUSTOMERS C
ON S.SNUM =C.SNUM 
JOIN ORDERS O
ON C.CNUM=O.CNUM
GROUP BY  S.SNUM,S.SNAME,S.CITY,C.CNUM
HAVING COUNT(O.ONUM) >1 ;

--78.	Write a query that extracts from the Customer table every customer assigned to a
-- salesperson who currently has at least one other customer (besides the customer being selected) with orders in the Orders table.

SELECT C.CNUM,C.CNAME FROM CUSTOMERS C
WHERE EXISTS ( SELECT 1 FROM CUSTOMERS C2
               JOIN ORDERS O
               ON C2.CNUM=O.CNUM
               WHERE C2.SNUM = C.SNUM
               AND C.CNUM <> C2.CNUM );
--79.	Write a query that selects all customers whose name begins with ‘C’.
SELECT * FROM CUSTOMERS 
WHERE CNAME LIKE 'C%';

--80.	Write a query on the Customers table that will find the highest rating in each city. 
--Put the output in this form:  for the city (city) the highest rating is : (rating).
SELECT 
    'For the city ' || C.CITY || ' the highest rating is: ' || MAX(C.RATING) 
        AS HIGHEST_RATING
FROM CUSTOMERS C
GROUP BY C.CITY;
--81.	Write a query that will produce the Snum values of all salespeople with orders 
--currently in the Orders table without any repeats.
SELECT DISTINCT SNUM
FROM ORDERS;

--82.	Write a query that lists customers in descending order of rating. 
--Output the rating field first, followed by the customers’ names and numbers.
SELECT RATING ,CNAME,CNUM FROM CUSTOMERS
ORDER BY RATING DESC ;

--83.	Find the average commission for salespeople in London.
SELECT AVG(COMM) AS AVERAGE_COMM FROM SALESPEOPLE 
WHERE CITY = 'LONDON';

--84.	Find all orders credited to the same salesperson that services Hoffman.
SELECT * FROM ORDERS
WHERE SNUM = (SELECT SNUM FROM CUSTOMERS
              WHERE CNAME= 'hoffman');
              
--85.	Find all salespeople whose commission is in between 0.10 and 0.12 both inclusive.
SELECT * FROM SALESPEOPLE 
WHERE COMM BETWEEN 0.10 AND 0.12;

--86.	Write a query that will give you the names and cities of all salespeople in 
--London with commission above 0.10
SELECT SNAME,CITY FROM SALESPEOPLE 
WHERE CITY ='LONDON' AND COMM >0.10 ;

--87.	What will be the output from the following query? 
SELECT * FROM ORDERS WHERE (AMT < 1000 OR NOT (EXTRACT (DAY FROM ODATE )= 03 AND EXTRACT(MONTH FROM ODATE)=10  AND CNUM > 2003));

--88.	Write a query that selects each customer’s smallest order.
SELECT MIN(O.AMT) AS SMALLEST_ORDER ,C.CNAME FROM ORDERS O
JOIN CUSTOMERS C
ON C.CNUM=O.CNUM
GROUP BY C.CNAME;

--89.	Write a query that selects the first customer in alphabetical order whose name begins with ‘G’.
SELECT CNAME FROM
(SELECT CNAME FROM CUSTOMERS 
WHERE CNAME LIKE 'G%'
ORDER BY CNAME ASC)
WHERE ROWNUM =1 ;

--90.	Write a query that counts the number of different not NULL city values in the Customers table.
SELECT COUNT(DISTINCT CITY) AS NO_OF_CITY FROM CUSTOMERS
WHERE CITY IS NOT NULL;

--91.	Find the average amount from the Orders table.
SELECT AVG(AMT) AS AVERAGE_AMOUNTS FROM  ORDERS ;

--92.	What would be the output from the following query?
SELECT * FROM ORDERS WHERE NOT  (EXTRACT(DAY FROM ODATE)=03 AND EXTRACT(MONTH FROM ODATE)=10 OR Snum>1006) AND amt>=1500;

--93.	Find all customers who are not located in San Jose & whose rating is above 200.
SELECT * FROM CUSTOMERS 
WHERE CITY<>'San Jose' AND RATING >200;

--94.	Give a simpler way to write this query:
SELECT Snum, Sname, city, Comm FROM salespeople
 WHERE COMM = 0.13;

--95.	Evaluate the following query:
SELECT * FROM orders WHERE NOT ((EXTRACT(DAY FROM ODATE)=03 AND EXTRACT( MONTH FROM ODATE)=10 AND Snum>1002) OR amt>2000);

--96.	Which salespeople attend to customers not in the city they have been assigned to?
SELECT S.SNUM,S.SNAME,C.CITY,S.CITY FROM SALESPEOPLE S
JOIN CUSTOMERS C
ON S.SNUM=C.SNUM
WHERE C.CITY <>S.CITY ;

--97.	Which salespeople get commission greater than 0.11 and serving customers rated less than 250?
SELECT S.SNUM,S.SNAME FROM SALESPEOPLE S
JOIN CUSTOMERS C
ON S.SNUM=C.SNUM
WHERE S.COMM >0.11 AND C.RATING <250;

--98.	Which salespeople have been assigned to the same city but get different commission percentages?
SELECT DISTINCT S.SNUM,S.SNAME FROM SALESPEOPLE S
JOIN SALESPEOPLE S1
ON S.CITY = S1.CITY
 AND S.COMM<> S1.COMM 
 AND S.SNUM <> S1.SNUM;
 
--99.	Which salesperson has earned the most by way of commission?
SELECT SNUM FROM SALESPEOPLE
WHERE COMM =( SELECT MAX(COMM) FROM SALESPEOPLE);

--100.	Does the customer who has placed the maximum number of orders have the maximum rating?
WITH ORDER_COUNT AS(
SELECT CNUM, COUNT(*) AS TOTAL_ORDERS FROM ORDERS
GROUP BY CNUM 
)
,
 MAX_NUMBER_ORDERS AS(
SELECT CNUM FROM ORDER_COUNT
WHERE TOTAL_ORDERS = (SELECT MAX(TOTAL_ORDERS) FROM ORDERS)
),
 MAX_RATING_CUSTOMER AS(
   SELECT CNUM FROM CUSTOMERS
   WHERE RATING = (SELECT MAX(RATING) FROM CUSTOMERS)
   )
SELECT
CASE 
  WHEN EXISTS ( SELECT 1 FROM MAX_NUMBER_ORDERS MNO
                JOIN MAX_RATING_CUSTOMER MRC
                ON MNO.CNUM = MRC.CNUM )
                THEN 'YES'
                ELSE 'NO'
        END AS RESULT
        FROM DUAL;

--101.	Has the customer who has spent the largest amount of money been given the highest rating?
WITH TOTAL_SPENT AS(
SELECT CNUM,SUM(AMT) AS TOTAL_AMOUNT FROM ORDERS
GROUP BY CNUM
),
MAX_SPENT_CUSTOMER AS (
    SELECT CNUM
    FROM TOTAL_SPENT
    WHERE TOTAL_AMOUNT = (SELECT MAX(TOTAL_AMOUNT) FROM TOTAL_SPENT)
),
MAX_RATING_CNUM AS (
SELECT CNUM FROM CUSTOMERS
WHERE RATING = (SELECT MAX(RATING) FROM CUSTOMERS)
)
  SELECT 
  CASE
      WHEN EXISTS( SELECT  1 FROM TOTAL_SPENT TS
                   JOIN MAX_RATING_CNUM MRC
                   ON TS.CNUM = MRC.CNUM)
                  THEN 'YES'
                    ELSE 'NO'
                   END AS RESULT
                   FROM DUAL;
--102.	List all customers in descending order of customer rating.
SELECT * FROM CUSTOMERS 
ORDER BY RATING DESC ;

--103.	On which days has Hoffman placed orders?
SELECT O.ODATE FROM ORDERS O
JOIN CUSTOMERS C
ON C.CNUM=O.CNUM
WHERE C.CNAME ='HOFFMAN' ;
--
SELECT ODATE FROM ORDERS
WHERE CNUM = (SELECT CNUM FROM CUSTOMERS
               WHERE CNAME = 'HOFFMAN');
--104.	Do all salespeople have different commission?
SELECT COMM
FROM SALESPEOPLE
GROUP BY COMM
HAVING COUNT(*) > 1;

--105.	Which salespeople have no orders between 10/03/1996 and 10/05/1996?
SELECT SNUM ,SNAME FROM SALESPEOPLE S
WHERE NOT EXISTS ( SELECT 1 FROM ORDERS O
                   WHERE S.SNUM =O.SNUM
                   AND ODATE BETWEEN '10/03/2096' AND '10/05/2096');
--106.	How many salespersons have succeeded in getting orders?
SELECT COUNT(DISTINCT SNUM) AS TOTAL_SALESPEOPLE FROM ORDERS;

--107.	How many customers have placed orders?
SELECT COUNT(DISTINCT CNUM) FROM ORDERS;

--108.	On which date has each salesperson booked an order of maximum value?
SELECT SNUM, ODATE
FROM ORDERS O
WHERE AMT = (
    SELECT MAX(AMT)
    FROM ORDERS
    WHERE SNUM = O.SNUM
);
SELECT SNUM, ODATE
FROM (
    SELECT SNUM, ODATE, AMT,
           RANK() OVER (PARTITION BY SNUM ORDER BY AMT DESC) AS RN
    FROM ORDERS
)
WHERE RN = 1;
--109.	Who is the most successful salesperson?
SELECT snum, sname, total_sales
FROM (
    SELECT s.snum,
           s.sname,
           SUM(o.amt*S.COMM) AS total_sales,
           RANK() OVER (ORDER BY SUM(o.amt*S.COMM) DESC) rnk
    FROM salespeople s
    JOIN orders o
      ON s.snum = o.snum
    GROUP BY s.snum, s.sname
)
WHERE rnk = 1;


--110.	Who is the worst customer with respect to the company?
SELECT CNUM ,CNAME,TOTAL_SPENT FROM
( SELECT C.CNUM ,C.CNAME ,SUM(O.AMT)AS TOTAL_SPENT ,RANK() OVER (ORDER BY SUM(O.AMT) ASC )AS RN
FROM CUSTOMERS C
JOIN ORDERS O
ON C.CNUM = O.CNUM 
GROUP BY C.CNUM,C.CNAME
)
WHERE RN =1 ;
SELECT * FROM CUSTOMERS;
--111.	Are all customers not having placed orders greater than 200 totally been serviced by 
--salesperson Peel or Serres?
SELECT CASE
       WHEN NOT EXISTS (
            SELECT 1
            FROM CUSTOMERS C
            JOIN ORDERS O ON C.CNUM = O.CNUM
            JOIN SALESPEOPLE S ON S.SNUM = C.SNUM
            GROUP BY C.CNUM, S.SNAME
            HAVING MAX(O.AMT) <= 200
               AND S.SNAME NOT IN ('PEEL', 'SERRES')
       )
       THEN 'YES'
       ELSE 'NO'
END AS RESULT
FROM DUAL;

--112.	Which customers have the same rating?
SELECT * FROM CUSTOMERS
WHERE RATING IN ( SELECT RATING FROM CUSTOMERS
                   GROUP BY RATING 
                   HAVING COUNT(RATING)>1)
   ORDER BY RATING;
--113.	Find all orders greater than the average for October 4th.
SELECT * FROM ORDERS
WHERE AMT > (SELECT AVG(AMT) FROM ORDERS
             WHERE  EXTRACT(DAY FROM ODATE)=04);
--114.	Which customers have above average orders?
SELECT DISTINCT C.* FROM CUSTOMERS C
JOIN ORDERS O
ON C.CNUM = O.CNUM
WHERE O.AMT > ( SELECT AVG(AMT) FROM ORDERS ) ;
--OR
SELECT * FROM CUSTOMERS C
WHERE EXISTS ( SELECT 1 FROM ORDERS O
               WHERE O.CNUM= C.CNUM
               AND O.AMT > (SELECT AVG(AMT) FROM ORDERS));
--115.	List all customers with ratings above San Jose’s average.
SELECT * FROM CUSTOMERS
WHERE RATING > (SELECT AVG(RATING) FROM CUSTOMERS
                WHERE CITY ='San Jose' );
--116.	Select the total amount in orders for each salesperson for which the total is 
--greater than the amount of the largest order in the table.
SELECT SNUM ,SUM(AMT) AS TOTAL_AMOUNT FROM ORDERS
GROUP BY SNUM
HAVING SUM(AMT) >( SELECT MAX(AMT) AS LARGEST_AMOUNT FROM ORDERS);

--117.	Give names and numbers of all salesperson that have more than one customer.
SELECT S.SNUM,S.SNAME,COUNT(C.CNUM) FROM SALESPEOPLE S
JOIN CUSTOMERS C
ON S.SNUM=C.SNUM
GROUP BY S.SNUM,S.SNAME
HAVING COUNT(CNUM)>1 ;

--118.Select all salesperson by name and numbers who have customers in their city whom they don’s the service.
SELECT S.SNUM,SNAME  FROM SALESPEOPLE S
JOIN CUSTOMERS C
ON S.SNUM<>C.SNUM
WHERE S.CITY = C.CITY;

--119.	Which customers’ rating should be lowered?
SELECT DISTINCT C.CNAME
FROM CUSTOMERS C
JOIN ORDERS O
  ON C.CNUM = O.CNUM
WHERE O.AMT < (SELECT AVG(AMT) FROM ORDERS);

--120.	Is there a case for assigning a salesperson to Berlin?
SELECT *
FROM CUSTOMERS
WHERE CITY = 'Berlin'
AND SNUM IS NULL;


--121.	Is there any evidence linking the performance of a salesperson to 
--commission that he or she is being paid?
SELECT S.SNUM,S.SNAME,S.COMM ,
COUNT(O.ONUM) AS TOTAL_ORDERS,
COUNT(O.AMT) AS TOTAL_SALES
FROM SALESPEOPLE S
LEFT JOIN CUSTOMERS C
ON C.CNUM =S.SNUM
LEFT JOIN ORDERS O
ON O.ONUM =S.SNUM
GROUP BY S.SNUM,S.SNAME,S.COMM 
ORDER BY S.COMM DESC ;

--122.	Dose the total amount in orders by customer in Rome and London exceeds the commission 
--paid to salesperson in London and New York by more than 5 times?
SELECT
    CASE
        WHEN
            (
                SELECT SUM(AMT)
                FROM ORDERS
                WHERE CNUM IN (
                    SELECT CNUM
                    FROM CUSTOMERS
                    WHERE CITY IN ('Rome', 'London')
                )
            )
            >
            5 *
            (
                SELECT SUM(O.AMT * S.COMM)
                FROM ORDERS O
                JOIN SALESPEOPLE S
                    ON O.SNUM = S.SNUM
                WHERE S.CITY IN ('London', 'New York')
            )
        THEN 'YES'
        ELSE 'NO'
    END AS RESULT
FROM DUAL;


--123.	Which is the date, order number, amt and city for each salesperson (byname
--) for   the maximum order he has obtained?
SELECT O.ODATE,O.ONUM,O.AMT,S.CITY,S.SNAME FROM ORDERS O
JOIN SALESPEOPLE S
ON S.SNUM =O.SNUM
WHERE O.AMT = ( SELECT MAX(O2.AMT) FROM ORDERS O2
               WHERE O.SNUM =O2.SNUM );


--124.	Which salesperson(s) should be fired?
SELECT * FROM SALESPEOPLE S
WHERE NOT EXISTS ( SELECT 1 FROM CUSTOMERS C
                   WHERE C.CNUM= S.SNUM);

SELECT S.* FROM SALESPEOPLE S
LEFT JOIN CUSTOMERS C
ON C.CNUM=S.SNUM 
WHERE C.CNUM IS NULL;
--125.	What is the total income for the company? 
 --TOTAL INCOME = TOTAL(AMT)- TOTAL(COMM)
SELECT SUM(O.AMT) AS TOTAL_AMOUNT,
SUM(O.AMT*S.COMM)AS TOTAL_COMM ,
SUM(O.AMT)-SUM(O.AMT*S.COMM)AS TOTAL_INCOME FROM ORDERS O
JOIN SALESPEOPLE S
ON S.SNUM =O.SNUM ;

SELECT *
FROM ORDERS
WHERE ODATE >= CURRENT_DATE - INTERVAL '30' DAY;


SELECT *
FROM HR.EMPLOYEES
WHERE TO_CHAR(hire_date, 'DY') IN ('SAT', 'SUN');

