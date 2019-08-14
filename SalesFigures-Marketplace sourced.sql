SELECT
   date_key
  ,orderNo
  ,period
  ,fiscalYear
  ,insert_key
  ,a.timestamp
  ,invoiceDate
  ,sum(nnt) as nnt
  ,sum(cm1) as cm1 
  ,sum(movingAvgPrice) as GLD
  ,sum(movingAverageCOGS) as COGS
  ,sum(shippingCostsNnt) as ShipCostNNT
  ,orderType_key

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as a, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimAdvertisingMaterial.DimAdvertisingMaterial` as b,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as c  



WHERE a.PARTITIONDATE >= "2019-01-01" --zakres analizy 

-- relacja do proficenter
and a.globalPc_key=c.globalPc_key
and c.salesOrg_key='5810'

-- warunki
and b.salesOrg_key='5810'
and a.date_key>=20190301 -- startowa data raportu,trzeba fragmentowac po tym
and a.period = 3 --okres zamówienia kolejno miesiące można tym manipulowac żeby ograniczyć się do miesięcy
and a.orderType_key = 'ARGO'
and (b.insert_key = '95' or b.insert_key = '00')


group by insert_key, date_key, period, fiscalYear,orderType_key,orderNo,a.timestamp ,invoiceDate,dateAdded
order by insert_key, date_key, period, fiscalYear,orderType_key,orderNo,a.timestamp ,invoiceDate,dateAdded