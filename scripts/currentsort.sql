SELECT app_name, play_name, has_both_stores, average_rating, content_rating, price, primary_genre, app_review_count, play_review_count
FROM
(SELECT DISTINCT ON (app_name) app_name,	play_name,
	CASE WHEN subquery.has_app_store = TRUE AND subquery.has_play_store = TRUE THEN TRUE ELSE FALSE END AS has_both_stores,	
	ROUND(average_rating,2) AS average_rating, content_rating, app_rating, play_rating, CAST(subquery.price AS float), primary_genre, CAST(subquery.app_review_count AS int), CAST(subquery.play_review_count AS int)
	FROM
	(SELECT
	 	p.name as play_name, a.name as app_name,
	 	CASE WHEN a.rating is not null THEN TRUE ELSE FALSE END AS has_app_store,
		CASE WHEN p.rating is not null THEN TRUE ELSE FALSE END AS has_play_store,	
		CAST(a.price AS float), a.primary_genre, CAST(a.review_count AS int) AS app_review_count, a.content_rating, CAST(p.review_count AS int) AS play_review_count, a.rating AS app_rating,  p.rating AS play_rating, ((a.rating + (ROUND(p.rating / .5, 0) * .5)) / 2) AS average_rating
		FROM play_store_apps AS p	
		FULL JOIN app_store_apps AS a	
		ON p.name = a.name
		-- Filter for price
		/*WHERE a.price < 1.01*/) as subquery		
	-- Filter for review count over 5000 on either store	
	WHERE (subquery.app_review_count > 5000
		OR subquery.play_review_count > 5000)
		AND COALESCE(average_rating, app_rating, play_rating) > 4.0
 		AND play_name IS NOT NULL
 		AND app_name IS NOT NULL
	ORDER BY app_name) as sub2	
	ORDER BY has_both_stores DESC, average_rating DESC, app_review_count DESC