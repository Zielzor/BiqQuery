CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_CEPL_done` as 
SELECT 
a.Order_number,
a.Sales_Organization,
b.productNo_key

FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_CEPL` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as b on  cast(a.Order_number as STRING) = b.orderNo

WHERE PARTITIONDATE >= "2019-12-29"
AND b.date_key>=20191229;
---------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_CEPL_done` as 
SELECT
a.Order_number,
a.Sales_Organization,
a.productNo_key,
matClass_key,
matClassDescEng,
ordinate_key,
ordinateDescEng,
category_key,
categoryDescEng

FROM`ceeregion-prod.AA_OpenOrders.OpenOrders_CEPL_done` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as b on a.productNo_key = b.productNo_key
WHERE flagActive  != 0
AND  a.productNo_key != "$$$$$$";
------------------------------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_CEPL_done2` as 
SELECT DISTINCT
a.Order_number,
a.Sales_Organization,
a.productNo_key,
productDescEng ,
a.matClass_key,
matClassDescEng,
ordinate_key,
ordinateDescEng,
category_key,
categoryDescEng
FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_CEPL_done`as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as b ON a.productNo_key = b.productNo_key

