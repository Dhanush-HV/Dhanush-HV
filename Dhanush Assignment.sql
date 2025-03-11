-- 1a.	Fetch the employee number, first name and last name of those employees who are working as Sales Rep reporting to employee with employeenumber 1102 
select employeeNumber,firstname,lastname
from employees
where reportsTo=1102; 
-- 1b.	Show the unique productline values containing the word cars at the end from the products table.
select productline
from productlines
where productLine like "%Cars"; 

-- 2a. Using a CASE statement, segment customers into three categories based on their country:(Refer Customers table)
select customernumber,customername,
case
when Country in ("USA" ,"Canada")then "NorthAmerica"
when Country in ("uk","france",'Germany') then "Europe"
else "others"
end as customer_Segment
from customers; 

-- 3a.	Using the OrderDetails table, identify the top 10 products (by productCode) with the highest total order quantity across all orders.
select productCode,sum(quantityOrdered) as total_ordered
from orderdetails
group by productCode
order by  total_ordered desc
limit 10; 
-- 3b payment_count based on month wise
select monthname(paymentdate) as month_name,
count(*) as num_payments
from payments
group by monthname(paymentdate)
having num_payments>20
order by num_payments desc; 

-- 4a Creating a new data base
 create database Customers_Orders;
 use Customers_Orders;
 -- to create a table
 create table customer
 (customer_id int(6) primary key auto_increment,
 first_name varchar(50) not null,
 last_name varchar(50) not null,
 email varchar(225) unique ,
 ph_no varchar(20) unique);
 -- insert records
 insert  into customer values
 (78945,'Prakesh','Kumar','prakesh@123gmail.com',9480079248);
 select * from customer; 
 -- 4b create a order table
 CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary key with auto-increment
    customer_id INT,                         -- Foreign key referencing Customers table
    order_date DATE NOT NULL,                -- Date of the order
    total_amount DECIMAL(10,2) CHECK (total_amount > 0), -- Total amount with a check constraint

    -- Foreign key constraint
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 5a. List the top 5 countries (by order count) that Classic Models ships to. (Use the Customers and Orders tables)
select c.country , count(ordernumber) as order_count
from customers c 
join orders o on c.customernumber=o.customerNumber
group by
c.country
order by order_count desc
limit 5;  
 
-- 6a. Create a table project with below fields.
use classicmodels;
create table project
(employid int auto_increment primary key,
fullname varchar(20) not null,
gender varchar(10) check(gender in('male','female')),
managerid int null );
-- insert records
insert into project value
(1,'Pranaya','Male',3),
(2,'Priyanka','Female',1),
(3,'Preety','Female', null),
(4,'Anurag','Male',1),
(5,'Sambit','Male',1),
(6,'Rajesh','Male',3),
(7,'Hina','Female',3);
-- 6b
select m.fullname as managername,e.fullname as emplyname
from project e
join project m on m.employid=e.managerid;

-- Q7. DDL Commands: Create, Alter, Rename 
CREATE TABLE FACILITY_1
(FAVILITY_ID INT NOT NULL,
NAME VARCHAR(100) ,
STATE VARCHAR(100),
COUNTRY varchar(100));
DESC facility_1;
ALTER TABLE FACILITY_1
modify FACILITY_1 INT PRIMARY KEY auto_increment;
DESC facility_1 ;
ALTER TABLE facility_1
ADD  COLUMN (CITY varchar(100));
DESC facility_1; 

-- Q8. Views in SQL
create view product_category_sales as 
select pl.productline as productline,
sum(od.quantityOrdered*od.priceEach)as Total_Sales,
count(distinct o.orderNumber)as Number_Of_Orders
from productlines as pl
join products as p on pl.productline=p.productline
join orderdetails as od on od.productCode=p.productCode
join orders as o on od.orderNumber=o.orderNumber
group by pl.productline;

select * from product_category_sales;

-- Q9. Stored Procedures in SQL with parameters
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_country_payments`(in Yr int, in country varchar(30))
BEGIN
Select Yr as year,country as country, concat(round(sum(pp.amount/1000),0),"K") as Total_amount
from payments as pp
join customers as cs on cs.customerNumber=pp.customerNumber
where year(pp.paymentDate)=Yr and (cs.country)=country;
END

-- 10a. Using customers and orders tables, rank the customers based on their order frequency
Select CS.customerName as customerName, count(OD.orderNumber) as Order_Count, 
dense_rank() over(order by count(OD.orderNumber) Desc) as order_frequency_rnk
from customers as CS
join
orders as OD on OD.customerNumber=CS.customerNumber
group by CS.CustomerName;
-- 10b.Calculate year wise, month name wise count of orders and year over year (YoY) percentage change. Format the YoY values in no decimals and show in % sign.
select year(orderDate) as Year,  monthname(orderDate) as Month,
       		count(orderDate) as Total_Sales,
concat(round(((count(orderDate)-lag(count(orderDate),1) over())/lag(count(orderDate),1) over())*100),"%") as "% YOY Change"
     		from orders
       		group by Year, Month;

-- 11a. Find out how many product lines are there for which the buy price value is greater than the average of buy price value. Show the output as product line and its count.
select productline, count(*) as total 
from products
where buyprice > (select avg(buyPrice) from products)
group by productline
order by total desc;
 
 -- Q12. ERROR HANDLING in SQL  
 CREATE DEFINER=`root`@`localhost` PROCEDURE `Employee`(EID int,Ename varchar(30),Email varchar(30))
BEGIN
declare continue handler for 1048
begin
insert into error_report (EmpName,Emp_Email,Error_Message) values (Ename,Email,"Error Occured");
end;
insert into EMP_EH values (EID,Ename,Email);
END 

-- Q13. TRIGGERS
CREATE DEFINER=`root`@`localhost` TRIGGER `emp_bit_BEFORE_INSERT` BEFORE INSERT ON `emp_bit` FOR EACH ROW 
BEGIN
if new.Working_Hours<0 then
set new.Working_Hours=- new.Working_Hours;
end if;
END

	After Before Insert Command:
Entered Value: INSERT INTO Emp_BIT VALUES ("Ravi", "Trainer", '2020-10-04', "-10");











                     
