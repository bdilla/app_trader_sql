SELECT DISTINCT p.name, ((a.rating+p.rating)/2) AS average_rating, a.rating, p.rating
FROM play_store_apps AS p
FULL JOIN app_store_apps AS a
ON p.name = a.name
WHERE ((a.rating+p.rating)/2) IS NOT NULL
GROUP BY p.name, a.rating, p.rating
ORDER BY average_rating DESC