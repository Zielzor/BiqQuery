SELECT 
b.productNo AS Product_ID, 
a.productDesc as Nazwa,
b.brandManufactorer as Brand,
b. nameManufacturer,
b.purGrp, 
b.matClass_key AS MATKL, 
a.salesPrice as VkCZK_brutto,
ROUND(a.salesPrice / 1.21) as VkCZK_netto,
a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.21) as Zysk_Brutto,
(ROUND((b.purPriceAverage / k.rate))) / a.priceUnit   AS Zakup_CZK_netto,
((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.21 as Zakup_CZK_brutto,
a.priceUnit as Cislo,
a.purOrderQtyRoundingValue,
(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.21)) / a.salesPrice  as Marza,
a.purPriceAverage AS Zakup_EUR,
b.statusArticleSite,
b.statusCrossSite,
b.statusCrossDistrChain,
b.statusDistriChainSpecific,
k.rate AS KURS_wymiany

FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as  a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct`as  b, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as h, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` as i, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate`as  k, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` as l, 
`ceeregion-prod.GenItemCatGroup_NLAG.GenItemCatGroup_GLOBAL` as m 

WHERE a.productNo_key = b.productNo_key 
AND b.productNo = m.productNo
AND m.NLAG_Status != "NLAG"
AND h.date = '2019-10-23' #data 
AND k.date_key = h.date_key 
AND i.curr_key='CZK' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key=l.version_key
AND a.salesOrg_key = '5850'
AND a.statusWebshop is null #- dla pepeów przyjmuje wartość null 
AND b.purPriceAverage != 0
AND a.salesPrice != 0
AND(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.21)) / a.salesPrice < 0.10

ORDER BY productNo