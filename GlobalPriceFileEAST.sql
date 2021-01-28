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