SELECT
b.productNo AS Product_ID, 
a.productDesc as Nazwa,
a.salesPrice as VkPL_brutto,
ROUND(a.salesPrice / 1.23) as VkPL_netto,
a.purPriceAverage, 
b.matClass_key,
c.globalProductHierarchy_key,
c.productNo_key,
c.matClassDescEng,
c.ordinateDescEng,
c.maingrpDescEng,
c.categoryDescEng,
c.category_key


FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` h, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` i, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` k, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` l ,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as c 


WHERE a.productNo_key = b.productNo_key 
AND h.date = '2019-12-05' #data 
AND k.date_key = h.date_key 
AND i.curr_key='PLN' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key=l.version_key
AND a.salesOrg_key = '5810'
AND a.statusWebshop ='C'
AND b.purPriceAverage < 15
AND a.salesPrice > 0
AND c.flagActive = 1
AND b.productNo_key  = c.productNo_key 
AND c.category_key = '3'

ORDER by purPriceAverage 	DESC