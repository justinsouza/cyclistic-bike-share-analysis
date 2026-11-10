-- 18 - Ridership by day of the week for each usertype (Customer vs Subscriber)
SELECT
  usertype,
  EXTRACT(DAYOFWEEK FROM start_time) AS day_of_week,
  COUNT(*) AS total_rides
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned`
GROUP BY
  usertype,
  day_of_week
ORDER BY
  day_of_week DESC;
--EXPORT TO EXCEL FOR FURTHER ANALYSIS

-- 19 - Ridership by month for each usertype (Customer vs Subscriber)
SELECT  
  usertype,
  EXTRACT(MONTH FROM start_time) AS month,
  COUNT(*) AS total_rides
FROM 
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned` 
GROUP BY
  usertype,
  month
ORDER BY
  month;
-- EXPORT TO EXCEL FOR FURTHER ANALYSIS 

-- 20 - Ridership by Hour for each usertype (Customer vs Subscriber)
SELECT  
  usertype,
  EXTRACT(HOUR FROM start_time) AS time_of_ride,
  COUNT(*) AS total_rides
FROM 
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned` 
GROUP BY
  usertype,
  time_of_ride
ORDER BY
  time_of_ride;
-- EXPORT TO EXCEL FOR FURTHER ANALYSIS 

-- 22 - Weekday vs Weekend Hourly Ridership for each usertype (Customer vs Subscriber)
SELECT
  usertype,
  CASE
    WHEN EXTRACT(DAYOFWEEK from start_time) IN (1, 7)
      THEN 'Weekend'
    ELSE 'Weekday' 
  END AS day_type,
  EXTRACT(HOUR from start_time) AS hour_of_day,
  COUNT(*) AS total_rides
FROM
  `cyclistic-514103.cyclistic_2019.cyclistic_2019_cleaned` 
GROUP BY
  usertype,
  day_type,
  hour_of_day
ORDER BY
  usertype,
  day_type,
  hour_of_day;
--EXPORT TO EXCEL FOR FURTHER ANALYSIS



