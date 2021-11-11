/* 

Cleaning Data in SQL queries
Skills used: Truncating, Partitions, Updating, Inserting

*/

-- Changing Date Format
SELECT Saledate, CAST(SaleDate AS date) AS SaleDateConverted
from NYCProperty;

ALTER TABLE NYCProperty
ADD SaleDateConverted Date;

UPDATE NYCProperty
SET SaleDateConverted = CAST(SaleDate AS date);

SELECT SaleDateConverted
FROM NYCProperty;

-- Seperating Address and Neighbourhood

/* Some of the Address values were xxx,1x,xxx and others as xxx,xxx */

-- Adding Columns
ALTER TABLE NYCProperty
ADD SplitAddress VARCHAR(255);

ALTER TABLE NYCProperty
ADD SplitAddress2 VARCHAR(255);

ALTER TABLE NYCProperty
ADD SplitNeighbourhood VARCHAR(255);
 
ALTER TABLE NYCProperty
ADD SplitAddressFinal VARCHAR(255);

-- Updating Columns
/* Selecting everything before first comma */
UPDATE NYCProperty
SET SplitAddress =  LEFT(ADDRESS, LOCATE(',', Address)-1); 

/* Selecting everything between first and second comma (if exist) */
UPDATE NYCProperty 
SET SplitAddress2 = SUBSTRING(Address, Locate(',', Address)+1, Locate(',', Address, Locate(',', Address)+1) -  Locate(',', Address) -1 );

/* Selecting everything before last comma */
UPDATE NYCProperty
SET SplitNeighbourhood = REVERSE(LEFT(REVERSE(Address), LOCATE(',', REVERSE(Address)) -1));

UPDATE NYCProperty
SET SplitAddressFinal = CONCAT(SplitAddress,' ', SplitAddress2); 

SELECT SplitAddressFinal, SplitNeighbourhood
FROM NYCProperty;

-- Change borough from 1, 2, 3, 4, 5 to Manhattan, Bronx, Brooklyn, Queens, Staten Island
SELECT DISTINCT(Borough), COUNT(Borough)
FROM NYCProperty
GROUP BY Borough;

SELECT Borough,
	(CASE
		WHEN Borough = 1 THEN "Manhattan"
		WHEN Borough = 2 THEN "Bronx"
		WHEN Borough = 3 THEN "Brooklyn"
		WHEN Borough = 4 THEN "Queens"
		WHEN Borough = 5 THEN "Staten Island"
		ELSE "N/A"
	END) AS Borough
FROM NYCProperty;

ALTER TABLE NYCProperty
MODIFY Borough VARCHAR(225);

UPDATE NYCProperty
SET Borough = 	
	(CASE
		WHEN Borough = 1 THEN "Manhattan"
		WHEN Borough = 2 THEN "Bronx"
		WHEN Borough = 3 THEN "Brooklyn"
		WHEN Borough = 4 THEN "Queens"
		WHEN Borough = 5 THEN "Staten Island"
		ELSE "N/A"
	END);

-- Deleting Duplicates
WITH RowCTE AS (

SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY
			 SplitAddressFinal
				 ORDER BY
					ID
					) row_num
FROM NYCProperty
)

DELETE FROM NYCProperty
USING NYCProperty
JOIN RowCTE
	ON NYCProperty.ID = RowCTE.ID
WHERE row_num > 1;

-- Removing Unused columns
SELECT *
FROM NYCProperty;

ALTER TABLE NYCProperty 
DROP COLUMN Address, 
DROP COLUMN Ease_Ment, 
DROP COLUMN SaleDate, 
DROP COLUMN SplitAddress, 
DROP COLUMN SplitAddress2
