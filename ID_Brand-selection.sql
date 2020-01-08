SELECT 
b.productNo AS Product_ID, 
a.productDesc as Name,
b.brandManufactorer as Brand,
b.nameManufacturer,
b.purGrp, 
b.matClass_key AS MATKL, 
a.salesPrice as Selling_price_brutto,
(a.salesPrice / 1.21) as Selling_price_netto,
a.salesPrice - (((((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.21) as Profit_Brutto,
(((b.purPriceAverage / k.rate))) / a.priceUnit   AS Purchasing_price_netto,
((((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.21 as Purchasing_price_brutto,
a.priceUnit as Quantity,
a.purOrderQtyRoundingValue,
(a.salesPrice - (((((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.21)) / a.salesPrice  as Margin,
a.purPriceAverage AS Purchasing_price_EUR,
b.statusArticleSite,
b.statusCrossSite,
b.statusCrossDistrChain,
b.statusDistriChainSpecific,
k.rate AS Exchange_rate

FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` h, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` i, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` k, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` l 

WHERE a.productNo_key = b.productNo_key 
AND h.date = '2020-01-08' #data 
AND k.date_key = h.date_key 
AND i.curr_key='CZK' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key=l.version_key
AND a.salesOrg_key = '5850'
AND a.statusWebshop is null #- dla pepeów przyjmuje wartość null 
AND b.purPriceAverage != 0
AND a.salesPrice != 0
AND b.articleType  != 'NLAG'
#AND(a.salesPrice - (((((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.21)) / a.salesPrice < 0.20


GROUP BY productNo,
b.brandManufactorer,
a.productDesc,
b.nameManufacturer,
b.purGrp,
b.matClass_key,
a.salesPrice,
b.purPriceAverage,
k.rate,
a.priceUnit,
a.purOrderQtyRoundingValue,
a.purPriceAverage,
b.statusArticleSite,
b.statusCrossSite,
b.statusCrossDistrChain,
b.statusDistriChainSpecific

HAVING 
b.brandManufactorer = "FESTO"

ORDER BY productNo,b.brandManufactorer
