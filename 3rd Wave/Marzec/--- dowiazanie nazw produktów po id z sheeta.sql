CREATE OR REPLACE TABLE `ceeregion-prod.AA_Product_NAMES.Product_list_step1` as 
SELECT
a.ID,
b.productNo,
b.productNo_key, 
b.brandManufactorer
FROM `ceeregion-prod.AA_Product_NAMES.Product_list` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as b on a.ID = b.productNo;
-----------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_Product_NAMES.Product_list_step2` as 
SELECT
a.productNo,
b.productDesc as ArticleName,
a.brandManufactorer as Brand
FROM `ceeregion-prod.AA_Product_NAMES.Product_list_step1` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as b on a.productNo_key = b.productNo_key
WHERE b.salesOrg_key  = "5810"