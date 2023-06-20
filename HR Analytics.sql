Select * from hrdata

--emplyee count
select sum(employee_count) as Employee_Count from hrdata
where department = 'Sales'

--Attrition Count
select count(attrition) from hrdata where attrition='Yes'

--Attrition Rate
select round (((select count(attrition) from hrdata where attrition='Yes')/ 
sum(employee_count)) * 100,2) from hrdata

--Active Employee
select sum(employee_count) - (select count(attrition) from hrdata  where attrition = 'Yes' and gender = 'Male') from hrdata where gender = 'Male'

--Average Age
select round(avg(age),0) from hrdata

--Attrition by Gender
select gender, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by gender --When ever there is aggregation of more two or more indexes)
order by count(attrition) desc --by default its aescending
-- excecution sequence 1->where 2->group by 3->order by

--On department basis
select department, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by department

--Job Satisfaction
CREATE EXTENSION IF NOT EXISTS tablefunc
SELECT * FROM crosstab
(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role

