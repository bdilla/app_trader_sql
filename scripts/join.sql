SELECT DISTINCT(p.name), (a.name), a.price AS apple_price, p.price AS play_price, a.review_count AS apple_review_count, p.review_count AS play_review_count, a.rating AS apple_rating, p.rating AS play_rating, a.content_rating, a.primary_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
GROUP BY a.name, p.name, a.price, p.price, a.review_count, p.review_count, a.rating, p.rating, a.content_rating, a.primary_genre
WHERE DISTINCT(p.name)
ORDER BY play_rating DESC