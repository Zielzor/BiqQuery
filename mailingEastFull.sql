CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Poland` as 
SELECT
productNo_key,
salesOrg_key,
salesPrice,
conditionCurr,
purPriceAverage,
purPriceAverageCurrency,
'X'  ActivePL

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` 

WHERE statusWebshop = "C"
AND salesOrg_key = "5810";

------
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Slovakia` as 
SELECT
productNo_key,
salesOrg_key,
salesPrice,
conditionCurr,
purPriceAverage,
purPriceAverageCurrency,
'X'  ActiveSKK

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` 

WHERE statusWebshop = "C"
AND salesOrg_key = "5800";
------
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Czech` as 
SELECT
productNo_key,
salesOrg_key,
salesPrice,
conditionCurr,
purPriceAverage,
purPriceAverageCurrency,
'X'  ActiveCzech

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` 

WHERE statusWebshop = "C"
AND salesOrg_key = "5850";
----
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Slowenien` as 
SELECT
productNo_key,
salesOrg_key,
salesPrice,
conditionCurr,
purPriceAverage,
purPriceAverageCurrency,
'X'  ActiveSlovenien

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` 

WHERE statusWebshop = "C"
AND salesOrg_key = "5900";
------
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Croatia` as 
SELECT
productNo_key,
salesOrg_key,
salesPrice,
conditionCurr,
purPriceAverage,
purPriceAverageCurrency,
'X'  ActiveCroatia

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` 

WHERE statusWebshop = "C"
AND salesOrg_key = "5910";
-----
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Hungary` as 
SELECT
productNo_key,
salesOrg_key,
salesPrice,
conditionCurr,
purPriceAverage,
purPriceAverageCurrency,
'X'  ActiveHungary

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` 

WHERE statusWebshop = "C"
AND salesOrg_key = "5950";