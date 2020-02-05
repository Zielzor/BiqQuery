SELECT 
c.date,
b.salesOrg_key as SORG,
b.profitcenterCe_key as ProfiCenter, 
a.fiscalYear,
a.period,
c.quarter,
round(sum(nnt)) as nnt,
round(sum(cm1)) as cm1

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as  a,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as  b,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as c

WHERE PARTITIONDATE >= "2019-01-01" #Wystarczy zmienić miesiąc aby dostać nowy raport

and a.globalpc_key=b.globalpc_key
and b.salesOrg_key in ("5810", "5800", "5850", "5900", "5910", "5950" )
and a.version_key='ISJA20060201' #Filtr
and a.date_key  = c.date_key
and a.date_key>=20190101
and a.orderNo = "9999999998"

group by 
c.date,
a.fiscalYear,
a.period,
a.nnt,
a.cm1,
b.salesOrg_key,
b.profitcenterCe_key,
c.quarter,

order by 
c.date,
a.fiscalYear,
a.period,
a.nnt,
a.cm1,
b.salesOrg_key,
b.profitcenterCe_key,
c.quarter,