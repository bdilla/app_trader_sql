SELECT CAST(p.price as money) AS pprice, p.name, p.rating, p.review_count
FROM play_store_apps AS p
WHERE name ILIKE '%m rich%'
AND p.rating IS NOT NULL
GROUP BY p.name, pprice, p.rating, p.review_count
ORDER BY pprice DESC