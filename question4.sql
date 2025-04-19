--- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH percent_payment_final AS (
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
SELECT ppf.*, pcf.category_percent, pcf.category_percent - ppf.payment_percent AS difference
FROM percent_payment_final ppf
FULL OUTER JOIN percent_category_final pcf
ON ppf.YEAR = pcf.YEAR
WHERE pcf.YEAR IS NOT NULL AND pcf.category_percent IS NOT null
ORDER BY difference desc;
