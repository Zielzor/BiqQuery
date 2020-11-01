CREATE OR REPLACE TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step1` as  
SELECT 
Data, customerNo_key, ProfitCenter, Customer_information, CustomerName1, CustomerName2
FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_CZ`;

--------- dowiazanie dim customer
CREATE OR REPLACE TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step2` as  
SELECT DISTINCT
a.Data,
b.dateCreation, 
a.customerNo_key, 
a.ProfitCenter, 
a.CustomerName1 as Customer_Name_Part1, 
a.CustomerName2 as Customer_Name_Part2,
b.street,
city,
zipCode,
b.eMailAddress,
b.taxNo1,
taxNo2,
FROM `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step1`  as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as b on a.customerNo_key = b.customerNo_key
WHERE dateCreation > "2020-01-01";
-------------------Tydzien pierwszego zamówienia
CREATE OR REPLACE TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step3` as
SELECT
a.Data,
b.calendarWeek as WeekOfOrder,
a.dateCreation, 
a.customerNo_key, 
a.ProfitCenter, 
a.Customer_Name_Part1, 
a.Customer_Name_Part2, 
a.street, 
a.city, 
a.zipCode, 
a.eMailAddress, 
a.taxNo1, 
a.taxNo2
FROM `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step2` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b on a.Data = b.date;
------------------ Tydzien utworzenia klienta
CREATE OR REPLACE TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step4` as 
SELECT
a.Data,
b.calendarWeek as WeekOfOrder,
a.dateCreation,
b.calendarWeek as WeekOfCreation, 
a.customerNo_key, 
a.ProfitCenter, 
a.Customer_Name_Part1, 
a.Customer_Name_Part2, 
a.street, 
a.city, 
a.zipCode, 
a.eMailAddress, 
a.taxNo1, 
a.taxNo2
FROM `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step2` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b on a.dateCreation = b.date;
---------agregacja i ETL
CREATE OR REPLACE TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.NewCustomers_CZ` as 
SELECT
a.Data, 
a.WeekOfOrder, 
a.dateCreation, 
a.WeekOfCreation, 
a.customerNo_key, 
a.ProfitCenter,
CASE
WHEN a.ProfitCenter = 51230 THEN "B2C"
WHEN a.ProfitCenter = 51232 THEN "B2B"
END AS B2B_B2C,
a.taxNo1, 
a.taxNo2, 
a.Customer_Name_Part1, 
a.Customer_Name_Part2, 
a.street, 
a.city, 
a.zipCode, 
a.eMailAddress 
FROM `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step4` as a

ORDER BY Data DESC;

DROP TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step1`;
DROP TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step2`;
DROP TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step3`;
DROP TABLE `ceeregion-prod.DASHBOARD_NowiKlienci.CZ_step4`;





