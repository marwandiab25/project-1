	--create a cte

	with Population_vs_vac (continent,location,date,population,new_vaccinations,people_vacitnated)
	AS
	(
	select deaths.continent,deaths.location,deaths.date,deaths.population,covid.new_vaccinations,
	sum(covid.new_vaccinations) over(partition by deaths.location order by deaths.location,deaths.date) as people_vacitnated
	from [project 1]..deaths
	join [project 1]..covid
	on deaths.location=covid.location 
	and deaths.date=covid.date
	where deaths.continent is not null 
	)
select *,(people_vacitnated/population)*100 as percentage_vactinated
from Population_vs_vac




--temp table
drop table if exists
 
 create table #perecent_popluation
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
people_vacitnated numeric
 )
 insert into #perecent_popluation
	select deaths.continent,deaths.location,deaths.date,deaths.population,covid.new_vaccinations,
	sum(covid.new_vaccinations) over(partition by deaths.location order by deaths.location,deaths.date) as people_vacitnated
	from [project 1]..deaths
	join [project 1]..covid
	on deaths.location=covid.location 
	and deaths.date=covid.date
	where deaths.continent is not null 
	select *,(people_vacitnated/population)*100 as percentage_vactinated
from #perecent_popluation
--view
create view percent_people_vaccinated as
select deaths.continent,deaths.location,deaths.date,deaths.population,covid.new_vaccinations,
	sum(covid.new_vaccinations) over(partition by deaths.location order by deaths.location,deaths.date) as people_vacitnated
	from [project 1]..deaths
	join [project 1]..covid
	on deaths.location=covid.location 
	and deaths.date=covid.date
	where deaths.continent is not null 
	