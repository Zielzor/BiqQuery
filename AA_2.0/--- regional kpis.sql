CREATE OR REPLACE TABLE  `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional1` as
SELECT
a.date_key,
a.fiscalYear,
a.period,
b.salesOrg_key,
d.salesDistrict,
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
ELSE "Nieprzypisane"

END as B2B_B2C,
a.orderType_key as POType,
a.quantitySales as ABSMGSalesQuantity,
a.billingKind_key,
round(sum(a.nnt)) as nnt,
round(sum(a.cm1)) as cm1,
a.returns


FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` a,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` b,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` c,
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` d

WHERE PARTITIONDATE >= "2018-12-29" #Wystarczy zmienić miesiąc aby dostać nowy raport
AND a.globalpc_key=b.globalpc_key
AND b.salesOrg_key in ('5800','5810','5850','5900','5910','5950') #sorgi
AND a.version_key='ISJA20060201' #Filtr
AND a.date_key>=20181229
AND a.productNo_key = c.productNo_key# w razie w
AND a.productNo_key = c.productNo_key# w razie w
and a.customerNo_key = d.customerNo_key

GROUP BY a.invoiceNo_key,a.orderNo_key,a.OrderNo,a.orderType_key,a.quantitySales,a.invoiceNo,a.salesOrderPos, 
a.vv002,a.discount,a.vv005,a.customerDiscount,a.reduction,a.vv003,a.vv017,a.calcCashDiscount,
a.userName,a.conditionstotal,a.nnt,a.cm1,a.fiscalYear,a.period,a.productNo_key,b.profitcenterCe_key,
c.privateLabelManufactorer,c.brandManufactorer,c.matClass_key,a.date_key,a.globalPc_key,a.version_key,
a.pGlobalAdvertisingMaterial_key,a.termsOfPayment,a.billingKind_key,b.salesOrg_key,a.returns,d.salesDistrict

ORDER BY a.date_key DESC;

------------------
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

---- dowiązanie dmc i pmc
CREATE OR REPLACE TABLE  `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional3` as
SELECT
a.*,
b.flagManaged,
CASE 
WHEN flagmanaged>0 then "PMC" else "DMC"
END as PMC_DMC,
FROM  `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional2` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomerDistrict.DimCustomerDistrict`as b on a.salesDistrict = b.district_key;

-- selekcja i agregacja 
CREATE OR REPLACE TABLE `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional_EAST` as  
SELECT
a.yearNo,
a.date,
a.monthNum,
a.dayOfMonth,
a.Country,
a.B2B_B2C,
a.PMC_DMC,
round(sum(a.nnt)) as NNT_EURO,
round(sum(a.cm1)) as CM1_EURO,
count(case a.billingKind_key when 'RE' then 1 else null end) as Count_of_Returns,
sum(case a.billingKind_key when 'RE' then a.returns else 0 end) as Sum_of_Returns

FROM `ceeregion-prod.AA_CEPL_RegionalEastRaport.regional3` as a 

GROUP BY a.date,a.monthNum,a.dayOfMonth,a.B2B_B2C,a.PMC_DMC,a.Country,a.yearNo

ORDER BY a.date,Country DESC;
