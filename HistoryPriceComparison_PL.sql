---- stworzenie listy ID dla kraju
CREATE OR REPLACE TABLE `ceeregion-prod.DimPLPurPriceHistory.step1`  as 
SELECT 
productNo_key,
Product_ID,
Nazwa,
FROM `ceeregion-prod.PriceFile.PriceFile_PL`;

--- miesiące dla kraju, na początek powiedzmy z dwóch
---step 2
CREATE OR REPLACE TABLE `ceeregion-prod.DimPLPurPriceHistory.step2`  as
SELECT 
productNo_key,
salesOrg_key,
dateValidFrom_key as dateValidFrom_09,
dateValidTo_key as datevalidTo_09,
purPriceAverage as purPriceAverage_09,
priceUnit as priceUnit_09,
salesPrice as salesPrice_09,
unitSalesPrice as unitSalesPrice_09

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_HistProductSalesOrg.HistProductSalesOrg` 

WHERE salesOrg_key = '5810'
AND dateValidFrom_key >=  20200901 and dateValidTo_key <= 20200931

order by productNo_key ,dateValidFrom_key ASC;

----- step3
CREATE OR REPLACE TABLE `ceeregion-prod.DimPLPurPriceHistory.step3`  as
SELECT 
productNo_key,
salesOrg_key,
dateValidFrom_key as dateValidFrom_10,
dateValidTo_key as datevalidTo_10,
purPriceAverage as purPriceAverage_10,
priceUnit as priceUnit_10,
salesPrice as salesPrice_10,
unitSalesPrice as unitSalesPrice_10

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_HistProductSalesOrg.HistProductSalesOrg` 

WHERE salesOrg_key = '5810'
AND dateValidFrom_key >=  20201001 and dateValidTo_key <= 20201031

order by productNo_key ,dateValidFrom_key ASC;
----step4
CREATE OR REPLACE TABLE `ceeregion-prod.DimPLPurPriceHistory.step4`  as
SELECT 
productNo_key,
salesOrg_key,
dateValidFrom_key as dateValidFrom_11,
dateValidTo_key as datevalidTo_11,
purPriceAverage as purPriceAverage_11,
priceUnit as priceUnit_11,
salesPrice as salesPrice_11,
unitSalesPrice as unitSalesPrice_11

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_HistProductSalesOrg.HistProductSalesOrg` 

WHERE salesOrg_key = '5810'
AND dateValidFrom_key >=  20201101 and dateValidTo_key <= 20201131

order by productNo_key ,dateValidFrom_key ASC;

--- dowiazanie miesiecy i iD to price file
---step5
CREATE OR REPLACE TABLE `ceeregion-prod.DimPLPurPriceHistory.step5` as
SELECT  DISTINCT
a.productNo_key,
a.Product_ID,
a.Nazwa,
b.dateValidFrom_09,
b.datevalidTo_09,
b.purPriceAverage_09,
b.priceUnit_09,
b.salesPrice_09,
b.unitSalesPrice_09
FROM `ceeregion-prod.DimPLPurPriceHistory.step1` as a
LEFT JOIN `ceeregion-prod.DimPLPurPriceHistory.step2` as b on a.productNo_key = b.productNo_key

WHERE  a.Nazwa is not null;
------step6
CREATE OR REPLACE TABLE `ceeregion-prod.DimPLPurPriceHistory.step6` as
SELECT DISTINCT
a.productNo_key,
a.Product_ID,
a.Nazwa,
a.dateValidFrom_09,
a.datevalidTo_09,
a.purPriceAverage_09,
a.priceUnit_09,
a.salesPrice_09,
a.unitSalesPrice_09,
b.dateValidFrom_10, 
b.datevalidTo_10, 
b.purPriceAverage_10, 
b.priceUnit_10, 
b.salesPrice_10, 
b.unitSalesPrice_10
FROM `ceeregion-prod.DimPLPurPriceHistory.step5`as a
LEFT JOIN `ceeregion-prod.DimPLPurPriceHistory.step3` as b on a.productNo_key = b.productNo_key

WHERE  a.Nazwa is not null;
----step7
CREATE OR REPLACE TABLE `ceeregion-prod.DimPLPurPriceHistory.step7` as
SELECT DISTINCT
a.productNo_key,
a.Product_ID,
a.Nazwa,
a.dateValidFrom_09,
a.datevalidTo_09,
a.purPriceAverage_09,
a.priceUnit_09,
a.salesPrice_09,
a.unitSalesPrice_09,
a.dateValidFrom_10, 
a.datevalidTo_10, 
a.purPriceAverage_10, 
a.priceUnit_10, 
a.salesPrice_10, 
a.unitSalesPrice_10
b.dateValidFrom_11, 
b.datevalidTo_11, 
b.purPriceAverage_11, 
b.priceUnit_11, 
b.salesPrice_11, 
b.unitSalesPrice_11
FROM `ceeregion-prod.DimPLPurPriceHistory.step6`as a
LEFT JOIN `ceeregion-prod.DimPLPurPriceHistory.step4` as b on a.productNo_key = b.productNo_key

WHERE  a.Nazwa is not null
ORDER BY productNo_key DESC;