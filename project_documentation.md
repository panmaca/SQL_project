# PROJEKT SQL

## VYTVOŘENÍ PRIMARY TABULKY

Primary tabulku jsem vytvořila pomocí pěti tabulek. Pomocí klauzole WITH jsem definovala dvě pomocné tabulky - v první jsem seskupila data o mzdách, tj. napojila jsem tabulku
o průměrných mzdách za několikaleté období v různých odvětvích s číselníkem těchto odvětvích a data jsem doplnila o údaje o HDP. Filtrovala jsem údaje pouze pro Českou republiku
a pouze průměrnou mzdu, bez nulových hodnot. Druhá pomocná tabulka seskupuje data o cenách různých kategorií potravin za několikaté období s číselníkem kategorií potravin. Tyto
dvě pomocné tabulky jsem napojila na sebe a vybrala z nich proměnné rok, název odvětví, průměrná mzda, průměrné HDP, název kategorie potravin a průměrná cena kategorie potraviny.
Protože druhá pomocná tabulka obsahovala kratší časové období, napojila jsem ji zprava na první pomocnou tabulku. 

Ve výsledné tabulce je 19 odvětví a 27 kategorií potravin v průběhu let 2006-2018 v České republice.

## VYTVOŘENÍ SECONDARY TABULKY

Secondary tabulku jsem vytvořila opět pomocí pomocných tabulek (CTE). Nejdříve jsem si z tabulky economies vybrala požadované údaje (zemi, rok, HDP, populaci, GINI), a to pouze
pro roky 2006 - 2018 (což odpovídá časovému období v primary tabulce). Ve druhé pomocné tabulce jsem si z tabulky countries vyfiltrovala pouze ty státy, které leží na evropském
kontitentu. Poté jsem obě pomocné tabulky napojila na sebe, secondary tabulka tak obsahuje údaje z první pomocné tabulky pouze pro státy na evropském kontinentu. 


## VÝZKUMNÉ OTÁZKY, ODPOVĚDI A POSTUP

### OTÁZKA 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

Mzda rostla v průběhu let pouze ve čtyřech odvětvích. Ve zbývajících 15 odvětvích byl vždy minimálně jeden rok, kdy mzda oproti předchozímu roku klesla.

Odvětví, kde mzda rostla ve všech sledovaných letech jsou:
- Doprava a skladování
- Ostatní činnosti
- Zdravotní a sociální péče 
- Zpracovatelský průmysl

Ve zbývajících odvětvích mzda nerostla v sedmi letech (2009, 2010, 2011, 2013, 2014, 2015, 2016). 
Z pohledu růstu mzdy je nejhorším rokem rok 2013, ve kterém se meziročně mzda snížila v největším (11) počtu odvětví. 
V roce 2009, 2010 a 2011 to byly tři odvětví a ve zbývajících jedno odvětví.

Nejčastěji (4x) nerostla mzda v odvětví Těžba a dobývaní. 
Ve dvou letech nerostla mzda v následujících odvětvích: Profesní, vědecké a technické činnosti, Ubytování, stravování a pohostinství, 
Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu, Kulturní, zábavní a rekreační činnosti, Veřejná správa a obrana; povinné sociální zabezpečení. 
Ve zbývajících odvětvích mzda nerostla pouze jednou.

**Postup**
Nejdříve jsem vytvořila dočasnou tabulku, v rámci které jsem si udělala ještě pomocnou tabulku - ta mi posloužila pro výpočet meziročního rozdílu ve mzdě pomocí LAG funkce. 
V dočasné tabulce jsem si zobrazila rok, název odvětví, mzdu a vypočítaný meziroční rozdíl ve mzdě. Tuto tabulku jsem filtrovala pouze na údaje o těch letech, 
kdy byl meziroční rozdíl nulový (což nebyl ani jednou) nebo mínusový, bez nulových hodnot.

Následně jsem napojila primary tabulku na tuto dočasnou tabulku a vyselektovala jsem pouze ta odvětví, která jsou v primary tabulce, ale nejsou v dočasné (tedy ta, kde mzda rostla).
Poté jsem si z dočasné tabulky spočítala počet let a odvětví, kdy mzda nerostla.

### OTÁZKA 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

