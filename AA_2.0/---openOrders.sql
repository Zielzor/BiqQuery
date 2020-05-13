CREATE OR REPLACE TABLE `ceeregion-prod.Inne.OpenOperders2`as
SELECT 
ProductID,
productDescEng,
brandManufactorer,
b.productNo,
b.productNo_key

FROM `ceeregion-prod.Inne.OpenOperders` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as b on a.ProductID = b.productNo;
-----------------
CREATE OR REPLACE TABLE `ceeregion-prod.Inne.OpenOperders3` as
SELECT   
ProductID,
productDescEng,
brandManufactorer,
b.maingrpDescEng as Kategoria,
b.categoryDescEng as HeadGroup
FROM `ceeregion-prod.Inne.OpenOperders2` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as b  on a.productNo_key = b.productNo_key

where b.flagActive = 1