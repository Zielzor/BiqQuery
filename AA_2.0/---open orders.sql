SELECT
a.Order_number,
a.Sales_Organization,
b.productNo_key

FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_CEPL` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as b on  cast(a.Order_number as STRING) = b.orderNo

WHERE PARTITIONDATE >= "2019-12-29"
AND b.date_key>=20191229
----------------------------------
SELECT 
ProductID,
b.maingrpDescEng as Kategoria,
b.categoryDescEng as HeadGroup
FROM `ceeregion-prod.Inne.OpenOperders2` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as b  on a.productNo_key = b.productNo_key

where b.flagActive = 1