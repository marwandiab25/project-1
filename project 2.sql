select location,date,total_cases,new_cases,total_deaths,population
from [project 1]..deaths
where continent is not null
order by 1,2
--alter table deaths
--alter column total_cases float;

alter table deaths
alter column total_deaths float;


--alter table deaths
--alter column new_cases float;


--alter table deaths
--alter column new_deaths float;

-- looking at total casses vs total deaths

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100  as death_perecentage
from [project 1]..deaths

where location like '%egypt%'
	order by 1,2

	--this calculate the infection rate in egypt
	
	select location,date,total_cases,population,(total_cases/population)*100  as infection_perecentage
from [project 1]..deaths
where location like '%egypt%'

-- highest infection rate vs population


	select location,max(total_cases)as highest_infection_count,population,max((total_cases/population))*100  as highest_percentage
from [project 1]..deaths
--where location like '%egypt%'
group by location,population
order by highest_percentage desc

-- showing the countries with the highest death count vs infection


	select location,max(total_deaths) as total_death_count
from [project 1]..deaths
--where location like '%egypt%'
where continent is  null
group by location
order by total_death_count desc 

-- showing the continents with the highest death rate

select continent,max(total_deaths) as total_death_rate
from [project 1]..deaths
where continent is not null
group by continent
order by total_death_rate desc

-- global numbers

select date,sum(new_cases ),sum(new_deaths ), sum(new_deaths )/sum(new_cases )*100 as global_death_rate 
from [project 1]..deaths

where continent is not null 
group by date
	order by 1,2


	select*
	from [project 1]..deaths
	join [project 1]..covid
	on deaths.location=covid.location
	and deaths.date=covid.date