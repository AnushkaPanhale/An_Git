use  employees;

#write a query to get the coun tof all the unique names present in your employee table

select * from employees;
select first_name,count(first_name) from employees
group by 1 order by 2 desc;

#add a new col (Age_at_hiring) based on hiredate and birthdate use only the year part for calculation

select *,substr(hire_date,3,4) - substr(birth_date,3,4) as Age_at_hiring from employees;

#write a query which adds a new col salary caterory (low,medium,high)
#based on condition if salary less than 50000 'low'
#from 50000 to 75000 medium else high

select *, 
case
when salary < 50000 then 'low'
when salary between 50000 and  75000 then ' medium'
else 'high'
end as salary_category
from salaries;
#write a query which adds a new col s caterory (entry level, mid level, management level)
#based on condition if
#eng,staff or ass eng--> entry level
#tech lead and manager -->mgmt level

select *,
case 
when title in ('engineer','staff','assistant engineer') then 'entry level'
when title in ('engineer','assistant engineer') then 'entry level'
when title in ('senior staff', 'senior engineer') then 'mid level'
when title in('technical lead','Manager' ) then 'management level'
end as category
from titles;

#get the emp_no firstname, last name for all the managers

select e.emp_no,e.first_name,e.last_name,t.title
from employees as e
inner join 
titles as t on (e.emp_no = t.emp_no)
where title ='Manager';

#get first name , last name ,title from all the empolyees who are either or egg or ass egg

select e.emp_no,e.first_name,e.last_name,t.title
from employees as e
inner join 
titles as t on (e.emp_no = t.emp_no)
where title in('Engineer','Assistant Engineer');

#write a query to emp_no,first_name,last name avg salary for all employees

select e.emp_no,e.first_name,e.last_name,avg(s.salary)
from employees as e
inner join
salaries as s on (e.emp_no = s.emp_no)
group by 1 order by 4 ;

#empno ,first name last name avg salary only for those employees who are manager

select e.emp_no,e.first_name,e.last_name,avg(s.salary),t.title
from employees as e
inner join 
salaries as s on ( e.emp_no = s.emp_no)
inner join 
titles as t on ( s.emp_no = t.emp_no)
where title = 'manager'
group by 1 order by 3;

# by using dept_manager table

select e.emp_no,e.first_name,e.last_name,round(avg(s.salary),2) as avg_salary
from employees as e
inner join
salaries as s on (e.emp_no = s.emp_no)
inner join
dept_manager as dm on(e.emp_no = dm.emp_no)
group by 1 order by 4 desc;

#write query first name , last name ,birth date for all the emp who are senior engg working in production department

select e.emp_no,e.first_name,e.last_name,e.birth_date,t.title,d.dept_name,de.dept_no
from employees as e
inner join
titles as t on (t.emp_no = e.emp_no)
inner join
dept_emp as de on ( t.emp_no = de.emp_no)
inner join
departments as d on (d.dept_no = de.dept_no)
where title in ('Senior Engineer') and d.dept_name in ('Production');

#write query first name , last name ,birth date for all the emp who are senior engg working in production department

select e.emp_no,e.first_name,e.last_name,e.birth_date,t.title,d.dept_name
from employees as e
inner join
titles as t on (e.emp_no = t.emp_no)
inner join 
dept_emp as de on(t.emp_no = de.emp_no)
inner join
departments as d on (de.dept_no = de.dept_no)
where title ='Senior Engineer' and dept_name='Production'
group by 2 order by 1 ;

# write a query emp_no first name last name dept no dept name avg salary for all the managers

select e.emp_no,e.first_name,e.last_name,d.dept_no,d.dept_name,avg(s.salary) as Avg_salary,t.title
from employees as e
inner join
titles as t on (e.emp_no = t.emp_no)
inner join 
salaries as s on ( t.emp_no = s.emp_no)
inner join 
dept_emp as de on (s.emp_no = de.emp_no)
inner join 
departments as d on (de.dept_no = d.dept_no)
where title = 'Manager' and dept_name='Sales'
group by 1 order by 6 desc;

#FIND SECOND THIRED HIGHEST SALARY USING SUB QUERY

#3rd highest
select max(salary) from salaries
where salary <(select max(salary) from salaries
where salary <(select max(salary) from salaries));

#2 highest
select max(salary) from salaries
where salary <( select  max(salary) from salaries);

#EMP NO FIRST NAME LAST NAME ONLY FOR MANAGER NOT USING JOIN USE SUB QUERY

#USING DEPT MANAGER TABLE
select emp_no ,first_name,last_name from employees
where emp_no in(select emp_no from dept_manager);


#USING TITLES TABLE
select emp_no ,first_name,last_name from employees
where emp_no in(select emp_no from titles where title ='manager');

#WRITE A QUERY AND GET EMP NO AND AVG SALARY
#WHICH IS MORE THAN GRAND AVG

select emp_no,round(avg(salary)) from salaries
group by 1
having round(avg(salary)) >(select round(avg(salary)) from salaries)
order by 2 desc;

#to get emp_id of those employees and there latest dept_no

select emp_no,dept_no,to_date ,count(emp_no) from dept_emp
group by 1
having count(emp_no) > 1 and to_date > sysdate();




















