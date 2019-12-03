SELECT 
customerNo_key
  ,invoiceNo_key
  ,orderNo_key
  ,productNo
  ,fiscalYear
  ,period
  ,insert_key
  ,insertDescEng
  ,shippingCondition_key
  ,termsOfPayment
  ,discount
  ,supplierDiscount
  ,userName
  ,catalogPriceNet
  ,incotermOrder
  ,incotermCustomer
  ,sum(nnt) as nnt
  ,sum(cm1) as cm1
  ,sum(quantitySales) as Ilosc
  ,sum(movingAvgPrice) as GLD
  ,sum(movingAverageCOGS) as COGS
  ,sum(shippingCostsNnt) as ShipCostNNT
  ,sum(processLogisticsCosts) as processLogisticsCost
  ,sum(processCostsTotal) as processCostTot

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales`as  a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg`as b,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as c,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.ViewDimVersion` as d,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as e, -- profitcenter global
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimAdvertisingMaterial.DimAdvertisingMaterial` as f

WHERE a.PARTITIONDATE >= "2019-09-01"  -- date range for analysis
and  DATE(e._PARTITIONTIME) >= "2019-01-01" -- no profitcenter defined earlier
-- relation to profitcenter
and a.globalPc_key=e.globalPc_key
and e.salesOrg_key='5810'
and f.salesOrg_key='5810'
and a. pGlobalAdvertisingMaterial_key =f.GlobalAdvertisingMaterial_key
-- relation to Product datas of sales organisation
and a.productNo_key = b.productNo_key
and b.productNo_key = c.productNo_key 
and b.salesOrg_key= e.salesOrg_key
-- relation to version
and a.version_key=d.version_key
and d.budgetart_key='IS' -- type of version is "IS"

group by customerNo_key, invoiceNo_key, orderNo_key, fiscalYear, period, productNo, insert_key,  shippingCondition_key,termsOfPayment, discount, supplierDiscount, catalogPriceNet, quantitySales,  orderType_key, orderNo,insertDescEng,userName,incotermOrder,incotermCustomer
order by customerNo_key, invoiceNo_key, fiscalYear, period, productNo, insert_key,  shippingCondition_key,termsOfPayment,   discount, supplierDiscount, catalogPriceNet, quantitySales,COGS, ShipCostNNT, processLogisticsCost, processCostTot,orderType_key, orderNo