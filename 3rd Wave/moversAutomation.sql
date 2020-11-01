CREATE OR REPLACE TABLE `ceeregion-prod.NonMoversAutomation.step1_grouping_matklasses`  as 
SELECT  
_23_MATKL  as MATKL,
SUM(_35_NNT_EURO) as NNT,
SUM(_35_NNT_EURO) /(SELECT SUM(_35_NNT_EURO) FROM`ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_PL`) as PercentageOfTotal

FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_PL`

GROUP BY _23_MATKL
ORDER BY  NNT DESC
------Additional aggregation
CREATE OR REPLACE TABLE `ceeregion-prod.NonMoversAutomation.step1_grouping_matklasses`  as 
SELECT
MATKL, NNT, ROUND(PercentageOfTotal,3) as PercentageOfTotal
FROM `ceeregion-prod.NonMoversAutomation.step1_grouping_matklasses` order by PercentageOfTotal ASC

--chekcing the % of total nnt
CREATE OR REPLACE TABLE `ceeregion-prod.NonMoversAutomation.step2_running_total` as 
SELECT 
MATKL,
NNT,
PercentageOfTotal,
SUM(PercentageOfTotal) OVER (ORDER BY NNT) as RunningTotal 

FROM `ceeregion-prod.NonMoversAutomation.step1_grouping_matklasses` 

ORDER BY NNT ASC;
-----Grouping them as movers
CREATE OR REPLACE TABLE `ceeregion-prod.NonMoversAutomation.step3_grouping_movers`  as 
SELECT 
CURRENT_DATE() as Aktualizacja,
MATKL,
RunningTotal,
CASE
WHEN NNT = 0 THEN "NON MOVER"
WHEN RunningTotal >= 0.8 THEN "TOP MOVER"
WHEN RunningTotal < 0.8 THEN "SLOW  MOVER"
END as MoversClass,
NNT,
PercentageOfTotal,


FROM `ceeregion-prod.NonMoversAutomation.step2_running_total`;

--------
CREATE OR REPLACE TABLE `ceeregion-prod.NonMoversAutomation.step4_crossfulloffer` as 
SELECT 
Aktualizacja,
a.MATKL,
RunningTotal, 
MoversClass, 
NNT, 
PercentageOfTotal

FROM `ceeregion-prod.NonMoversAutomation.MATKLAS`as a
LEFT JOIN `ceeregion-prod.NonMoversAutomation.step3_grouping_movers`as b on a.MATKL = b.MATKL
ORDER BY NNT ASC;

-------------
CREATE OR REPLACE TABLE  `ceeregion-prod.NonMoversAutomation.step5_final` as 
SELECT 
Aktualizacja, 
MATKL, 
RunningTotal, 
CASE
WHEN NNT = 0  or NNT is null THEN "NON MOVER"
WHEN RunningTotal >= 0.8 THEN "TOP MOVER"
WHEN RunningTotal < 0.8 THEN "SLOW  MOVER"
END as MoversClass,
NNT, 
PercentageOfTotal

FROM `ceeregion-prod.NonMoversAutomation.step4_crossfulloffer` 

