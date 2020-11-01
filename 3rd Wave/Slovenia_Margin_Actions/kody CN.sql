CREATE OR REPLACE TABLE `ceeregion-prod.PriceFile.CN_Codes`  as
SELECT 
productNo,
CONCAT(substr(importCodeNumber, 0 ,4), " ",substr(importCodeNumber, 4 ,2), " " ,substr(importCodeNumber, 6 ,2)) as CnCode
FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` 
-- $WHERE productNo = 1929881
WHERE flagActive = "1"
AND importCodeNumber is not null;
