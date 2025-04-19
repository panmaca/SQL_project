--- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

SELECT 
	YEAR, 
	category_name, 
	round(category_value) AS price,
	round(((category_value - LAG(category_value) OVER (PARTITION BY category_name ORDER BY year)) / 
      LAG(category_value) OVER (PARTITION BY category_name ORDER BY year)) * 100,0)  AS percent
FROM t_marcela_travnickova_project_sql_primary_final tmtpspf 
WHERE category_value IS NOT null
GROUP BY year, category_name, category_value
ORDER BY percent
LIMIT 1;
