CREATE OR REPLACE TABLE  `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional1` AS 
SELECT
a.date_key,
a.fiscalYear,
a.period,
b.salesOrg_key,
CASE 
WHEN  b.salesOrg_key = "5800" THEN "CE Slovakia"
WHEN  b.salesOrg_key = "5810" THEN "CE Poland"
WHEN  b.salesOrg_key = "5850" THEN "CE Czech"
WHEN  b.salesOrg_key = "5900" THEN "CE Slowenien(SLO)"
WHEN  b.salesOrg_key = "5910" THEN "CE Slowenien (HR)"
WHEN  b.salesOrg_key = "5950" THEN "CE Hungary"
END as  Country,
b.profitcenterCe_key as ProfitCenter,
CASE
WHEN b.profitcenterCe_key = 51230 THEN "B2C"
WHEN b.profitcenterCe_key = 51232 THEN "B2B"
END as B2B_B2C,
a.orderType_key as POType,
a.quantitySales as ABSMGSalesQuantity,
a.billingKind_key,
round(sum(a.nnt)) as nnt,
round(sum(a.cm1)) as cm1,
a.returns


FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` a,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` b,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` c

WHERE PARTITIONDATE >= "2019-12-29" #Wystarczy zmienić miesiąc aby dostać nowy raport
AND a.globalpc_key=b.globalpc_key
AND b.salesOrg_key in ('5800','5810','5850','5900','5910','5950') #sorgi
AND a.version_key='ISJA20060201' #Filtr
AND a.date_key>=20191229
AND a.productNo_key = c.productNo_key# w razie w
AND a.productNo_key = c.productNo_key# w razie w

GROUP BY a.invoiceNo_key,a.orderNo_key,a.OrderNo,a.orderType_key,a.quantitySales,a.invoiceNo,a.salesOrderPos, 
a.vv002,a.discount,a.vv005,a.customerDiscount,a.reduction,a.vv003,a.vv017,a.calcCashDiscount,
a.userName,a.conditionstotal,a.nnt,a.cm1,a.fiscalYear,a.period,a.productNo_key,b.profitcenterCe_key,
c.privateLabelManufactorer,c.brandManufactorer,c.matClass_key,a.date_key,a.globalPc_key,a.version_key,
a.pGlobalAdvertisingMaterial_key,a.termsOfPayment,a.billingKind_key,b.salesOrg_key,a.returns

ORDER BY a.date_key DESC; 

--- Dowiązanie Dim Calender
CREATE OR REPLACE TABLE `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional2` as 
SELECT 
b.date,
b.yearNo,
b.monthNum,
b.dayOfMonth,
b.calendarWeek,
a.*

FROM `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional1` as  a ,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b
WHERE a.date_key = b.date_key;

--- selekcja i agregacja 
CREATE OR REPLACE TABLE `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional_EAST` as  
SELECT 
a.date,
a.monthNum,
a.dayOfMonth,
a.B2B_B2C,
a.Country,
SUM(a.ABSMGSalesQuantity) as SUM_ABSMG,
round(sum(a.nnt)) as NNT_EURO,
round(sum(a.cm1)) as CM1_EURO,
count(case a.billingKind_key when 'RE' then 1 else null end) as Count_of_Returns,
sum(case a.billingKind_key when 'RE' then a.returns else 0 end) as Sum_of_Returns


FROM `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional2` as a 


GROUP BY a.date,a.monthNum,a.dayOfMonth,a.B2B_B2C,a.Country

ORDER BY a.date DESC

-- przykład warunkowej agregacji
#SELECT 
#fiscalYear,
#period, 
#count(case billingKind_key when 'RE' then 1 else null end) as test
#FROM `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional1` where returns  < 0
#group by fiscalYear,period---




