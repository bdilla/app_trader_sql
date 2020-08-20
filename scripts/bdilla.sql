/*SELECT name, rating
FROM play_store_apps
GROUP BY name
HAVING COUNT(*)>1
ORDER BY name DESC*/

/*SELECT DISTINCT a.name, a.price AS apple_price, p.price AS play_price, a.review_count AS apple_review_count, p.review_count AS play_review_count, AVG(a.rating + p.rating)/2 AS avg_rating_across_stores, a.content_rating, a.primary_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
GROUP BY a.name, a.price, p.price, a.review_count, p.review_count, a.rating, p.rating, a.content_rating, a.primary_genre
ORDER BY avg_rating_across_stores DESC
;*/


/*SELECT name, install_count
FROM play_store_apps
WHERE install_count > '10,000+'
ORDER BY install_count DESC*/

/*SELECT
	CASE WHEN subquery.has_app_store = TRUE AND subquery.has_play_store = TRUE THEN TRUE ELSE FALSE END AS has_both_stores,
	CASE
		WHEN average_rating is null AND app_rating is null THEN ROUND(play_rating, 2)
		WHEN average_rating is null AND play_rating is null THEN ROUND(app_rating, 2)
		WHEN average_rating is not null THEN ROUND(average_rating, 2)
		ELSE '0'
		END AS refined_rating,
	name, average_rating, app_rating, play_rating
	FROM
	(SELECT 
	 	CASE WHEN a.rating is not null THEN TRUE ELSE FALSE END AS has_app_store,
		CASE WHEN p.rating is not null THEN TRUE ELSE FALSE END AS has_play_store,	
		p.name, a.rating AS app_rating,  p.rating AS play_rating, ((a.rating + (ROUND(p.rating / .5, 0) * .5)) / 2) AS average_rating
		FROM play_store_apps AS p	
		FULL JOIN app_store_apps AS a	
		ON p.name = a.name) as subquery
	WHERE name is not null
	ORDER BY has_both_stores DESC, refined_rating DESC, name*/
	
/*SELECT name, primary_genre AS genres
FROM app_store_apps
UNION ALL
SELECT name, genres
FROM play_store_apps
ORDER BY name*/

/*SELECT DISTINCT ON (name) name,	
	CASE WHEN subquery.has_app_store = TRUE AND subquery.has_play_store = TRUE THEN TRUE ELSE FALSE END AS has_both_stores,
	ROUND(average_rating,2) AS average_rating, app_rating, play_rating, CAST(subquery.price AS float), CAST(subquery.app_review_count AS int), CAST(subquery.play_review_count AS int)
	FROM
	(SELECT DISTINCT
	 	p.name,	
	 	CASE WHEN a.rating is not null THEN TRUE ELSE FALSE END AS has_app_store,
		CASE WHEN p.rating is not null THEN TRUE ELSE FALSE END AS has_play_store,	
		CAST(a.price AS float), CAST(a.review_count AS int) AS app_review_count, CAST(p.review_count AS int) AS play_review_count, a.rating AS app_rating,  p.rating AS play_rating, ((a.rating + (ROUND(p.rating / .5, 0) * .5)) / 2) AS average_rating																			  
		FROM play_store_apps AS p	
		FULL JOIN app_store_apps AS a	
		ON p.name = a.name
		-- Filter for price
		WHERE a.price < 1.01) as subquery		
	-- Filter for review count over 5000 on either store	
	WHERE (subquery.app_review_count > 5000
		OR subquery.play_review_count > 5000)
		AND COALESCE(average_rating, app_rating, play_rating) > 4.6
	ORDER BY name, has_both_stores DESC*/
	
/*SELECT DISTINCT ON (app_name) app_name,	play_name, subquery.a_content, subquery.p_content,
	CASE WHEN subquery.has_app_store = TRUE AND subquery.has_play_store = TRUE THEN TRUE ELSE FALSE END AS has_both_stores,
	/*CASE
		WHEN average_rating is null AND app_rating is null THEN ROUND(play_rating, 2)
		WHEN average_rating is null AND play_rating is null THEN ROUND(app_rating, 2)
		WHEN average_rating is not null THEN ROUND(average_rating, 2)
		ELSE '0'
		END AS refined_rating,*/
	ROUND(average_rating,2) AS average_rating, app_rating, play_rating, CAST(subquery.price AS float), CAST(subquery.app_review_count AS int), CAST(subquery.play_review_count AS int)
	FROM
	(SELECT
	 	p.name as play_name, a.name as app_name, a.content_rating AS a_content, p.content_rating AS p_content,
	 	CASE WHEN a.rating is not null THEN TRUE ELSE FALSE END AS has_app_store,
		CASE WHEN p.rating is not null THEN TRUE ELSE FALSE END AS has_play_store,	
		CAST(a.price AS float), CAST(a.review_count AS int) AS app_review_count, CAST(p.review_count AS int) AS play_review_count, a.rating AS app_rating,  p.rating AS play_rating, ((a.rating + (ROUND(p.rating / .5, 0) * .5)) / 2) AS average_rating
		FROM play_store_apps AS p	
		FULL JOIN app_store_apps AS a	
		ON p.name = a.name
		-- Filter for price
		WHERE a.price < 1.01) as subquery		
	-- Filter for review count over 5000 on either store	
	WHERE (subquery.app_review_count > 5000
		OR subquery.play_review_count > 5000)
		AND COALESCE(average_rating, app_rating, play_rating) > 4.6
		AND play_name IS NOT NULL
	ORDER BY app_name, has_both_stores DESC --, refined_rating*/	

SELECT DISTINCT ON (app_name) app_name,	play_name, subquery.a_content, subquery.p_content,
	CASE WHEN subquery.has_app_store = TRUE AND subquery.has_play_store = TRUE THEN TRUE ELSE FALSE END AS has_both_stores,
	/*CASE
		WHEN average_rating is null AND app_rating is null THEN ROUND(play_rating, 2)
		WHEN average_rating is null AND play_rating is null THEN ROUND(app_rating, 2)
		WHEN average_rating is not null THEN ROUND(average_rating, 2)
		ELSE '0'
		END AS refined_rating,*/
	ROUND(average_rating,2) AS average_rating, app_rating, play_rating, CAST(subquery.price AS float), CAST(subquery.app_review_count AS int), CAST(subquery.play_review_count AS int)
	FROM
	(SELECT
	 	p.name as play_name, a.name as app_name, a.content_rating AS a_content, p.content_rating AS p_content,
	 	CASE WHEN a.rating is not null THEN TRUE ELSE FALSE END AS has_app_store,
		CASE WHEN p.rating is not null THEN TRUE ELSE FALSE END AS has_play_store,	
		CAST(a.price AS float), CAST(a.review_count AS int) AS app_review_count, CAST(p.review_count AS int) AS play_review_count, a.rating AS app_rating,  p.rating AS play_rating, ((a.rating + (ROUND(p.rating / .5, 0) * .5)) / 2) AS average_rating
		FROM play_store_apps AS p	
		FULL JOIN app_store_apps AS a	
		ON p.name = a.name
		-- Filter for price
		WHERE a.price > 1.01 AND a.price <9.99) as subquery		
	-- Filter for review count over 5000 on either store	
	WHERE (subquery.app_review_count > 5000
		OR subquery.play_review_count > 5000)
		AND COALESCE(average_rating, app_rating, play_rating) > 4.0
		AND play_name IS NOT NULL
	ORDER BY app_name, has_both_stores DESC --, refined_rating

	
	

	


