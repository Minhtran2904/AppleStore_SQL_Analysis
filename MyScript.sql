/*This is for working with sqlonline.com where imported file size is capped at 3Mb*/
CREATE TABLE appleStore_description_combined AS

SELECT * FROM appleStore_description1

UNION ALL

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL 
/*Above this is for working with sqlonline.com*/

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

/*Check genres with low rating*/
SELECT prime_genre, avg(user_rating) AS AvgRating
FROM AppleStore
GROUP BY 1 ORDER BY 2 ASC LIMIT 10

/*Check if there is correlation betwene apps description's length with user rating*/
SELECT CASE
			WHEN length(b.app_desc) < 500 THEN "Short"
            WHEN length(b.app_desc) BETWEEN 500 AND 1000 THEN "Medium"
            ELSE "Long"
            END AS Description_Length,
            avg(user_rating) AS AvgRating
			FROM AppleStore AS A

JOIN appleStore_description_combined AS B
ON A.id = B.id

GROUP BY 1 ORDER BY 2 DESC

/*Check top-rated apps for each genre (use WINDOW function)*/
SELECT 
	prime_genre,
    track_name,
    user_rating
FROM (
  		SELECT
  		prime_genre,
  		track_name,
  		user_rating,
  		RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS rank
  		FROM AppleStore
  ) AS a
WHERE
a.rank = 1

SELECT * FROM AppleStore
