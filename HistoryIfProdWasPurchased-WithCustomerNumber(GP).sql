SELECT
(distinct)customerNo_key
  ,invoiceNo_key
  ,orderNo_key
  ,productNo
  
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg`as b,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as c,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.ViewDimVersion` as d,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as e, -- profitcenter global
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimAdvertisingMaterial.DimAdvertisingMaterial` as f

WHERE a.PARTITIONDATE >= "2014-01-01"  -- date range for analysis

##and  DATE(e._PARTITIONTIME) >= "2019-08-01" -- no profitcenter defined earlier

-- relation to profitcenter
and a.globalPc_key=e.globalPc_key
and e.salesOrg_key='5810'
and f.salesOrg_key='5810'

-- relation to Product datas of sales organisation
and a.productNo_key = b.productNo_key
and b.productNo_key = c.productNo_key 
and b.salesOrg_key= e.salesOrg_key

-- relation to version
and a.version_key=d.version_key
and d.budgetart_key='IS' -- type of version is "IS"
--criteria of search
and productNo = 1597114 


group by customerNo_key, invoiceNo_key, orderNo_key, fiscalYear, period, productNo, insert_key, insertDescEng, shippingCondition_key,termsOfPayment, userName, quantitySales, discount, supplierDiscount, catalogPriceNet
order by customerNo_key, invoiceNo_key, orderNo_key, fiscalYear, period, productNo, insert_key, insertDescEng, shippingCondition_key,termsOfPayment, userName, quantitySales, discount, supplierDiscount, catalogPriceNet
