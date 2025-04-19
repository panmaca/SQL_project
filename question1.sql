--- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

--- ODVĚTVÍ, KDE MZDA NEROSTLA
CREATE TEMPORARY TABLE payment_diff_minus AS (
WITH payment_diff AS (
	SELECT 
			YEAR,
			industry_branch_name,
			payment,
			round(payment - LAG(payment) OVER (PARTITION BY industry_branch_name ORDER BY year),0) AS industry_diff
		FROM t_marcela_travnickova_project_sql_primary_final tmtpspf 
		GROUP BY YEAR, industry_branch_name, payment 
		ORDER BY YEAR)
SELECT *
FROM payment_diff
WHERE industry_diff <= 0 AND industry_diff IS NOT null
ORDER BY YEAR, industry_branch_name);

--- ODVĚTVÍ, KDE MZDA ROSTLA
SELECT industry_branch_name
FROM t_marcela_travnickova_project_sql_primary_final tmtpspf 
EXCEPT
SELECT industry_branch_name 
FROM payment_diff_minus pdm
ORDER BY industry_branch_name;

--- V KOLIKA LETECH A ODVĚTVÍCH MZDA NEROSTLA
SELECT year,
	count(*) AS year_decline
FROM payment_diff_minus
GROUP BY year
ORDER BY year_decline desc
;

SELECT industry_branch_name,
	count(*) AS industry_decline
FROM payment_diff_minus
GROUP BY industry_branch_name
ORDER BY industry_decline desc
;
