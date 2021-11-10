-- Skills Used: Joins, Aggregate Functions, CTE's
-- Top 5 Countries with Highest Ladder Score compared to Total Medals won
SELECT h.country_name, h.ladder_score, MAX(m.total) as total_medals, MAX((m.total/h.ladder_score)) AS MedalsPerScorePt
FROM Happiness h
JOIN Medals m 
ON h.country_name=m.country_name
GROUP BY h.country_name
ORDER BY MedalsPerScorePt desc
limit 5;

-- How many countries have a score greater than 5
SELECT COUNT(country_name)
FROM Happiness
WHERE ladder_score >= 5;

-- How many countries with at least one gold have a ladder score greater than five
SELECT COUNT(h.country_name) AS 1Gold5ScoreCount
FROM Happiness h 
JOIN medals m 
ON h.country_name=m.country_name
WHERE ladder_score >= 5 
AND gold >= 1;

-- On average, how do countries with a ladder score greater than five perform compared to countries with a ladder score less than five
-- First CTE
WITH AVGCountryAbove5 (AvgMedalsUp)
AS
(
SELECT AVG(m.total) AS AvgMedalsUp
FROM medals m 
JOIN happiness h 
ON m.country_name=h.country_name
WHERE h.ladder_score >= 5
),
-- Second CTE
AVGCountryBelow5 (AvgMedalsDown)
AS
(
SELECT AVG(m.total) AS AvgMedalsDown
FROM medals m 
JOIN happiness h 
ON m.country_name=h.country_name
WHERE h.ladder_score <= 5
)
-- Using Both
SELECT *, (AvgMedalsUp-AvgMedalsDown) AS DiffMedal
FROM AVGCountryAbove5
CROSS JOIN AVGCountryBelow5;

-- Breaking Things Down by Regions
-- Show regions with highest medal tally
SELECT h.rg_id, SUM(m.total) AS medaltally
FROM Happiness h 
JOIN Medals m
ON h.country_name=m.country_name
GROUP BY h.rg_id
ORDER BY medaltally DESC;

-- Average medals won per region compared to average life expectancy and ladder score
SELECT h.rg_id, AVG(m.total) AS medaltally, AVG(h.ladder_score) AS AVGLadderScore, AVG(h.healthy_life) AS AVGLifeExpectancy
FROM Happiness h 
JOIN Medals m
ON h.country_name=m.country_name
GROUP BY h.rg_id
ORDER BY medaltally DESC;

-- Percentge of countries that won at least one(1) gold
-- First CTE
WITH TotalCountryCount (CountCountry)
AS
(
SELECT COUNT(country_name) AS CountCountry
FROM medals
),
-- Second CTE
CountriesWGold (GoldCount)
AS
(
SELECT COUNT(country_name) AS GoldCount
FROM Medals
WHERE gold >= 1
)
-- Using both
SELECT *, (GoldCount/CountCountry)*100 AS CountriesWithGoldPercent
FROM TotalCountryCount
CROSS JOIN CountriesWGold;


select COUNT(DISTINCT(rg_id))
from happiness
