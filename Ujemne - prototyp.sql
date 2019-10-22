--creation of artikle list in cobis_DWH
SELECT 
b.productNo AS Product_ID, 
a.productDesc, 
b.purGrp, 
b.matClass_key AS MATKL, 
b.productDescEng, 
a.salesPrice AS Sales_Price_PL, 
b.salesPrice AS Sales_Price_ID, 
a.purPriceAverage AS Zakup,
(b.purPriceAverage / k.rate) AS Zakup_PLN, 
#ROUND((a.verpr/k.kurs),2 ) AS ekpnn_ch, 
b.purPriceNetNet, 
a.purOrderQtyRoundingValue, 
a.priceUnit, 
b.unitAltMeasurementCarton, #cokolwike to kurwa jest, szwajcaria to ma trzeba będzie zrobić śledztwo 
b.statusCrossSite, 
b.statusCrossDistrChain, 
a.statusDistriChainSpecific, 
a.dateDistributionChainSpecifi, 
b.typeProcurement,
k.rate AS KURS 

FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` h, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` i, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` k, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` l 

WHERE a.productNo_key = b.productNo_key 
AND h.date = '2019-10-20' #data 
AND k.date_key = h.date_key 
AND i.curr_key='PLN' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key=l.version_key
AND a.salesOrg_key = '5810'
AND a.statusWebshop ='C'