CREATE OR REPLACE TABLE `ceeregion-prod.AA_MarginActions_Slovenia.SUMNNT_Before_SLO` as 
SELECT DISTINCT
MATKL,
Categorie,
HeadGroup,
SUM(nnt) as  SUM_NNT,
FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_SLO` 
WHERE Data between '2020-07-10' and '2020-08-10'
GROUP BY MATKL, Categorie, HeadGroup;


CREATE OR REPLACE TABLE `ceeregion-prod.AA_MarginActions_Slovenia.SUMNNT_After_SLO` as 
SELECT DISTINCT
MATKL,
Categorie,
HeadGroup,
SUM(nnt) as  SUM_NNT,
FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_SLO` 
WHERE Data between '2020-08-10' and '2020-09-10'
GROUP BY MATKL, Categorie, HeadGroup;

----HR
CREATE OR REPLACE TABLE `ceeregion-prod.AA_MarginActions_Slovenia.SUMNNT_Before_HR` as 
SELECT DISTINCT
MATKL,
Categorie,
HeadGroup,
SUM(nnt) as  SUM_NNT,
FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_HR` 
WHERE Data between '2020-07-10' and '2020-08-10'
GROUP BY MATKL, Categorie, HeadGroup;

CREATE OR REPLACE TABLE `ceeregion-prod.AA_MarginActions_Slovenia.SUMNNT_After_HR` as 
SELECT DISTINCT
MATKL,
Categorie,
HeadGroup,
SUM(nnt) as  SUM_NNT,
FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_HR` 
WHERE Data between '2020-08-10' and '2020-09-10'
GROUP BY MATKL, Categorie, HeadGroup;