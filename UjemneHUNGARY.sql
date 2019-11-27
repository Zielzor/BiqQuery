SELECT 
b.productNo AS Product_ID, 
a.productDesc as Nazwa,
b.brandManufactorer as Brand,
b.nameManufacturer,
b.purGrp, 
b.matClass_key AS MATKL, 
a.salesPrice as VkHUF_brutto,
ROUND(a.salesPrice / 1.27) as VkHUF_netto,
a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.27) as Nyereseg_Brutto,
(ROUND((b.purPriceAverage / k.rate))) / a.priceUnit   AS Vasarlas_HUF_netto,
((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.27 as Vasarlas_HUF_brutto,
a.priceUnit as Szam,
a.purOrderQtyRoundingValue,
(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.27)) / a.salesPrice  as Marza,
a.purPriceAverage AS Vasarlas_EUR,
b.statusArticleSite,
b.statusCrossSite,
b.statusCrossDistrChain,
b.statusDistriChainSpecific,
k.rate AS Exgachange_Rate 


FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` h, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` i, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` k, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` l 

WHERE a.productNo_key = b.productNo_key 
AND h.date = '2019-10-28' #data 
AND k.date_key = h.date_key 
AND i.curr_key='HUF' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key=l.version_key
AND a.salesOrg_key = '5950'
AND a.statusWebshop ='C'
AND b.purPriceAverage != 0
AND a.salesPrice != 0
AND a.priceUnit != 0
AND b.brandManufactorer != 'No Name (foreign brand)'
AND(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.27)) / a.salesPrice < 0.10

ORDER BY productNo