V roce 2006 bylo možné koupit si 1 287 litrů mléka a 1 437 kilogramů chleba. V roce 2018 to bylo 1 342 litrů mléka a 1 642 kilogramů chleba.

**Postup**: 
Primary tabulku jsem filtrovala pouze na kategorii potravin chleba a mléka za první (2006) a poslední (2018) srovnatelné období. Vypočítala jsem průměrnou mzdu 
ze všech průměrných mezd všech odvětví, tu jsem vydělila cenou za litr mléka/kilogram chleba.

### OTÁZKA 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

Nejnižší percentuální meziroční nárůst (- 30 %) je u kategorie Rajská jablka červená kulatá, a to v roce 2007.

**Postup**: 
Meziroční růst cen kategorie potravin jsem vypočítala opět pomocí LAG funkce. Data jsem seskupila dle let, kategorie a ceny. Nejnižší meziroční nárůst jsem našla díky seřazení 
tabulky dle procent a omezení zobrazených řádků pouze na jeden.

### OTÁZKA 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

Ne, takový rok neexistuje. Nejvýraznější meziroční nárůst cen potravin oproti růstu mezd byl v roce 2013 (7 %).

**Postup**: 
Opět jsem použila výpočet meziročního nárůstu, a to jak u mezd, tak u cen potravin. Pro mzdy i ceny potraviny jsem meziroční růst počítala zvlášť v pomocných dotazech. 
Nejdříve jsem udělala meziroční nárůst jednotlivých odvětví/kategorií, z toho jsem následně spočítala průměrný meziroční nárůst.
V rámci třetí pomocné tabulky (CTE) jsem poté vypočítala rozdíl mezi průměrným meziročním nárůstem cen potravin a meziročním nárůstem mezd, a to pouze pro roky, 
pro které jsem znala obě hodnoty, tj. bez nulových hodnot.

### OTÁZKA 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? 
### Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

Ano, ve čtyřech letech (2007, 2008, 2017, 2018) má výška HDP vliv na změny ve mzdách a cenách potravin.

Za výraznější růst považuji růst vyšší minimálně o jedno procento, než byl průměrný meziroční růst - konkrétně u HDP je pro mě výraznější růst 3 %, u mezd 5 % a u cen potravin 4 %.

V roce 2007 byl meziroční růst HDP 6 %, výrazný meziroční růst byl také u mezd (7 %) a cen potravin (9 %). 
O rok později, v roce 2008, byl meziroční růst HDP stále výrazný (3 %), meziroční růst mezd a cen potravin zůstal stejně vysoký jako v předchozím roce (7 % mzdy, 9 % potraviny). 
V roce 2009 byl růst HDP 5 %, a nerostly ani mzdy (3 %) ani ceny potravin (ty dokonce zlevnily, růst byl - 7 %).

V roce 2015 byl opět výrazný meziroční růst HDP (5 %), u mezd ani cen potravin ale ne (mzdy 3 %, potraviny - 1 %). V roce 2016 HDP rostlo stále výrazně (3 %), 
mzdy ale pouze průměrně (4 %) a ceny potravin zlevňovaly (- 1 %). O rok později, v roce 2017, byl meziroční růst u všech tří sledovaných proměnných: HDP vzrostlo o 5 %, 
mzdy o 6 % a ceny potravin o 7 %. V poslední sledovaném roce, tedy 2018, rostlo výrazněji HDP (3 %) a mzdy (8 %), ceny potravin ale už jen podpůrně (2 %).

**Postup**: 
K meziročnímu nárůstu mezd a cen potravin jsem přidala ještě meziroční růst HDP. Meziroční růst mezd a cen potravin jsem počítala opět v oddělených CTE za užití funkce LAG 
nejdříve pro jednotlivé odvětví/kategorie, což jsem následně zprůměrovala. U HDP jsem si (opět v rámci CTE) vytvořila ještě proměnnou meziročního růstu v předcházejícím roce. 
Všechny meziroční růsty jsem poté spojila do jedné dočasné tabulky a z té jsem následně vypočítala průměrný meziroční růst jednotlivých proměnných. 
Nakonec jsem si z dočasné tabulky vyfiltrovala pouze ty roky, kdy byl meziroční růst v daném nebo předchozím roce výrazně vyšší než průměrný meziroční růst HDP 
a sledovala jsem, zda byl výrazně vyšší meziroční růst také u mezd a cen potravin.
