SELECT DISTINCT ON (name) name,	
	CASE WHEN subquery.has_app_store = TRUE AND subquery.has_play_store = TRUE THEN TRUE ELSE FALSE END AS has_both_stores,
	CASE
		WHEN average_rating is null AND app_rating is null THEN ROUND(play_rating, 2)
		WHEN average_rating is null AND play_rating is null THEN ROUND(app_rating, 2)
		WHEN average_rating is not null THEN ROUND(average_rating, 2)
		ELSE '0'
		END AS refined_rating,
	ROUND(average_rating,2) AS average_rating, app_rating, play_rating, CAST(subquery.price AS float), CAST(subquery.app_review_count AS int), CAST(subquery.play_review_count AS int)
	FROM
	(SELECT DISTINCT
	 	a.name,	
	 	CASE WHEN a.rating is not null THEN TRUE ELSE FALSE END AS has_app_store,
		CASE WHEN p.rating is not null THEN TRUE ELSE FALSE END AS has_play_store,	
		CAST(a.price AS float), CAST(a.review_count AS int) AS app_review_count, CAST(p.review_count AS int) AS play_review_count, a.rating AS app_rating,  p.rating AS play_rating, ((a.rating + (ROUND(p.rating / .5, 0) * .5)) / 2) AS average_rating
		FROM play_store_apps AS p	
		FULL JOIN app_store_apps AS a	
		ON p.name = a.name
		-- Filter for price
		WHERE a.price < 1.01) as subquery		
	-- Filter for review count over 1000 on either store	
	WHERE subquery.app_review_count > 1000
		OR subquery.play_review_count > 1000
	
	ORDER BY name, has_both_stores DESC, refined_rating