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