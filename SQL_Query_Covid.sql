SELECT *
FROM PortfolioProject..coviddeaths
where continent is not null
order by 3,4

--SELECT *
--FROM PortfolioProject..covidvaccinations
--order by 3,4

--Select data to use

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..coviddeaths
where continent is not null
order by 1,2

-- Look at total cases vs. total deaths
-- Shows chances of dying if you contract are infected with Covid in a specific country
-- example shows United States

Select Location, date, total_cases, total_deaths, ((total_deaths/total_cases)*100) as death_percentage
From PortfolioProject..coviddeaths
Where location like '%states%'
and continent is not null
order by 1,2

-- Looking at total cases vs. population
-- Looking at percentage of population infected with Covid

Select Location, date, total_cases, population, ((total_cases/population)*100) as cases_percentage
From PortfolioProject..coviddeaths
Where location like '%states%'
and continent is not null
order by 1,2

-- Look at countries with highest infection rate compared to population

Select Location, MAX(total_cases) as highest_case_count, population, ((MAX(total_cases)/(population))*100) as percent_population_infected
From PortfolioProject..coviddeaths
--Where location like '%states%'
where continent is not null
Group by Location, population
order by percent_population_infected desc


-- Countries with highest death count per population

Select Location, MAX(cast(total_deaths as int)) as total_death_count
From PortfolioProject..coviddeaths
--Where location like '%states%'
where continent is not null
Group by Location
order by total_death_count desc

-- Continents with highest death count

Select location, MAX(cast(total_deaths as int)) as total_death_count
From PortfolioProject..coviddeaths
--Where location like '%states%'
where continent is null
and location not like '%income%'
Group by location
order by total_death_count desc

-- Global Numbers

-- Death percentage by date

Select date, Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths,(Sum(cast(new_deaths as int))/Sum(new_cases))*100 as death_percentage
From PortfolioProject..coviddeaths
-- Where location like '%states%'
where continent is not null
Group by date
order by 1,2

-- Death percentage total

Select Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths,(Sum(cast(new_deaths as int))/Sum(new_cases))*100 as death_percentage
From PortfolioProject..coviddeaths
-- Where location like '%states%'
where continent is not null
--Group by date
order by 1,2


-- Total population vs. Vaccinations
-- Joined using covid death and vaccination table

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, 
dea.date) as RollingVaccinationCount
--, (RollingVaccinationCount/population)*100
From PortfolioProject..coviddeaths dea
Join PortfolioProject..covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 1,2,3

-- CTE

With pop_vs_vac (continent, location, date, population, new_vaccinations, RollingVaccinationCount)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, 
dea.date) as RollingVaccinationCount
--, (RollingVaccinationCount/population)*100
From PortfolioProject..coviddeaths dea
Join PortfolioProject..covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 1,2,3
)
Select*, ((RollingVaccinationCount/population)*100)
From pop_vs_vac



-- Temp Table

Drop Table if exists #Percent_pop_vaccinated
Create Table #Percent_pop_vaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingVaccinationCount numeric
)

Insert into #Percent_pop_vaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, 
dea.date) as RollingVaccinationCount
--, (RollingVaccinationCount/population)*100
From PortfolioProject..coviddeaths dea
Join PortfolioProject..covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 1,2,3

Select*, ((RollingVaccinationCount/Population)*100)
From #Percent_pop_vaccinated


-- Create view for visualizations

Create View Percent_pop_vaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, 
dea.date) as RollingVaccinationCount
From PortfolioProject..coviddeaths dea
Join PortfolioProject..covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
