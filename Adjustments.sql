SELECT a.*
 
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.ViewDimVersion` as d,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as e

WHERE partitionDate BETWEEN  "2019-12-01"  and CURRENT_DATE()
and a.globalPc_key=e.globalPc_key
and e.salesOrg_key='5810'

-- relation to Product datas of sales organisation
#and a.productNo_key = b.productNo_key
#and b.productNo_key = c.productNo_key

-- relation to version
and a.version_key=d.version_key
#and d.budgetart_key='IS' -- type of version is "IS"


and orderNo = "9999999998"
