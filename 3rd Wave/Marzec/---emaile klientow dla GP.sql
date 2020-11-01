CREATE OR REPLACE TABLE `ceeregion-prod.AA_Faktury_GP.customerNo` as
SELECT 
a.*,
customerNo_key

FROM `ceeregion-prod.AA_Faktury_GP.InvoiceNo` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as b on cast(a.InoviceNo as STRING) = b.invoiceNo

WHERE b.partitionDate BETWEEN  "2019-12-29"  and CURRENT_DATE()
AND b.date_key > 20200101;
----------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_Faktury_GP.customerEmails` as 
SELECT  
a.customerNo_key,
CASE
WHEN b.profitCenter = "51230" THEN "B2C"
WHEN b.profitCenter = "51232" THEN "B2B"
END as B2B_B2C,
b.profitCenter,
eMailAddress
FROM `ceeregion-prod.AA_Faktury_GP.customerNo`  as a
      LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as b on a.customerNo_key  = b.customerNo_key

ORDER BY CustomerNo DESC
