-- importing dataset into mysql
create table world_salary(
country_name varchar(225),
continent_name varchar(225),
wage_span varchar(225),
median_salary double,
average_salary double,
lowest_salary double,
highest_salary double
);
load data infile "salary_data.csv" into table world_salary
fields terminated by ","
ignore 1 lines;

create table salary_of_IT_specialist(
ID int primary key auto_increment ,
Position varchar(225),
Specialization varchar(225),
Continent varchar(225),
Experience double,
salary double ,
Gender varchar(225),
Age int,
Education varchar(225),
Type_of_employment varchar(225),
Number_of_projects int ,
Job_satisfaction double
);
load data infile "IT_salaries.csv" into table salary_of_IT_specialist
fields terminated by ","
ignore 1 lines;

-- finding midrange_salary and ordering by the lowest and highest salary 
select country_name ,continent_name, median_salary,average_salary,lowest_salary,highest_salary,
(lowest_salary + highest_salary)/2 as midrange_salary
from world_salary 
order by 4,5 ;

-- filtering countries and their respective continent with the highest salary
select country_name,continent_name, highest_salary
from world_salary 
order by highest_salary desc;

-- filtering countries and their respective continent with the lowest salary
select country_name,continent_name, lowest_salary
from world_salary 
order by highest_salary ;

-- finding country and respective continent with the highest salary  and the highest salary midrange
select country_name ,continent_name,max(highest_salary),
max((lowest_salary + highest_salary)/2 ) as highest_midrange_salary
from world_salary 
group by country_name ,continent_name
order by highest_midrange_salary desc ;

-- finding country and respective continent with the lowest salary  and the lowest salary midrange
select country_name ,continent_name,min(lowest_salary),
min((lowest_salary + highest_salary)/2 ) as lowest_midrange_salary
from world_salary 
group by country_name ,continent_name
order by lowest_midrange_salary;

-- showing african countries with the highest_salary and highest_salary_midrange
select country_name ,continent_name,max(lowest_salary),
max((lowest_salary + highest_salary)/2 ) as highest_midrange_salary
from world_salary
where continent_name like '%Africa%'
group by country_name ,continent_name
order by highest_midrange_salary desc;

-- showing african countries with the lowest_salary and lowest_salary_midrange
select country_name ,continent_name,min(lowest_salary),
min((lowest_salary + highest_salary)/2 ) as lowest_midrange_salary
from world_salary
where continent_name like '%Africa%'
group by country_name ,continent_name
order by lowest_midrange_salary;

-- showing european countries with the highest_salary and highest_salary_midrange
select country_name ,continent_name,max(lowest_salary),
max((lowest_salary + highest_salary)/2 ) as highest_midrange_salary
from world_salary
where continent_name like '%Europe%'
group by country_name ,continent_name
order by highest_midrange_salary desc;

-- showing european countries with the lowest_salary and lowest_salary_midrange
select country_name ,continent_name,min(lowest_salary),
min((lowest_salary + highest_salary)/2 ) as lowest_midrange_salary
from world_salary
where continent_name like '%Europe%'
group by country_name ,continent_name
order by lowest_midrange_salary;


-- looking at world_salary  vs salary of iT specialist
select country_name,continent_name,highest_salary,lowest_salary,Position,Specialization,Experience,Number_of_projects,Job_satisfaction
from world_salary 
join salary_of_it_specialist on world_salary.continent_name = salary_of_it_specialist.Continent;

-- looking at world_salary  vs salary of iT specialist for data analyst position
select country_name,continent_name,highest_salary,lowest_salary,Position,Specialization,Experience,Number_of_projects,Job_satisfaction
from world_salary 
join salary_of_it_specialist on world_salary.continent_name = salary_of_it_specialist.Continent
where Position = 'Data_Analyst';


-- looking at world_salary  vs salary of iT specialist for QA_Engineer position
select country_name,continent_name,highest_salary,lowest_salary,Position,Specialization,Experience,Number_of_projects,Job_satisfaction
from world_salary 
join salary_of_it_specialist on world_salary.continent_name = salary_of_it_specialist.Continent
where Position = 'QA_Engineer';



-- looking at the position and specialization with higest job satisfaction
select Position,Specialization,Continent,Job_satisfaction from salary_of_it_specialist
join world_salary on salary_of_it_specialist.Continent = world_salary.continent_name
order by Job_satisfaction desc ;

-- looking at the TOTAL number males and females in the IT field
select count(Gender),Gender from salary_of_it_specialist
group by Gender ;

--  looking at the age distribution accross the IT field ordering from the highest to lowest
-- USE CTE

with age_distro (country_name,Specialization,Continent,Gender,Age)
as
(
select country_name,Specialization,Continent,Gender,Age from salary_of_it_specialist
join world_salary on salary_of_it_specialist.Continent = world_salary.continent_name
order by Age desc 
)

-- Average age with respect to gender accross the various IT fields
select Gender,avg(Age) from age_distro
group by Gender;


Create View DataAnalystPosition as
select country_name,continent_name,highest_salary,lowest_salary,Position,Specialization,Experience,Number_of_projects,Job_satisfaction
from world_salary 
join salary_of_it_specialist on world_salary.continent_name = salary_of_it_specialist.Continent
where Position = 'Data_Analyst' ;
