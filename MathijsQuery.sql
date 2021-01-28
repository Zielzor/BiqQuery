--DECLARE cDate DATE DEFAULT '2020-02-02';
DECLARE cDate DATE DEFAULT CURRENT_DATE(); 
DECLARE startDate DATE DEFAULT DATE_TRUNC(DATE_SUB(cdate,INTERVAL 25 month), year); -- begin vorig jaar(bij jaar overgang extra maand)
DECLARE endDate DATE DEFAULT cdate;-- inclusive this date;


--select cDate, startDate, endDate;

CREATE OR REPLACE TABLE `conradnl-mit-gcgen-prod.Testsets_Matthijs.SalesweekB2BNL` AS (
SELECT
  if(t6.flagManaged=1, 'Personally Managed','Digitally Managed') AS Account_type,
  t1.salesOrg as VKORG,
  t1.sellerGrp_key,
  t2.date_key,
  t3.productNo,
  t3.brandManufactorer,
  t8.string_field_1 as Campagnemerk,
  t4.maingrp_key,
  t4.maingrpDescEng,
  t4.matClass_key,
  t4.matClassDescEng,
  t7.orderTypeDescEng,
	t7.orderTypeGrpDescEng,
  t5.Campagne,
  t2.nnt as NNT,
  t2.cm1 as CM1,
  sum(case when (SUBSTR(cast(t2.date_key AS STRING),1,4))='2019' then round(t2.nnt,0) else 0 end) as NNU_2019,
  sum(case when (SUBSTR(cast(t2.date_key AS STRING),1,4))='2020' then round(t2.nnt,0) else 0 end) as NNU_2020,
  sum(case when (SUBSTR(cast(t2.date_key AS STRING),1,4))='2019' then round(t2.cm1,0) else 0 end) as DBI_2019,
  sum(case when (SUBSTR(cast(t2.date_key AS STRING),1,4))='2020' then round(t2.cm1,0) else 0 end) as DBI_2020,
  EXTRACT(year from t2.invoiceDate) as Jaar,
  format("%02d", EXTRACT(month from t2.invoiceDate)) as Maand,
  EXTRACT(quarter from t2.invoiceDate) as Kwartaal,
  format("%02d", EXTRACT(isoweek from t2.invoiceDate)) as Iso_Week,
  EXTRACT(isoyear from t2.invoiceDate) as Iso_Jaar,
  format("%02d", EXTRACT(dayofweek from DATE_SUB(t2.invoiceDate, interval 1 day)))||'-'||FORMAT_DATE("%A", t2.invoiceDate) as WeekDag,
  if(EXTRACT(dayofyear from t2.invoiceDate) >=0 and EXTRACT(dayofyear from t2.invoiceDate) < EXTRACT(dayofyear from endDate),1,0) as YTD_Indicator,
             
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` t1
INNER JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` t2 on t1.customerNo_key = t2.customerNo_key
INNER JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` t3 on t2.productNo_Key = t3.productNo_Key
INNER JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimMaterialClass.DimMaterialClass` t4 on t3.matClass_key = t4.matClass_key
LEFT JOIN `conradnl-mit-gcgen-prod.Testsets_Matthijs.Artikellijst_SalesweekNL` t5 on t3.productNo = t5.Artikelnummer
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomerDistrict.DimCustomerDistrict` t6 on t1.salesdistrict=t6.district_key
inner join `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimOrderType.DimOrderType` t7 on  t2.orderType_key=t7.orderType_key
inner join `conradnl-mit-gcgen-prod.Testsets_Matthijs.Merkoverzicht_Salesweek` t8 on t3.brandManufactorer=t8.string_field_0
WHERE t1.salesOrg IN ('5400')
      And t2.date_key >= 20190101
      AND t2.partitionDate >= '2019-01-01'
      
GROUP BY
  if(t6.flagManaged=1, 'Personally Managed','Digitally Managed'),
  t1.salesOrg,
  t1.sellerGrp_key,
  t2.date_key,
  t3.productNo,
  t3.brandManufactorer,
  t8.string_field_1,
  t4.maingrp_key,
  t4.matClass_key,
  t4.matClassDescEng,
  t2.nnt,
  t2.cm1,
  t4.maingrpDescEng,
  t5.Campagne,
  t7.orderTypeDescEng,
	t7.orderTypeGrpDescEng,
  t2.invoiceDate,
  EXTRACT(year from t2.invoiceDate),
  format("%02d", EXTRACT(month from t2.invoiceDate)),
  EXTRACT(quarter from t2.invoiceDate),
  format("%02d", EXTRACT(isoweek from t2.invoiceDate)),
  EXTRACT(isoyear from t2.invoiceDate),
  format("%02d", EXTRACT(dayofweek from DATE_SUB(t2.invoiceDate, interval 1 day)))||'-'||FORMAT_DATE("%A", t2.invoiceDate),
  if(EXTRACT(dayofyear from t2.invoiceDate) >=0 and EXTRACT(dayofyear from t2.invoiceDate) < EXTRACT(dayofyear from endDate),1,0)
  )

Salesweek script.txt
Displaying Salesweek script.txt.
