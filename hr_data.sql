create database hr_project;
use hr_project;
select * from hr;

-- 1.Display the first 10 rows from the table. 
select * from hr limit 10;

-- 2.Find the total number of employees in the company. 
select count(employeecount) from hr;

-- 3.List all unique departments. 
select distinct(department) from hr;

-- 4.Show how many employees have left the company and how many are still working. 
select count(attrition) from hr where attrition ='yes';

-- 5.Retrieve the list of employees who work overtime.
 select employeenumber from hr where overtime='YES';

-- 6.Find the average monthly income of all employees. 
select avg(monthlyincome) from hr;

-- 7.Identify employees whose number of companies worked is missing (NULL). 
select * from hr where numcompaniesworked is null;

-- 8.Find the employee(s) with the maximum monthly income.
select * from hr  where monthlyincome=(select max(monthlyincome) from hr);

-- 9.Count the number of employees by gender.
select gender,count(gender) from hr group by gender;

-- 10.List all employees who have just joined (YearsAtCompany = 0). 
select * from hr where yearsatcompany=0;

-- 11.Calculate the attrition rate (%) by department. 
SELECT department,
	sum(case when attrition ="yes" then 1 else 0 end )*100/count(*) as attrition_rate
from hr
group by department;

-- 12.List the top 10 employees with the highest total working years. 
select * from hr order by totalworkingyears desc limit 10;

-- 13.Group employees into tenure categories (<1yr, 1–3yr, 4–6yr, 7+yr) and count employees in each. 
select case when totalworkingyears<1 then '<1'
when totalworkingyears between 1 and 3 then '1-3' 
when totalworkingyears between 4 and 6 then '4-6'
else '7+'
end as totalworkingyears,count(*) as count from hr group by 
 case when totalworkingyears<1 then '<1'
when totalworkingyears between 1 and 3 then '1-3' 
when totalworkingyears between 4 and 6 then '4-6'
else '7+'  end order by count ; 


-- 14.Find the average monthly income by job level and attrition status. 
select attrition,joblevel,avg(monthlyincome) as avg_monthly_income from hr group by attrition,joblevel order by avg(monthlyincome);

-- 15.Identify the top 5 job roles with the highest number of employees who left. 
select jobrole,sum(case when attrition ="yes" then 1 else 0 end) as left_employees from hr group by jobrole order by left_employees;

-- 16.List employees who left the company within their first year. 
select * from hr where totalworkingyears=1 and attrition='yes';

-- 17.Calculate each employee’s approximate new monthly compensation after applying their salary hike percentage. 
select employeenumber,ROUND(monthlyincome+(monthlyincome*percentsalaryhike/100),2) as new_monthly_compensaation from hr;

-- 18.Count employees grouped by overtime status and attrition. 
select count(employeenumber) as count from hr where overtime='Yes' and attrition='yes';

-- 19.Display the top 10 employees who attended the most training sessions last year. 
select employeenumber,TrainingTimesLastYear from hr order by TrainingTimesLastYear desc limit 10 ;

-- 20.Rank employees by total working years (most experienced = rank 1). 
select employeenumber,dense_rank() over(order by totalworkingyears desc) as rank_no from hr;