--- Má výška HDP vliv na změny ve mzdách a cenách potravin? 
--- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

CREATE TEMPORARY TABLE avg_table AS (
	WITH percent_hdp_final AS (
		WITH percent_hdp AS (
			SELECT 
				YEAR,
				round(hdp,0) AS hdp,
				round(((hdp - lag(hdp) OVER (ORDER BY year)) / lag(hdp) OVER (ORDER BY year)) * 100,0) AS hdp_percent
			FROM t_marcela_travnickova_project_sql_primary_final tmtpspf 
			GROUP BY YEAR, hdp)ta
		SELECT YEAR, hdp, hdp_percent,
			round(lag(hdp_percent) OVER (ORDER BY YEAR)) AS hdp_percent_prev
		FROM percent_hdp),
	percent_payment_final AS (
		WITH percent_payment AS (
				SELECT YEAR, industry_branch_name, payment,
				round(((payment - lag(payment) OVER (PARTITION BY industry_branch_name ORDER BY year)) / 
						lag(payment) OVER (PARTITION BY industry_branch_name ORDER BY year)) * 100,0) AS payment_percent
				FROM t_marcela_travnickova_project_sql_primary_final tmtpspf 
				GROUP BY YEAR, industry_branch_name,payment
				ORDER BY industry_branch_name, YEAR)
			SELECT YEAR, round(avg(payment_percent),0) AS payment_percent
			FROM percent_payment
			GROUP BY YEAR
			ORDER BY YEAR),
	percent_category_final AS (
		WITH percent_category AS (
				SELECT YEAR, category_name, category_value ,
					round(((category_value - LAG(category_value) OVER (PARTITION BY category_name ORDER BY year)) /
					lag(category_value) OVER (PARTITION BY category_name ORDER BY year)) * 100,0) AS category_percent
				FROM t_marcela_travnickova_project_sql_primary_final tmtpspf 
				WHERE payment IS NOT null
				GROUP BY YEAR, category_name, category_value
				ORDER BY category_name,year)
			SELECT YEAR, round(avg(category_percent),0) AS category_percent
			FROM percent_category
			group BY YEAR
			ORDER BY YEAR)
SELECT phdp.*, ppay.payment_percent, pcat.category_percent
FROM percent_hdp_final phdp
JOIN percent_payment_final ppay
ON phdp.YEAR = ppay.YEAR
JOIN percent_category_final pcat
ON phdp.YEAR = pcat.year);

--- PRŮMĚRNÉ MEZIROČNÍ RŮSTY 
SELECT
	round(avg(hdp_percent),0) AS avg_hdp,
	round(avg(payment_percent),0) AS avg_payment,
	round(avg(category_percent),0) AS avg_category
FROM avg_table;

--- průměrný meziroční růst HDP je 2 %
--- průměrný meziroční růst mzdy je 4 %
--- průměrný meziroční růst cen potravin je 3 %

SELECT *
FROM avg_table
WHERE hdp_percent >= 3 OR hdp_percent_prev >= 3;
