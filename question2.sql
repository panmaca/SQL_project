--- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT 
	category_name, 
	YEAR, 
	avg(payment) AS avg_payment,
	category_value,
	round(avg(payment) / category_value) AS amount
FROM t_marcela_travnickova_project_sql_primary_final tmtpspf 
WHERE  
	category_name IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	AND YEAR IN (2006, 2018)
GROUP BY 
	category_name, 
	YEAR,
	category_value
ORDER BY category_name, year
;
