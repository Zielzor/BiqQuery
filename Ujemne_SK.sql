SELECT 
b.productNo AS Product_ID, 
a.productDesc as Nazwa,
b.brandManufactorer as Brand,
b.nameManufacturer,
b.purGrp, 
b.matClass_key AS MATKL, 
a.salesPrice as VkSK_brutto,
ROUND(a.salesPrice / 1.20) as VkPL_netto,
a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.20) as Zysk_Brutto,
(ROUND((b.purPriceAverage / k.rate))) / a.priceUnit   AS Zakup_PLN_netto,
((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.20 as Zakup_PLN_brutto,
a.priceUnit as Ilosc,
a.purOrderQtyRoundingValue,
(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.20)) / a.salesPrice  as Marza,
a.purPriceAverage AS Zakup_EUR,
b.statusArticleSite,
b.statusCrossSite,
b.statusCrossDistrChain,
b.statusDistriChainSpecific,
k.rate AS KURS_wymiany 


FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` h, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` i, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` k, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` l 

WHERE a.productNo_key = b.productNo_key 
AND h.date = '2019-10-23' #data 
AND k.date_key = h.date_key 
AND i.curr_key='EUR' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key=l.version_key
AND a.salesOrg_key = '5800'
#AND a.statusWebshop ='C' prawdopodbnie null 
AND b.purPriceAverage != 0
AND a.salesPrice != 0
AND b.brandManufactorer != 'No Name (foreign brand)'
AND(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.20)) / a.salesPrice < 0.10

ORDER BY productNo