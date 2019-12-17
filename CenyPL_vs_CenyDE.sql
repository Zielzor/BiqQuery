SELECT 
b.productNo AS Product_ID, 
a.productDesc as Nazwa,
b.brandManufactorer as Brand,
b.nameManufacturer,
b.purGrp, 
b.matClass_key AS MATKL, 
a.salesPrice as Vk_brutto,
((((a.salesPrice / b.unitSalesPrice))/1.19) / 1.23) * 4.35 as VK_DE_NETTO_PLN_NCPPIPNNIPPK,
b.unitSalesPrice as Ilosc, 
m.VkPL_brutto,
m.VkPL_brutto / 1.23 as VkPL_Netto,
(((((a.salesPrice / b.unitSalesPrice))/1.19) / 1.23) * 4.35) - (m.VkPL_brutto / 1.23) as Roznica_VK,
((((((a.salesPrice / b.unitSalesPrice))/1.19) / 1.23) * 4.35) - (m.VkPL_brutto / 1.23)) / (((((a.salesPrice / b.unitSalesPrice))/1.19) / 1.23) * 4.35) as Roznica_Procentowa,
b.statusCrossDistrChain,
b.statusDistriChainSpecific,



FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` h, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` i, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` k, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` l,
`ceeregion-prod.Ujemne.Ujemne2019_12_16` m #zmieniać date raze z generowanynymi pełnymi ujemnymi, tam sa nasze aktualne ceny frontowe

WHERE a.productNo_key = b.productNo_key 
AND h.date = '2019-12-17' #data 
AND k.date_key = h.date_key 
AND i.curr_key='EUR' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key=l.version_key
AND a.salesOrg_key = '1000'
AND a.statusWebshop ='C'
AND b.purPriceAverage > 0
AND a.salesPrice > 0
AND b.productNo = m.Product_ID



GROUP BY productNo, 
a.productDesc, 
b.brandManufactorer, 
b.nameManufacturer, 
b.purGrp, 
b.matClass_key, 
a.salesPrice, 
b.purPriceAverage, 
k.rate, a.priceUnit, 
a.purOrderQtyRoundingValue, 
a.purPriceAverage,
b.statusArticleSite,
b.statusCrossSite, 
b.statusCrossDistrChain, 
b.statusDistriChainSpecific, 
b.articleType,
m.VkPL_brutto,
b.unitSalesPrice

HAVING b.articleType  != 'NLAG'

ORDER BY b.productNo