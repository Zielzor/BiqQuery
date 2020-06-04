CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_Step1` as 
SELECT DISTINCT 
a.orderNo_key,
a.dateModification_key, 
a.dateDisposition_key,    
a.rejectionReason_key,  
a.recordType,
a.numDisposition,
a.statusOverallItemDelivery,
a.statusRejection,
a.statusItemGeneralIncompletion,
a.statusItemDeliveryIncompletion,
a.dateFirstDisposition,
a.salesUnit,
a.productNo_key,
a.salesOrderItemShortDesc,
a.matClass_key

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactOrderPos.FactOrderPos` as a
FULL JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as b on a.globalPc_key = b.globalPc_key

WHERE a.PARTITIONDATE >= "2020-01-01"
AND rejectionReason_key = "$$"
#AND orderNo_key in ("1080071657","1988630000","1079724896","1988800190","1079829343","1079755146","1079970733")
AND a.flagActive = '1'
AND b.salesOrg_key = "5810"
AND orderNo_key not like  "6%"
AND CAST(dateModification_key as STRING) not like "9%"
AND statusOverallItemDelivery is not null 
ORDER BY a.orderNo_key  DESC
-------