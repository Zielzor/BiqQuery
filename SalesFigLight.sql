SELECT customerNo_key
  ,invoiceNo_key
  ,orderNo_key
  ,fiscalYear
  ,period
  ,round(sum(nnt)) as nnt
  ,round(sum(cm1)) as cm1
  ,round(sum(movingAvgPrice)) as GLD
  ,productNo_key
  ,round(sum(movingAverageCOGS)) as COGS
  ,round(sum(shippingCostsNnt)) as ShipCostNNT
  ,round(sum(processLogisticsCosts)) as processLogisticsCost
  ,round(sum(processCostsTotal)) as processCostTot
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` a,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` b
WHERE PARTITIONDATE >= "2019-07-01" #Wystarczy zmienić miesiąc aby dostać nowy raport
and a.globalpc_key=b.globalpc_key
and b.salesOrg_key='5810'
and a.version_key='ISJA20060201' #Filtr
and a.date_key>=20190701
group by customerNo_key, invoiceNo_key, orderNo_key,productNo_key, movingAverageCOGS, shippingCostsNnt, processLogisticsCosts,processCostsTotal, fiscalYear, period 
order by customerNo_key, orderNo_key, invoiceNo_key,productNo_key, movingAverageCOGS, shippingCostsNnt, processLogisticsCosts,processCostsTotal, fiscalYear, period