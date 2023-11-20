CREATE TABLE appleStore_description_combined AS

SELECT * FROM appleStore_description1

UNION ALL

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL 

SELECT * FROM appleStore_description4

/* Perform unique check to assure both dataset is the same, for future joint and analysis*/AppleStore
SELECT COUNT(DISTINCT id) AS UniqueAppIDs FROM AppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs FROM appleStore_description_combined

/*Check for any missing values in key fields*/
SELECT COUNT(*) AS MissingValues FROM AppleStore 
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL

SELECT COUNT(*) AS MissingValues FROM appleStore_description_combined
WHERE app_desc IS NULL

/*Find out the number of apps per genre*/
SELECT prime_genre, COUNT(*) AS Number_of_Apps FROM AppleStore
GROUP BY prime_genre
ORDER BY Number_of_Apps DESC

/*Determine whether paid apps have higher ratings than free apps --> Rating of paid is slightly higher than free apps*/
SELECT CASE
			WHEN price > 0 THEN "Paid"
            ELSE "Free"
            END AS App_Type,
            avg(user_rating) AS AvgRate
FROM AppleStore
GROUP BY 1 ORDER BY 2 DESC

/*Check if apps with more supported languages have higher ratings. Middle value would be 10 languages --> more than 30 languages tends to have much higher rating*/
SELECT CASE
			WHEN lang_num < 10 THEN "<10 languages"
            WHEN lang_num BETWEEN 10 AND 30 THEN "10 - 30 languages"
            ELSE ">30 languages"
            END AS Language_Support,
            avg(user_rating) AS AvgRate
FROM AppleStore
GROUP BY 1 ORDER BY 2 DESC