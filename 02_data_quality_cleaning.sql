-- 07 - Check for NULL values in necessary columns of the new combined table
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(trip_id IS NULL) AS missing_trip_id,
  COUNTIF(start_time IS NULL) AS missing_start_time,
  COUNTIF(end_time IS NULL) AS missing_end_time,
  COUNTIF(tripduration IS NULL) AS missing_tripduration,
  COUNTIF(from_station_name IS NULL) AS missing_start_station,
  COUNTIF(to_station_name IS NULL) AS missing_end_station,
  COUNTIF(usertype IS NULL) AS missing_usertype
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`;

-- 08 - Check for duplicates in trip_id (there can only be one trip_id per trip)
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT trip_id) AS unique_trip_ids,
  COUNT(*) - COUNT(DISTINCT trip_id) AS duplicate_trip_ids
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`;

-- 09 - Checking MAX and MIN tripduration for outliers
SELECT
  MIN(tripduration) AS min_tripduration,
  MAX(tripduration) AS max_tripduration,
  ROUND(AVG(tripduration), 2) AS avg_tripduration,
  COUNTIF(tripduration <= 0) AS invalid_tripduration
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`;

-- 10 - Investigating long tripduration (I discovered a 123-day trip and wanted to see how many outliers there are)
SELECT
  COUNTIF(tripduration < 60) AS under_1_minute,
  COUNTIF(tripduration >= 60 AND tripduration < 3600) AS under_1_hour,
  COUNTIF(tripduration >= 3600 AND tripduration < 86400) AS between_1_hour_and_1_day,
  COUNTIF(tripduration >= 86400) AS over_1_day

FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`;

-- 11 - How trips over a day changed the average tripduration (I ran this without the WHERE statement as well to get the average with the trips over a day to compare the two) 
SELECT
  ROUND(AVG(tripduration), 2) AS avg_tripduration
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`
WHERE
  tripduration < 86400;

-- 12 - Customer vs Subscriber long_rides count (This helped me understand which group contributed more of the unusually long rides)
SELECT
  usertype,
  COUNT(*) AS long_rides
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`
WHERE
  tripduration >= 86400
GROUP BY
  usertype;

-- 13 - Customer vs Subscriber tripduration over a day as a percent vs total rides (Helped me compare how common these unusually long rides are within each group.)
SELECT
  usertype,
  COUNT(*) AS total_rides,
  COUNTIF(tripduration >= 86400) AS long_rides,
  ROUND(COUNTIF(tripduration >= 86400)/COUNT(*) * 100, 3) AS long_ride_percentage
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`
GROUP BY
  usertype;

-- 14 - Create cleaned data table (no rides over 24 hours) - I wanted to get the most accurate results for the average Customer and Subscriber, so I took out outliers
CREATE TABLE
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned` AS

SELECT
  *
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_combined`
WHERE
  tripduration < 86400;
