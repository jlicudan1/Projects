Select *
From HomelessData..sheltered_es
where State is not null

-- Sheltered in Emergency Shelters


-- Sheltered Homeless per CoC
-- Sheltered Homeless rate per CoC

Select State, [Number of CoCs], [Sheltered ES Homeless, 2021], ([Sheltered ES Homeless, 2021]/[Number of CoCs]) as ShelteredHomelessperCoC,
([Number of CoCs]/[Sheltered ES Homeless, 2021]) as ShelteredHomelessRatePerCoC
From HomelessData..sheltered_es
Where state not like '%total%'
Order by 4 desc


-- Percent of Homeless by Age

Select State, [Sheltered ES Homeless - Under 18, 2021], [Sheltered ES Homeless - Age 18 to 24, 2021], [Sheltered ES Homeless - Over 24, 2021],
[Sheltered ES Homeless, 2021], 
([Sheltered ES Homeless - Under 18, 2021]/[Sheltered ES Homeless, 2021]) as Under_18,
([Sheltered ES Homeless - Age 18 to 24, 2021]/[Sheltered ES Homeless, 2021]) as from_18_through_24,
([Sheltered ES Homeless - Over 24, 2021]/[Sheltered ES Homeless, 2021]) as over_24
From HomelessData..sheltered_es
Where state not like '%total%'
Order by 2 desc


-- Percent of Homeless by Gender

Select State, [Sheltered ES Homeless - Female, 2021], [Sheltered ES Homeless - Male, 2021], [Sheltered ES Homeless - Transgender, 2021], [Sheltered ES Homeless - Gender Non-Conforming, 2021],
[Sheltered ES Homeless, 2021],
([Sheltered ES Homeless - Female, 2021]/[Sheltered ES Homeless, 2021]) as female,
([Sheltered ES Homeless - Male, 2021]/[Sheltered ES Homeless, 2021]) as male,
([Sheltered ES Homeless - Transgender, 2021]/[Sheltered ES Homeless, 2021]) as transgender,
([Sheltered ES Homeless - Gender Non-Conforming, 2021]/[Sheltered ES Homeless, 2021]) as gender_non_conforming 
From HomelessData..sheltered_es
Where state not like '%total%'
Order by 2 desc

-- Percent of Homeless by Race

Select State, [Sheltered ES Homeless - White, 2021], [Sheltered ES Homeless - Black or African American, 2021], [Sheltered ES Homeless - Asian, 2021], 
[Sheltered ES Homeless - American Indian or Alaska Native, 2021], [Sheltered ES Homeless - Native Hawaiian or Other Pacific Islande],[Sheltered ES Homeless - Multiple Races, 2021],
[Sheltered ES Homeless, 2021],
([Sheltered ES Homeless - White, 2021]/[Sheltered ES Homeless, 2021]) as White,
([Sheltered ES Homeless - Black or African American, 2021]/[Sheltered ES Homeless, 2021]) as Black,
([Sheltered ES Homeless - Asian, 2021]/[Sheltered ES Homeless, 2021]) as Asian,
([Sheltered ES Homeless - American Indian or Alaska Native, 2021]/[Sheltered ES Homeless, 2021]) as American_Indian_AlaskaNative, 
([Sheltered ES Homeless - Native Hawaiian or Other Pacific Islande]/[Sheltered ES Homeless, 2021]) as Other_Pacific_Islander,
([Sheltered ES Homeless - Multiple Races, 2021]/[Sheltered ES Homeless, 2021]) as Multiple_Races 
From HomelessData..sheltered_es
Where state not like '%total%'
Order by 2 desc

-- View for Visualizations

Create View Homeless_by_race as
Select State, [Sheltered ES Homeless - White, 2021], [Sheltered ES Homeless - Black or African American, 2021], [Sheltered ES Homeless - Asian, 2021], 
[Sheltered ES Homeless - American Indian or Alaska Native, 2021], [Sheltered ES Homeless - Native Hawaiian or Other Pacific Islande],[Sheltered ES Homeless - Multiple Races, 2021],
[Sheltered ES Homeless, 2021],
([Sheltered ES Homeless - White, 2021]/[Sheltered ES Homeless, 2021]) as White,
([Sheltered ES Homeless - Black or African American, 2021]/[Sheltered ES Homeless, 2021]) as Black,
([Sheltered ES Homeless - Asian, 2021]/[Sheltered ES Homeless, 2021]) as Asian,
([Sheltered ES Homeless - American Indian or Alaska Native, 2021]/[Sheltered ES Homeless, 2021]) as American_Indian_AlaskaNative, 
([Sheltered ES Homeless - Native Hawaiian or Other Pacific Islande]/[Sheltered ES Homeless, 2021]) as Other_Pacific_Islander,
([Sheltered ES Homeless - Multiple Races, 2021]/[Sheltered ES Homeless, 2021]) as Multiple_Races 
From HomelessData..sheltered_es
Where state not like '%total%'
