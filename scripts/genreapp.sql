SELECT TRIM(primary_genre) AS genre, AVG(CAST(a.rating AS float)) AS app_rating, AVG(CAST(p.rating AS float)) AS play_rating
FROM play_store_apps AS p
FULL JOIN app_store_apps AS a
ON p.name = a.name
WHERE primary_genre IS NOT NULL
AND a.rating IS NOT NULL
OR p.rating IS NOT NULL
GROUP BY genre
ORDER BY app_rating DESC

