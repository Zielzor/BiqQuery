---- EAST
--POLAND
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

-----WEST

---FRANCE
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.France` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceFR,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossFrenchSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.20),2)  / a.priceUnit as NetFrenchSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.20) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.20),3) as MarginFR,
'X'  ActiveFR

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5100"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

---Austria
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Austria` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceAUT,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossAustrianSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.20),2)  / a.priceUnit as NetAustrianSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.20) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.20),3) as MarginAUT,
'X'  ActiveAUT

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5200"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

---Szwajcaria
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Szwajcaria` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceCH,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossSwissSalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.077),2)  / a.priceUnit as NetSwissSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.077) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.077),3) as MarginCH,
'X'  ActiveCH

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5300"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

---Holandia
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Holandia` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceNL,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossDutchalePriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.21),2)  / a.priceUnit as NetDutchSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.21) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.21),3) as MarginNL,
'X'  ActiveNL

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5400"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

--Belgia
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Belgia` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceBE,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossBelgianPriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.21),2)  / a.priceUnit as NetBelgianSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.21) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.21),3) as MarginBE,
'X'  ActiveBE

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5410"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

--UK
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.UK` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceUK,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossUKPriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.21),2)  / a.priceUnit as NetUKSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.21) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.21),3) as MarginUK,
'X'  ActiveUK

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5600"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

--Włochy
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Włochy` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceIT,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossItalianPriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.22),2)  / a.priceUnit as NetItalianSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.22) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.22),3) as MarginIT,
'X'  ActiveIT

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5650"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

--Szwecja
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Szwecja` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceSE,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossSwedishPriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.25),2)  / a.priceUnit as NetSwedishSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.25) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.25),3) as MarginSE,
'X'  ActiveSE

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5700"
AND a.salesPrice != 0
AND a.conditionCurr = b.curr_key
AND b.version_key = "ISJA20060201"
AND b.date_key = 20201214
ORDER BY salesPrice DESC;

--Dania
CREATE OR REPLACE TABLE `ceeregion-prod.DimEastProductsAvalaibility.Dania` as 
SELECT
a.productNo_key,
a.salesOrg_key,
a.priceUnit, 
a.salesPrice as GrossSalesPriceDK,
ROUND((a.salesPrice * b.rate), 2)  / a.priceUnit  as GrossDanishhPriceInEUR,
ROUND((ROUND((a.salesPrice * b.rate), 2) /1.25),2)  / a.priceUnit as NetDanishSalePriceInEUR,
a.purPriceAverage,
--marża
ROUND(((ROUND((a.salesPrice * b.rate), 2) /1.25) - (a.purPriceAverage/a.priceUnit)) / (ROUND((a.salesPrice * b.rate), 2) /1.25),3) as MarginDK,
'X'  ActiveDK

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 
WHERE a.statusWebshop = "C"
AND a.salesOrg_key = "5710"
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

---- WEST

---part6
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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
b.GrossSalesPriceFR,
b.GrossFrenchSalePriceInEUR,
b.NetFrenchSalePriceInEUR,
b.MarginFR,
b.ActiveFR

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.France` as b on a.productNo_key = b.productNo_key;
---part7
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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
a.GrossSalesPriceFR,
a.GrossFrenchSalePriceInEUR,
a.NetFrenchSalePriceInEUR,
a.MarginFR,
a.ActiveFR,
b.GrossSalesPriceAUT,
b.GrossAustrianSalePriceInEUR,
b.NetAustrianSalePriceInEUR,
b.MarginAUT,
b.ActiveAUT

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Austria` as b on a.productNo_key = b.productNo_key;

---part10
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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
a.GrossSalesPriceFR,
a.GrossFrenchSalePriceInEUR,
a.NetFrenchSalePriceInEUR,
a.MarginFR,
a.ActiveFR,
a.GrossSalesPriceAUT,
a.GrossAustrianSalePriceInEUR,
a.NetAustrianSalePriceInEUR,
a.MarginAUT,
a.ActiveAUT,
b.GrossSalesPriceCH,
b.GrossSwissSalePriceInEUR,
b.NetSwissSalePriceInEUR,
b.MarginCH,
b.ActiveCH


FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Szwajcaria` as b on a.productNo_key = b.productNo_key;
---part11
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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
a.GrossSalesPriceFR,
a.GrossFrenchSalePriceInEUR,
a.NetFrenchSalePriceInEUR,
a.MarginFR,
a.ActiveFR,
a.GrossSalesPriceAUT,
a.GrossAustrianSalePriceInEUR,
a.NetAustrianSalePriceInEUR,
a.MarginAUT,
a.ActiveAUT,
a.GrossSalesPriceCH,
a.GrossSwissSalePriceInEUR,
a.NetSwissSalePriceInEUR,
a.MarginCH,
a.ActiveCH,
b.GrossSalesPriceNL,
b.GrossDutchalePriceInEUR,
b.NetDutchSalePriceInEUR,
b.MarginNL,
b.ActiveNL


FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Holandia` as b on a.productNo_key = b.productNo_key;
---part12
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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
a.GrossSalesPriceFR,
a.GrossFrenchSalePriceInEUR,
a.NetFrenchSalePriceInEUR,
a.MarginFR,
a.ActiveFR,
a.GrossSalesPriceAUT,
a.GrossAustrianSalePriceInEUR,
a.NetAustrianSalePriceInEUR,
a.MarginAUT,
a.ActiveAUT,
a.GrossSalesPriceCH,
a.GrossSwissSalePriceInEUR,
a.NetSwissSalePriceInEUR,
a.MarginCH,
a.ActiveCH,
a.GrossSalesPriceNL,
a.GrossDutchalePriceInEUR,
a.NetDutchSalePriceInEUR,
a.MarginNL,
a.ActiveNL,
b.GrossSalesPriceBE,
b.GrossBelgianPriceInEUR,
b.NetBelgianSalePriceInEUR,
b.MarginBE,
b.ActiveBE,



FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Belgia` as b on a.productNo_key = b.productNo_key;
---part13
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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
a.GrossSalesPriceFR,
a.GrossFrenchSalePriceInEUR,
a.NetFrenchSalePriceInEUR,
a.MarginFR,
a.ActiveFR,
a.GrossSalesPriceAUT,
a.GrossAustrianSalePriceInEUR,
a.NetAustrianSalePriceInEUR,
a.MarginAUT,
a.ActiveAUT,
a.GrossSalesPriceCH,
a.GrossSwissSalePriceInEUR,
a.NetSwissSalePriceInEUR,
a.MarginCH,
a.ActiveCH,
a.GrossSalesPriceNL,
a.GrossDutchalePriceInEUR,
a.NetDutchSalePriceInEUR,
a.MarginNL,
a.ActiveNL,
a.GrossSalesPriceBE,
a.GrossBelgianPriceInEUR,
a.NetBelgianSalePriceInEUR,
a.MarginBE,
a.ActiveBE,
b.GrossSalesPriceUK,
b.GrossUKPriceInEUR,
b.NetUKSalePriceInEUR,
b.MarginUK,
b.ActiveUK


FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.UK` as b on a.productNo_key = b.productNo_key;
---part14
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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
a.GrossSalesPriceFR,
a.GrossFrenchSalePriceInEUR,
a.NetFrenchSalePriceInEUR,
a.MarginFR,
a.ActiveFR,
a.GrossSalesPriceAUT,
a.GrossAustrianSalePriceInEUR,
a.NetAustrianSalePriceInEUR,
a.MarginAUT,
a.ActiveAUT,
a.GrossSalesPriceCH,
a.GrossSwissSalePriceInEUR,
a.NetSwissSalePriceInEUR,
a.MarginCH,
a.ActiveCH,
a.GrossSalesPriceNL,
a.GrossDutchalePriceInEUR,
a.NetDutchSalePriceInEUR,
a.MarginNL,
a.ActiveNL,
a.GrossSalesPriceBE,
a.GrossBelgianPriceInEUR,
a.NetBelgianSalePriceInEUR,
a.MarginBE,
a.ActiveBE,
a.GrossSalesPriceUK,
a.GrossUKPriceInEUR,
a.NetUKSalePriceInEUR,
a.MarginUK,
a.ActiveUK,
b.GrossSalesPriceIT,
b.GrossItalianPriceInEUR,
b.NetItalianSalePriceInEUR,
b.MarginIT,
b.ActiveIT


FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Włochy` as b on a.productNo_key = b.productNo_key;

--part 15
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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
a.GrossSalesPriceFR,
a.GrossFrenchSalePriceInEUR,
a.NetFrenchSalePriceInEUR,
a.MarginFR,
a.ActiveFR,
a.GrossSalesPriceAUT,
a.GrossAustrianSalePriceInEUR,
a.NetAustrianSalePriceInEUR,
a.MarginAUT,
a.ActiveAUT,
a.GrossSalesPriceCH,
a.GrossSwissSalePriceInEUR,
a.NetSwissSalePriceInEUR,
a.MarginCH,
a.ActiveCH,
a.GrossSalesPriceNL,
a.GrossDutchalePriceInEUR,
a.NetDutchSalePriceInEUR,
a.MarginNL,
a.ActiveNL,
a.GrossSalesPriceBE,
a.GrossBelgianPriceInEUR,
a.NetBelgianSalePriceInEUR,
a.MarginBE,
a.ActiveBE,
a.GrossSalesPriceUK,
a.GrossUKPriceInEUR,
a.NetUKSalePriceInEUR,
a.MarginUK,
a.ActiveUK,
a.GrossSalesPriceIT,
a.GrossItalianPriceInEUR,
a.NetItalianSalePriceInEUR,
a.MarginIT,
a.ActiveIT,
b.GrossSalesPriceSE,
b.GrossSwedishPriceInEUR,
b.NetSwedishSalePriceInEUR,
b.MarginSE,
b.ActiveSE

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Szwecja` as b on a.productNo_key = b.productNo_key;

---part16

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
a.GrossSalesPriceHU,
a.GrossHungarianSalePriceInEUR,
a.NetHungarianSalePriceInEUR,
a.MarginHU,
a.ActiveHU,
a.GrossSalesPriceFR,
a.GrossFrenchSalePriceInEUR,
a.NetFrenchSalePriceInEUR,
a.MarginFR,
a.ActiveFR,
a.GrossSalesPriceAUT,
a.GrossAustrianSalePriceInEUR,
a.NetAustrianSalePriceInEUR,
a.MarginAUT,
a.ActiveAUT,
a.GrossSalesPriceCH,
a.GrossSwissSalePriceInEUR,
a.NetSwissSalePriceInEUR,
a.MarginCH,
a.ActiveCH,
a.GrossSalesPriceNL,
a.GrossDutchalePriceInEUR,
a.NetDutchSalePriceInEUR,
a.MarginNL,
a.ActiveNL,
a.GrossSalesPriceBE,
a.GrossBelgianPriceInEUR,
a.NetBelgianSalePriceInEUR,
a.MarginBE,
a.ActiveBE,
a.GrossSalesPriceUK,
a.GrossUKPriceInEUR,
a.NetUKSalePriceInEUR,
a.MarginUK,
a.ActiveUK,
a.GrossSalesPriceIT,
a.GrossItalianPriceInEUR,
a.NetItalianSalePriceInEUR,
a.MarginIT,
a.ActiveIT,
a.GrossSalesPriceSE,
a.GrossSwedishPriceInEUR,
a.NetSwedishSalePriceInEUR,
a.MarginSE,
a.ActiveSE,
b.GrossSalesPriceDK,
b.GrossDanishhPriceInEUR,
b.NetDanishSalePriceInEUR,
b.MarginDK,
b.ActiveDK

FROM `ceeregion-prod.DimEastProductsAvalaibility.GlobalExistance` as a 
LEFT JOIN `ceeregion-prod.DimEastProductsAvalaibility.Dania` as b on a.productNo_key = b.productNo_key;

