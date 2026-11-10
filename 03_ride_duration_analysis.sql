-- 15 - Total rides by usertype (Customer vs Subscriber)
SELECT
  usertype,
  COUNT(*) AS total_rides 
FROM 
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned` 
GROUP BY
  usertype

-- 16 - Average tripduration by usertype (Customer vs Subscriber)
SELECT
  usertype,
  ROUND(AVG(tripduration)/60, 2) AS avg_tripduration
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned`  
GROUP BY
  usertype;

-- 17 - Median tripduration by usertype (Customer vs Subscriber) - First time using APPROX_QUANTILES - Unusually long trips were affecting the averages. The median gave me insight into typical ride lengths because it's less sensitive to outliers.
SELECT
  usertype,
  ROUND(APPROX_QUANTILES(tripduration, 2)[OFFSET(1)] / 60, 2) AS median_ride_minutes
--Estimates the median ride duration (converted to minutes) by dividing the sorted ride durations into two equal groups. [OFFSET(1)] selects the middle value.
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned`
GROUP BY
  usertype;

-- 21 - Average Ride Duration by Day of Week
SELECT
  usertype,
  EXTRACT(DAYOFWEEK from start_time) AS day_of_week,
  ROUND(AVG(tripduration)/60, 2) AS avg_tripduration
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned` 
GROUP BY
  usertype,
  day_of_week
ORDER BY
  day_of_week,
  usertype;
  --EXPORT TO EXCEL FOR FURTHER ANALYSIS
