SELECT AVG(CAST(a.rating AS float)) AS app_rating, AVG(CAST(p.rating AS float)) AS play_rating,
CASE WHEN a.price = 0 THEN 'free'
WHEN a.price >0 AND a.price <2 THEN '0-1.99'
WHEN a.price >2 THEN '2 and higher' END AS price_range
FROM play_store_apps AS p
FULL JOIN app_store_apps AS a
ON p.name = a.name
WHERE a.price IS NOT NULL AND a.rating IS NOT NULL
--OR p.rating IS NOT NULL
GROUP BY price_range
ORDER BY app_rating DESC

