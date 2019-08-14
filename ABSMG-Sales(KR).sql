SELECT
a.date_key,
c.productNo,
a. quantitySales,
c.efeuNo,
round(sum(a.nnt)) as nnt,
a.cm1


FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg`as b,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as c,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.ViewDimVersion` as d,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as e -- profitcenter global

WHERE a.PARTITIONDATE >= "2019-05-01"  -- date range for analysis

and  DATE(e._PARTITIONTIME) >= "2019-05-01" -- no profitcenter defined earlier

-- relation to profitcenter
and a.globalPc_key=e.globalPc_key
and e.salesOrg_key='5810'

-- relation to Product datas of sales organisation
and a.productNo_key = b.productNo_key
and b.productNo_key = c.productNo_key
and b.salesOrg_key= e.salesOrg_key

-- relation to version
and a.version_key=d.version_key
and d.budgetart_key='IS' -- type of version is "IS"


group by a.date_key, c.productNo, c.efeuNo, quantitySales, cm1
order by productNo, date_key
