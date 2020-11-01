CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_Customers` as 
SELECT
Nazwa, 
NIP,
taxno1,
taxno2,
CASE 
WHEN taxno1 is not null or taxno2 is not null then "X"
ELSE null
END AS Conrad,
customerNo,
customerNo_key,
salesDistrict
FROM `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_NIP`  as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as b on cast(a.NIP as STRING)  = b.taxNo1;
--------------- dowiazanie do nnt 2019
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_nnt2019` as 
SELECT
a.*,
SUM(b._39_NNT_PLN) as NNT_2019
FROM `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_Customers` as a 
LEFT JOIN `ceeregion-prod.StaticYears_CEPL.Dasboard_CEPL_2019_costalloc` as b  ON a.customerNo_key =b._7_Customer_No

GROUP BY a.Nazwa,a.NIP,a.taxno1,taxno2,a.Conrad,a.customerNo,a.customerNo_key,a.salesDistrict;
----------- dowiazanie nnt 2020
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_nnt2020` as 
SELECT
a.*,
SUM(b._39_NNT_PLN) as NNT_2020
FROM `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_nnt2019` as a 
LEFT JOIN `ceeregion-prod.Dashboardy.Dashboard_PL_Sales_2020` as b  ON a.customerNo_key =b._7_Customer_No

GROUP BY a.Nazwa,a.NIP,a.taxno1,taxno2,a.Conrad,a.customerNo,a.customerNo_key,a.salesDistrict,a.NNT_2019;
---- Filtry dla widoku
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_finalData` as 
SELECT 
Nazwa,
NIP,
Conrad,
customerNo,
a.salesDistrict,
KamName,
NNT_2019,
NNT_2020
FROM `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_nnt2020` as a 
LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST` as b on a.salesDistrict = b.SalesDistrict;
--- drop śmietnika
DROP TABLE `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_Customers`;
DROP TABLE `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_nnt2019`;
DROP TABLE `ceeregion-prod.CEPL_Bisnode_Customers.Bisnode_nnt2020`;




