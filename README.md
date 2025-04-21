# SQL PROJEKT

## Cíl projektu
Cílem tohoto projektu je analýza dostupnosti základních potravin široké veřejnosti v České republice na základě průměrných příjmů za časové období 2006-2018. 
Součástí projektu je také přehled HDP, GINI koeficientu a populace dalších evropských států ve stejném období pro srovnání.

## Datové zdroje
Pro analýzu byly použity následující datové sady:
- `czechia_payroll` – Informace o mzdách v různých odvětvích za několikaleté období.
- `czechia_price` – Informace o cenách vybraných potravin za několikaleté období.
- Číselníky: `czechia_payroll_industry_branch`,`czechia_price_category`
- `economies` - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
- `countries` - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.

## Struktura projektu
Projekt obsahuje následující soubory:

- [**create_tables.sql**](create_tables.sql) - Skript pro vytvoření primární a sekundární tabulky
- [**question1.sql**](question1.sql) - Skript pro zodpovězení první otázky (růst nebo pokles mezd v odvětvích)
- [**question2.sql**](question2.sql) - Skript pro zodpovězení druhé otázky (kolik je možné si koupit mléka a chleba v letech 2006 a 2018)
- [**question3.sql**](question3.sql) - Skript pro zodpovězení třetí otázky (kategorie potravin s nejnižším meziročním nárůstem cen)
- [**question4.sql**](question4.sql) - Skript pro zodpovězení čtvrté otázky (výrazný meziroční nárůst cen potravin oproti růstu mezd)
- [**question5.sql**](question5.sql) - Skript pro zodpovězení páté otázky (vliv HDP na změny mezd a cen potravin)
- [**documentation.md**](documentation.md) - Dokumentace projektu (postupy, otázky a odpovědi)

## Výzkumné otázky

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin?

## Hlavní zjištění

- Mzdy každoročně rostly ve sledovaném období pouze ve 4 z 19 sledovaných odvětví.
- V roce 2006 bylo možné koupit si 1 287 litrů mléka a 1 437 kilogramů chleba. V roce 2018 to bylo 1 342 litrů mléka a 1 642 kilogramů chleba.
- Nejnižší meziroční nárůst cen byl u rajčat v roce 2007 (- 30 %).
- Neexistuje rok, kdy by nárůst cen potravin převyšoval růst mezd o více než 10%.
- Ve 4 letech (2007, 2008, 2017, 2018) byl vliv výrazného růstu HDP na růst mezd a cen potravin.
