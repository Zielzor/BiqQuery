CREATE OR REPLACE TABLE  `ceeregion-prod.ProductsData.step1`  as 
SELECT DISTINCT
b.productNo_key,
b.productNo AS Product_ID, 
a.productDesc as Nazwa,
b.brandManufactorer as Brand,
m.ean as EAN,
b.nameManufacturer,
b.purGrp, 
b.matClass_key AS MATKL


FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` h, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` i, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` k, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` l
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimPricingCompProduct.DimPricingCompProduct` m on b.productNo_key = m.productNo_key

WHERE h.date BETWEEN "2019-01-01" AND   current_date() #data  
AND a.productNo_key = b.productNo_key 
AND k.date_key = h.date_key 
AND i.curr_key='PLN' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key= l.version_key
AND a.salesOrg_key = '5810'
AND a.statusWebshop ='C'
AND b.purPriceAverage > 0
AND a.salesPrice > 0;
------------------------
CREATE OR REPLACE TABLE  `ceeregion-prod.ProductsData.step2`  as 
SELECT 
a.*,
b.matClassDescEng,
b.ordinate_key,
b.ordinateDescEng,
b.maingrp_key,
b.maingrpDescEng,
b.category_key,
b.categoryDescEng


FROM `ceeregion-prod.ProductsData.step1` as a
LEFT JOIN  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as b on  a.productNo_key = b.productNo_key

WHERE b.flagActive  != 0;

--------polishing
CREATE OR REPLACE TABLE  `ceeregion-prod.ProductsData.ProductsData`  as 
SELECT
Product_ID,
Nazwa,
nameManufacturer,
Brand,
EAN,
MATKL, 
matClassDescEng,
ordinate_key, 
ordinateDescEng, 
maingrp_key, 
maingrpDescEng, 
category_key,
categoryDescEng
FROM `ceeregion-prod.ProductsData.step2` as a;

DROP TABLE `ceeregion-prod.ProductsData.step1`;
DROP TABLE `ceeregion-prod.ProductsData.step2`;

