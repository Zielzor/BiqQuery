-- define interest sales Org
CREATE OR REPLACE TABLE `ceeregion-prod.GlobalPricefileEast.aa_pricefile1` AS
SELECT salesOrg_key,
salesOrgDescEng
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimSalesOrg.DimSalesOrg`
WHERE salesOrg_key IN UNNEST(['5800','5850','5900','5910','5950']);  -- 5900 Slovenia, 5810 Slovakia, 5950 Hungary-

-- main article information
CREATE OR REPLACE TABLE `ceeregion-prod.GlobalPricefileEast.aa_pricefile2` AS
SELECT productNo_key,

productDescEng
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct`
WHERE productNo<>0 -- only valid numbers (e.g. exclude productNo_key='02-166_4P1_4P0')
AND purPriceAverage > 0;

CREATE OR REPLACE TABLE `ceeregion-prod.GlobalPricefileEast.aa_pricefile3` AS
SELECT a.salesOrg_key,
b.productNo_key,

'X' productExist
FROM `ceeregion-prod.GlobalPricefileEast.aa_pricefile1` a, -- list of salesOrg_keys
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` b -- article list sales Org
WHERE a.salesOrg_key=b.salesOrg_key
and b.salesPrice > 0;

CREATE OR REPLACE TABLE `ceeregion-prod.GlobalPricefileEast.aa_pricefile2` AS
SELECT productNo_key,
productDescEng
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct`
WHERE productNo<>0 -- only valid numbers (e.g. exclude productNo_key='02-166_4P1_4P0')
AND itemTypeGrp != "NLAG"
AND purPriceAverage > 0;

CREATE OR REPLACE TABLE `ceeregion-prod.GlobalPricefileEast.aa_pricefileGlobal` AS
SELECT a.salesOrg_key,
CASE
WHEN a.salesOrg_key = "5800" THEN "CE Slovakia"
WHEN a.salesOrg_key = "5850" THEN "CE Czech"
WHEN a.salesOrg_key = "5900" THEN "CE Slowenien(SLO)"
WHEN a.salesOrg_key = "5910" THEN "CE Slowenien (HR)"
WHEN a.salesOrg_key = "5950" THEN "CE Hungary"
END AS Country,
b.productNo_key,
b.brandManufactorer,
b.statusCrossSite,
b.statusCrossDistrChain,
b.statusDistriChainSpecific,
b.itemTypeGrp as MTPOS

FROM `ceeregion-prod.GlobalPricefileEast.aa_pricefile3` a, -- list of salesOrg_keys
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b -- article list sales Org
WHERE a.productNo_key=b.productNo_key
AND b.productDescEng not like "-"
AND b.productDescEng not like "+"
AND b.itemTypeGrp != "NLAG"
and b.salesPrice > 0;


DROP TABLE `ceeregion-prod.GlobalPricefileEast.aa_pricefile1`;
DROP TABLE `ceeregion-prod.GlobalPricefileEast.aa_pricefile2`;
DROP TABLE `ceeregion-prod.GlobalPricefileEast.aa_pricefile3`;

