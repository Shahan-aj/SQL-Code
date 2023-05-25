select *
From PortfolioProject..CovidDeaths$
where continent is not null
order by 3,4

--select *
--From PortfolioProject..CovidVaccinations$
--order by 3,4

--Slecting data that we need

select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths$
order by 1,2

--total cases vs total deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
where location like '%india%'
order by 1,2

--Looking total cases vs Population


--Looking at Highest Infection Rate compared to Population

select location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths$
--where location like '%india%'
where continent is not null
Group by location, population
order by PercentagePopulationInfected desc

--showing countries with highest death count

select location, Max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--where location like '%india%'
where continent is not null
Group by location
order by TotalDeathCount desc

--Data based on Continents

select continent, Max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--where location like '%india%'
where continent is not null
Group by continent
order by TotalDeathCount desc

-- Global Numbers

select date, Sum(new_cases), Max(cast(total_deaths as int))
From PortfolioProject..CovidDeaths$
--where location like '%india%'
where continent is not null
Group by date
order by 1,2

--Toatal populations vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) over(partition by dea.location order by dea.location, dea.date) PeoplegettingVaccinated
From PortfolioProject..CovidDeaths$ dea
join PortfolioProject..CovidVaccinations$ vac
	on dea.location = vac.location
	and	dea.date = vac.date
where dea.continent is not null
order by 2,3
		
	
