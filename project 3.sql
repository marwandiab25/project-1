
alter table covid
alter column new_vaccinations float;


	select deaths.date,deaths.location,deaths.population,covid.new_vaccinations,
	sum(covid.new_vaccinations) over(partition by deaths.location order by deaths.location,deaths.date) as people_vacitnated
	from [project 1]..deaths
	join [project 1]..covid
	on deaths.location=covid.location 
	and deaths.date=covid.date
	where deaths.continent is not null 
	order by 2,3

	--create a cte

	with PopvsVac(continent,location,date,population,new_vaccinations,people_vacitnated)
	as
	(
	
	select deaths.continent,deaths.date,deaths.location,deaths.population,covid.new_vaccinations,
	sum(covid.new_vaccinations) over(partition by deaths.location order by deaths.location,deaths.date) as people_vacitnated
	from [project 1]..deaths
	join [project 1]..covid
	on deaths.location=covid.location 
	and deaths.date=covid.date
	where deaths.continent is not null )


	select *
	from PopvsVac