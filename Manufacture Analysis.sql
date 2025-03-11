-- Manufacturing Analysis
Create database Manufacture;
use Manufacture; 
Select * from mdetails; 

-- total manyfacture qty 
select sum(ManufacturedQty) as Manufacture_Qty
from mdetails; 

-- total rejected qty 
select sum(RejectedQty) as Rejected_Qty 
from mdetails; 

-- total Processed Qty 
select sum(ProcessedQty) as Processed_Qty
from mdetails; 

-- total wastage percentahe
select sum(RejectedQty)/sum(ProcessedQty) *100 as wastage_percentage
from mdetails;

-- Top 10 Emply wise RejectionQty
select EmpName,sum(RejectedQty) as Total_Rejection_By_employ
from mdetails
Group by Empname
order by Total_Rejection_By_employ desc
limit 10;

select * from mdetails; 

-- top 10 Machine wise rejected Qty
select MachineCode,sum(RejectedQty) as Total_Rejection
from mdetails
Group by MachineCode
order by Total_Rejection desc
limit 10;

-- Average Cost Of Top 5 machine Per day
select sum(PerdayMachineCost)/count(*) as Aver_Cost_of_Machine_PerDay,MachineCode
from mdetails
group by MachineCode
order by Aver_Cost_of_Machine_PerDay desc
limit 5;

-- Department wise rejected qty
select sum(RejectedQty), DepartmentName
from mdetails
group by DepartmentName;

-- Detpartment Wise Manufactured and Rejected
select DepartmentName, sum(ManufacturedQty)as Manufactured_Qty ,sum(RejectedQty) as Rejected_Qty
from mdetails
group by DepartmentName; 

select * from mdetails; 

-- Fiscal Date wise rejected qty and manufactured qty
select FiscalDate,sum(ManufacturedQty) as Manufactured_Qty,sum(RejectedQty) as Rejected_Qty
from mdetails
group by FiscalDate
order by FiscalDate;  

-- Production Trend
select FiscalDate,sum(ProducedQty) as Production_Qty
from mdetails
group by FiscalDate
order by FiscalDate;  

-- Department wise Delivered
select DepartmentName,count(DeliveryPeriod)
from mdetails 
group by DepartmentName; 

-- I am creating a stored procedure where when we write the employ name it should give the total Rejected Qty from that employ
delimiter //
create procedure s_p_7(in e_name varchar(20))
begin
select EmpName,sum(RejectedQty) as Total_Rejected_Qty
from mdetails
where EmpName=e_name
group by EmpName;
end //
delimiter ; 

select * from mdetails;
-- Example
call s_p_7('ASHISH'); 

-- Top 5 Most rejected product
select ItemName,sum(RejectedQty)
from mdetails
group by ItemName
order by sum(RejectedQty) desc
limit 5;

select * from mdetails; 

-- work center wise produced qty
select WorkCentreName,sum(ProducedQty) as Total_ProducedQty
from mdetails
group by WorkCentreName;


