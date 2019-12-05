SELECT 
b.productNo AS Product_ID, 
a.productDesc as Nazwa,
b.brandManufactorer as Brand,
b.matClass_key AS MATKL, 
a.salesPrice as VkPL_brutto,
a.purPriceAverage AS Zakup_EUR,
((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.23 as Zakup_PLN_brutto,
a.priceUnit as Ilosc,
(((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.12) * 1.23 as CenaDlaNas,
(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.12) ) / a.salesPrice as Roznica_Procentowa,
k.rate AS KURS_wymiany, 
b.statusCrossSite, -- in COBIS_DWH D_ARTIKEL.mstae
b.statusCrossDistrChain, -- in COBIS_DWH D_ARTIKEL.mstav
b.statusDistriChainSpecific,
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
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` l,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as c  

WHERE a.productNo_key = b.productNo_key 
AND h.date = '2019-12-02' #data 
AND k.date_key = h.date_key 
AND i.curr_key='PLN' 
AND i.curr_key=k.curr_key 
AND l.budgetType_key='IS' 
AND k.version_key=l.version_key
AND a.salesOrg_key = '5810'
AND a.statusWebshop ='C'
AND b.purPriceAverage != 0
AND a.salesPrice != 0
AND(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.23)) / a.salesPrice >= 0.50
AND a.priceUnit = 1 
AND a.purPriceAverage != 0.01
AND matClass_key NOT LIKE '13-%'
AND matClass_key NOT LIKE '11-%'
AND b.productNo_key  = c.productNo_key

GROUP BY productNo,productDesc,matClass_key,a.salesPrice,b.purPriceAverage,a.purPriceAverage,k.rate,a.priceUnit ,b.statusCrossSite,b.statusCrossDistrChain,b.statusDistriChainSpecific,b.brandManufactorer

HAVING 
(a.salesPrice - (((ROUND((b.purPriceAverage / k.rate))) / a.priceUnit) * 1.23)) / a.salesPrice > 0.33
AND b.brandManufactorer != "OBO Bettermann"

ORDER BY b.brandManufactorer