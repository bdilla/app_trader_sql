SELECT TRIM(p.content_rating) AS content_rating, AVG(CAST(a.rating AS float)) AS app_rating, AVG(CAST(p.rating AS float)) AS play_rating
FROM play_store_apps AS p
FULL JOIN app_store_apps AS a
ON p.name = a.name
WHERE p.content_rating IS NOT NULL
AND a.rating IS NOT NULL
OR p.rating IS NOT NULL
GROUP BY p.content_rating
ORDER BY play_rating DESC