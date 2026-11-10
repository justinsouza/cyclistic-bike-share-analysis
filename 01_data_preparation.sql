-- 01 - Check Raw Table Row Count Q1 (Repeat for Q2,Q3, and Q4)
SELECT
  count(*) as total_rides
FROM 
  `cyclistic-514103.cyclistic_2019.divvy_2019_q1`;

-- 02 - Standardize Q2 Columns (The other 3 datasets had the same attributes)
SELECT
  `01 - Rental Details Rental ID` AS trip_id,
  `01 - Rental Details Local Start Time` AS start_time,
  `01 - Rental Details Local End Time` AS end_time,
  `01 - Rental Details Bike ID` AS bikeid,
  `01 - Rental Details Duration In Seconds Uncapped` AS tripduration,
  `03 - Rental Start Station ID` AS from_station_id,
  `03 - Rental Start Station Name` AS from_station_name,
  `02 - Rental End Station ID` AS to_station_id,
  `02 - Rental End Station Name` AS to_station_name,
  `User Type` AS usertype,
  `Member Gender` AS gender,
  `05 - Member Details Member Birthday Year` AS birthyear
FROM
  `cyclistic-514103.cyclistic_2019.divvy_2019_q2`
LIMIT 10;

-- 03 - Create Standardized Q2 Table with matching attributes
CREATE TABLE
  `cyclistic-514103.cyclistic_2019.divvy_2019_q2_clean`
AS

SELECT
  `01 - Rental Details Rental ID` AS trip_id,
  `01 - Rental Details Local Start Time` AS start_time,
  `01 - Rental Details Local End Time` AS end_time,
  `01 - Rental Details Bike ID` AS bikeid,
  `01 - Rental Details Duration In Seconds Uncapped` AS tripduration,
  `03 - Rental Start Station ID` AS from_station_id,
  `03 - Rental Start Station Name` AS from_station_name,
  `02 - Rental End Station ID` AS to_station_id,
  `02 - Rental End Station Name` AS to_station_name,
  `User Type` AS usertype,
  `Member Gender` AS gender,
  `05 - Member Details Member Birthday Year` AS birthyear
FROM
  `cyclistic-514103.cyclistic_2019.divvy_2019_q2`;

-- 04 - Check Standardized Q2 Row Count (Making sure the data matches the original Q2 data)
SELECT
  COUNT(*) as total_rides  
FROM 
  `cyclistic-514103.cyclistic_2019.divvy_2019_q2_clean`;

-- 05 - Combine 2019 Quarterly Tables
CREATE OR REPLACE TABLE
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`
AS

SELECT 
  * 
FROM
  `cyclistic-514103.cyclistic_2019.divvy_2019_q1`
UNION ALL

SELECT 
  * 
FROM 
  `cyclistic-514103.cyclistic_2019.divvy_2019_q2_clean`
UNION ALL

SELECT
  * 
FROM
  `cyclistic-514103.cyclistic_2019.divvy_2019_q3`
UNION ALL

SELECT
  *
FROM
  `cyclistic-514103.cyclistic_2019.divvy_2019_q4`;

-- 06 - Check Combined Table Row Count (Making sure all the data is there)
SELECT
  COUNT(*) AS total_rides
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`



