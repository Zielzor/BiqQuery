CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Global` as 
SELECT
productNo_key,
salesOrg_key,
salesPrice,
conditionCurr,
purPriceAverage,
purPriceAverageCurrency,
"X" productExists

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` 

WHERE statusWebshop = "C"



--------- nowe podejscie 
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as 
SELECT 
a.productNo_key,
a.ActivePL,
b.ActiveSKK



FROM `ceeregion-prod.DimEastProductsAvalaibility.Poland` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Slovakia` as b on a.productNo_key = b.productNo_key;

-----
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as 
SELECT
a.productNo_key,
a.ActivePL,
a.ActiveSKK,
b.ActiveCzech

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Czech` as b on a.productNo_key = b.productNo_key;

----
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as 
SELECT
a.productNo_key,
a.ActivePL,
a.ActiveSKK,
a.ActiveCzech,
b.ActiveSlovenien

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Slowenien` as b on a.productNo_key = b.productNo_key;
---------
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as 
SELECT
a.productNo_key,
a.ActivePL,
a.ActiveSKK,
a.ActiveCzech,
a.ActiveSlovenien,
b.ActiveCroatia,

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Croatia` as b on a.productNo_key = b.productNo_key;

----
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as 
SELECT
a.productNo_key,
a.ActivePL,
a.ActiveSKK,
a.ActiveCzech,
a.ActiveSlovenien,
a.ActiveCroatia,
b.ActiveHungary

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExitance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Hungary` as b on a.productNo_key = b.productNo_key;



