---POLAND
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Poland` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPricePLN,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit as GrossPolishSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.23),2) / a.priceUnit as NetPolishSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.23) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.23),3)  as MarginPL,
'X'  ActivePL

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5810"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

---SLOVAKIA
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Slovakia` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceSKK,
ROUND((a.salesPrice * b.rate), 2) / a.priceUnit  as GrossSlovakSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.20),2) / a.priceUnit as NetSlovakSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.20) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.20),3) as MarginSKK,
'X'  ActiveSKK

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5800"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

---CZECH
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Czech` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceCZ,
ROUND((a.salesPrice * b.rate), 2)  as GrossCzechSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.21),2) / a.priceUnit as NetCzechSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.21) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.21),3) as MarginCZ,
'X'  ActiveCZ

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5850"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

---SLOWENIA
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Slowenien` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceSLO,
ROUND((a.salesPrice * b.rate), 2) / a.priceUnit as GrossSlowenienSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.22),2) / a.priceUnit as NetSlowenienSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.22) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.22),3) as MarginSLO,
'X'  ActiveSLO

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5900"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

---CROATIA
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Croatia` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceHR,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossCroatianSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.25),2)  / a.priceUnit as NetCroatianSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.25) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.25),3) as MarginHR,
'X'  ActiveHR

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5910"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

---HUNGARY
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Hungary` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceHU,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossHungarianSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.27),2)  / a.priceUnit as NetHungarianSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.27) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.27),3) as MarginHU,
'X'  ActiveHU

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5950"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;




----Creating the Global File

---part1
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as 
SELECT 
a.productNo_key,
a.GrossSalesPricePLN,
a.GrossPolishSalePriceInEUR,
a.NetPolishSalePriceInEUR,
a.MarginPL,
a.ActivePL,
b.GrossSalesPriceSKK,
b.GrossSlovakSalePriceInEUR,
b.NetSlovakSalePriceInEUR,
b.MarginSKK,
b.ActiveSKK,

FROM `ceeregion-prod.DimEastProductsAvalaibility.Poland` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Slovakia` as b on a.productNo_key = b.productNo_key;

---part2
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as  
SELECT
a.productNo_key,
a.GrossSalesPricePLN,
a.GrossPolishSalePriceInEUR,
a.NetPolishSalePriceInEUR,
a.MarginPL,
a.ActivePL,
a.GrossSalesPriceSKK,
a.GrossSlovakSalePriceInEUR,
a.NetSlovakSalePriceInEUR,
a.MarginSKK,
a.ActiveSKK,
b.GrossSalesPriceCZ,
b.GrossCzechSalePriceInEUR,
b.NetCzechSalePriceInEUR,
b.MarginCZ,
b.ActiveCZ

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Czech` as b on a.productNo_key = b.productNo_key;

---part3
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as 
SELECT
a.productNo_key,
a.GrossSalesPricePLN,
a.GrossPolishSalePriceInEUR,
a.NetPolishSalePriceInEUR,
a.MarginPL ,
a.ActivePL,
a.GrossSalesPriceSKK,
a.GrossSlovakSalePriceInEUR,
a.NetSlovakSalePriceInEUR,
a.MarginSKK,
a.ActiveSKK,
a.GrossSalesPriceCZ,
a.GrossCzechSalePriceInEUR,
a.NetCzechSalePriceInEUR,
a.MarginCZ,
a.ActiveCZ,
b.GrossSalesPriceSLO,
b.GrossSlowenienSalePriceInEUR,
b.NetSlowenienSalePriceInEUR,
b.MarginSLO,
b.ActiveSLO


FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Slowenien` as b on a.productNo_key = b.productNo_key;

---part4
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as 
SELECT
a.productNo_key,
a.GrossSalesPricePLN,
a.GrossPolishSalePriceInEUR,
a.NetPolishSalePriceInEUR,
a.MarginPL, 
a.ActivePL,
a.GrossSalesPriceSKK,
a.GrossSlovakSalePriceInEUR,
a.NetSlovakSalePriceInEUR,
a.MarginSKK,
a.ActiveSKK,
a.GrossSalesPriceCZ,
a.GrossCzechSalePriceInEUR,
a.NetCzechSalePriceInEUR,
a.MarginCZ,
a.ActiveCZ,
a.GrossSalesPriceSLO,
a.GrossSlowenienSalePriceInEUR,
a.NetSlowenienSalePriceInEUR,
a.MarginSLO,
a.ActiveSLO,
b.GrossSalesPriceHR,
b.GrossCroatianSalePriceInEUR,
b.NetCroatianSalePriceInEUR,
b.MarginHR,
b.ActiveHR


FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Croatia` as b on a.productNo_key = b.productNo_key;

---part5
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as 
SELECT
a.productNo_key,
a.GrossSalesPricePLN,
a.GrossPolishSalePriceInEUR,
a.NetPolishSalePriceInEUR,
a.MarginPL ,
a.ActivePL,
a.GrossSalesPriceSKK,
a.GrossSlovakSalePriceInEUR,
a.NetSlovakSalePriceInEUR,
a.MarginSKK,
a.ActiveSKK,
a.GrossSalesPriceCZ,
a.GrossCzechSalePriceInEUR,
a.NetCzechSalePriceInEUR,
a.MarginCZ,
a.ActiveCZ,
a.GrossSalesPriceSLO,
a.GrossSlowenienSalePriceInEUR,
a.NetSlowenienSalePriceInEUR,
a.MarginSLO,
a.ActiveSLO,
a.GrossSalesPriceHR,
a.GrossCroatianSalePriceInEUR,
a.NetCroatianSalePriceInEUR,
a.MarginHR,
a.ActiveHR,
b.GrossSalesPriceHU,
b.GrossHungarianSalePriceInEUR,
b.NetHungarianSalePriceInEUR,
b.MarginHU,
b.ActiveHU

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Hungary` as b on a.productNo_key = b.productNo_key;
