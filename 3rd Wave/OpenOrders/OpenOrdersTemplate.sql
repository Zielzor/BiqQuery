CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_Step1` as 
SELECT DISTINCT 
a.customerNo_key,
a.orderNo_key,
a.dateModification_key, 
a.dateDisposition_key,    
a.rejectionReason_key,  
a.recordType,
a.numDisposition,
a.statusOverallItemDelivery,
CASE 
WHEN a.statusOverallItemDelivery = "A"  THEN "Rejection"
WHEN a.statusOverallItemDelivery = "B"  THEN "Free Returns"
WHEN a.statusOverallItemDelivery = "C"  THEN "In additional delivery"
ELSE "Brak statusu - sprwadzić w DimDeliveryStatus"
END AS Descritpion_1,
a.statusRejection,
CASE 
WHEN a.statusRejection = "A"  THEN "Rejection"
WHEN a.statusRejection = "B"  THEN "Free Returns"
WHEN a.statusRejection = "C"  THEN "In additional delivery"
ELSE "Brak statusu - sprwadzić w DimDeliveryStatus"
END AS Descritpion_2,
a.statusItemGeneralIncompletion,
CASE 
WHEN a.statusItemGeneralIncompletion = "A"  THEN "Rejection"
WHEN a.statusItemGeneralIncompletion = "B"  THEN "Free Returns"
WHEN a.statusItemGeneralIncompletion = "C"  THEN "In additional delivery"
ELSE "Brak statusu - sprwadzić w DimDeliveryStatus"
END AS Descritpion_3,
a.statusItemDeliveryIncompletion,
CASE 
WHEN a.statusItemDeliveryIncompletion = "A"  THEN "Rejection"
WHEN a.statusItemDeliveryIncompletion = "B"  THEN "Free Returns"
WHEN a.statusItemDeliveryIncompletion = "C"  THEN "In additional delivery"
ELSE "Brak statusu - sprwadzić w DimDeliveryStatus"
END AS Descritpion_4,
a.statusSalesDocItemOverallProc,
a.qtyOpen, 
a.dateFirstDisposition,
c.period,
a.salesUnit,
a.productNo_key,
a.salesOrderItemShortDesc,
a.matClass_key,
a.orderQty,
a.priceNet,
a.valueNet,
a.valueSettlement,
a.valueSalesGross,
a.valueSalesGrossInLocalCurrency



FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactOrderPos.FactOrderPos` as a
FULL JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as b on a.globalPc_key = b.globalPc_key
FULL JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as c on a.date_key = c.date_key

WHERE a.PARTITIONDATE >= "2020-01-01"
AND rejectionReason_key = "$$"
#AND orderNo_key in ("1080071657","1988630000","1079724896","1988800190","1079829343","1079755146","1079970733")
AND a.flagActive = '1'
AND b.salesOrg_key = "5810"
AND orderNo_key not like  "6%"
AND CAST(dateModification_key as STRING) not like "9%"
AND statusOverallItemDelivery is not null 
ORDER BY a.orderNo_key  DESC;

--------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_Step1` as 
SELECT
a.*,
b.salesDistrict 

FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_Step1` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as b on a.customerNo_key = b.customerNo_key;
-------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_Step1` as 
SELECT
a.*,
b.period as Real_period

FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_Step1` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b on a.dateDisposition_key = b.date_key;

-----------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_Step1` as 
SELECT
a.*,
b.maingrpDescEng as Head_Group,
b.categoryDescEng as Categorie,
b.category_key as category_key, 
FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_Step1` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as b on a.productNo_key = b.productNo_key
AND b.flagActive  != 0


