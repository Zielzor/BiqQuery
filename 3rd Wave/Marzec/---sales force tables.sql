---creating a table for poland
CREATE OR REPLACE TABLE `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_PL` AS 
SELECT  *
FROM `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_EAST`
WHERE Laendercode = 'PL';

---creating a table for slowenia
CREATE OR REPLACE TABLE `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_SL` AS 
SELECT  *
FROM `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_EAST`
WHERE Laendercode = 'SL';

---creating a table for croatia
CREATE OR REPLACE TABLE `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_HR` AS 
SELECT  *
FROM `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_EAST`
WHERE Laendercode = 'HR';

---creating a table for hungary
CREATE OR REPLACE TABLE `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_HU` AS 
SELECT  *
FROM `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_EAST`
WHERE Laendercode = 'HU';

---creating a table for czechia 
CREATE OR REPLACE TABLE `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_CZ` AS 
SELECT  *
FROM `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_EAST`
WHERE Laendercode = 'CZ';

---creating a table for slowakia
CREATE OR REPLACE TABLE `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_SK` AS 
SELECT  *
FROM `ceeregion-prod.SalesForceSelection_EAST.SalesForceSelection_EAST`
WHERE Laendercode = 'SK';