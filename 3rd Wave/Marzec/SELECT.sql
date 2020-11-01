SELECT 
a.dateCreation DESC,
a.invoiceNo_key,
a.orderNo_key,
a.OrderNo,
a.orderType_key as POType,
a.quantitySales as ABSMGSalesQuantity,
a.invoiceNo as InvoiceNo,
a.salesOrderPos as PosNo,
a.vv002 as CatalogPriceNetEUR0,
(a.discount * -1) as PriceReductionEURO,
(a.vv005 * -1) as StaggeredDiscount,
(a.customerDiscount * -1) as CustomerDiscountEURO,
(a.reduction * -1) as _Reduction,
(a.vv003 * -1) as CustomerFullDiscount,
(a.vv017 * -1) as Increments,
a.calcCashDiscount as CalcDiscountEURO,
a.userName as UserName,
(a.conditionstotal * -1) as Conditions,
(a.nnt - a.cm1) as Costs,
a.fiscalYear,
a.period,
round(sum(a.nnt)) as nnt,
round(sum(a.cm1)) as cm1,
round(sum(a.movingAvgPrice)) as GLD,
a.productNo_key,
round(sum(a.movingAverageCOGS)) as COGS,
b.profitcenterCe_key as ProfitCenter,
c.privateLabelManufactorer as Conrad_External,
c.brandManufactorer as Brand,
c.matClass_key as MATKL

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` a,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` b,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` c,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` d 

WHERE PARTITIONDATE >= "2019-12-29" #Wystarczy zmienić miesiąc aby dostać nowy raport
AND a.globalpc_key=b.globalpc_key
AND b.salesOrg_key='5900'
AND a.version_key='ISJA20060201' #Filtr
AND a.date_key>=20191229
---------DimProduct
AND a.productNo_key = c.productNo_key
---------DimProductHierarchy
AND a.productNo_key = d.productNo_key
AND c.productNo_key = d.productNo_key


GROUP BY a.dateCreation DESC,a.invoiceNo_key,a.orderNo_key,a.OrderNo,a.orderType_key,a.quantitySales,a.invoiceNo,a.salesOrderPos, a.vv002,a.discount,a.vv005,a.customerDiscount,a.reduction,a.vv003,a.vv017,a.calcCashDiscount,a.userName,a.conditionstotal,a.nnt,a.cm1,a.fiscalYear,a.period,a.productNo_key,profitcenterCe_key,c.privateLabelManufactorer,c.brandManufactorer,c.matClass_key
