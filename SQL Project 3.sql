-- I have selected the life expectancy (WHO) dataset
-- With the aim to explore various cause-specific mortality amongst the british population 
-- while making a comparison with the highest life expectancy country in 2015

-- 1
-- In order for me to analyse the dataset
-- it's important to retrieve the whole dataset 
SELECT * FROM tutorial.project;

-- 2
-- I would like see if the United Kingdom of Great Britain (UK) and Northern Ireland (NI)
-- is one of the top 5 highest life expectancy countries around the world in 2015
SELECT year, country, status, life_expectancy
FROM tutorial.project 
WHERE year = 2015
ORDER BY Life_expectancy DESC
LIMIT 5;
-- Slovenia came up as the highest life expectancy country in 2015 

-- 3 
-- I would like see if the UK and NI is one of the top 5 lowest life expectancy countries around the world in 2015
SELECT year, country, status, life_expectancy
FROM tutorial.project 
WHERE year = 2015
ORDER BY Life_expectancy ASC
LIMIT 5;

-- 4
-- Now that I have established the UK and NI is not part of the 5 top or lowest life expectancy countries around the world
-- I would like to find out the average life expectancy within the UK and NI (2000 - 2015)
SELECT Year, Country, AVG(life_expectancy) AS 'AVG Life Expectancy Of UK & Northern Ireland'
FROM tutorial.project
WHERE country = 'United Kingdom of Great Britain and Northern Ireland'
GROUP BY year 
ORDER BY AVG(life_expectancy) DESC;

-- 4b 
-- Same as 4a but with Slovenia
SELECT Year, Country, AVG(life_expectancy) AS 'AVG Life Expectancy Of Slovenia'
FROM tutorial.project
WHERE country = 'Slovenia'
GROUP BY year 
ORDER BY AVG(life_expectancy) DESC;

-- 5a
-- Total number infant death in UK and NI (2015)
SELECT Year, Country, SUM(infant_deaths) AS 'Total No Infant Deaths'
FROM tutorial.project
WHERE country = 'United Kingdom of Great Britain and Northern Ireland' AND year = 2015;

-- 5b
-- Total number infant death in Slovenia (2015)
SELECT Year, Country, SUM(infant_deaths) AS 'Total No Infant Deaths'
FROM tutorial.project
WHERE country = 'Slovenia' AND year = 2015;
 
 -- 6a
-- I would like to explore the correlation between BMI and life expectancy, by creating a category based on weight status for Slovenia  
SELECT year, country, life_expectancy, BMI,
CASE
WHEN BMI < 18.5 THEN 'Underweight'
WHEN BMI BETWEEN 18.6 AND 24.9 THEN 'Healthy'
WHEN BMI BETWEEN 25 AND 29.9 THEN 'Overweight'
ELSE 'Obese'
END AS 'Weight Status'
FROM tutorial.project
WHERE country = 'Slovenia' AND year BETWEEN 2000 AND 2015;

 -- 6b
-- Same as 6a but for UK and NI 
SELECT year, country, life_expectancy, BMI,
CASE
WHEN BMI < 18.5 THEN 'Underweight'
WHEN BMI BETWEEN 18.6 AND 24.9 THEN 'Healthy'
WHEN BMI BETWEEN 25 AND 29.9 THEN 'Overweight'
ELSE 'Obese'
END AS 'Weight Status'
FROM tutorial.project
WHERE country = 'United Kingdom of Great Britain and Northern Ireland' AND year BETWEEN 2000 AND 2015;

-- 7a 
-- I would like to find the percentage of adult mortality and alcohol consumption (BETWEEN 2000-2015)
SELECT Country, AVG(life_expectancy) AS 'Average Life Expectancy (2000-2015)',
(SELECT SUM(adult_mortality) FROM tutorial.project) AS 'Total Adult Mortality (2000-2015)', 
(SELECT SUM(alcohol) FROM tutorial.project) AS 'Total Alcohol recorded per capita (15+) consumption in litres of pure alcohol between (2000-2015)',
(adult_mortality/ (SELECT SUM(adult_mortality) FROM tutorial.project)) * 100 AS '% of Adult Mortality (2000-2015)',
(alcohol/ (SELECT SUM(alcohol) FROM tutorial.project)) * 100 AS '% of Alcohol (2000-2015)'
FROM tutorial.project
WHERE country = 'Slovenia'
GROUP BY country;

-- 7b
-- Same as 7a but for the UK and NI (2000-2015) 
SELECT Country, AVG(life_expectancy) AS 'Average Life Expectancy (2000-2015)',
(SELECT SUM(adult_mortality) FROM tutorial.project) AS 'Total Adult Mortality (2000-2015)', 
(SELECT SUM(alcohol) FROM tutorial.project) AS 'Total Alcohol recorded per capita (15+) consumption in litres of pure alcohol (2000-2015)',
(adult_mortality/ (SELECT SUM(adult_mortality) FROM tutorial.project)) * 100 AS '% of Adult Mortality (2000-2015)',
(alcohol/ (SELECT SUM(alcohol) FROM tutorial.project)) * 100 AS '% of Alcohol (2000-2015)'
FROM tutorial.project
WHERE country = 'United Kingdom of Great Britain and Northern Ireland'
GROUP BY country;