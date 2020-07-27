CREATE OR REPLACE TABLE `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME1` as 
SELECT
a.invoiceNo_key,
a.orderNo_key,
a.date_key,
a.dateDue_key,
a.customerNo_key,
a.referenceInvoiceNo,
a.customerPurchaseOrderNo,
a.valueInvoice,
a.valueInvoiceLocalCurrency
a.valueDiscount,
a.datePaymentIncoming_key


FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactInvoiceHead.FactInvoiceHead`  as a
JOIN `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_INSERTION` as b on CAST(a.invoiceNo_key as INT64) = CAST(b.invoiceNo_key  as INT64)

ORDER BY a.date_key  DESC;
--- dowiązanie walut
CREATE OR REPLACE TABLE `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME2` as 
SELECT
a.*, 	 
ROUND((a.valueInvoice / b.rate), 2) as valueInvoice_PLN

FROM `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME1`as a,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as b 

WHERE a.dateDue_key = b.date_key
AND  b.version_key = "ISJA20060201"
AND b.curr_key = "PLN";
--- dowiązanie insertow
CREATE OR REPLACE TABLE `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME3` as 
SELECT
a.*,
b._43_Customer_Name_1,
b._44_Customer_Name_2,
b._45_Customer_Name_3,
b._46_Customer_Name_4, 
b._9_Group_Insert_1 as Insert_Code,
b._10_Group_Insert_2 as Insert_Code_Desc,

FROM `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME2` as a,
`ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_PL` as b

WHERE a.invoiceNo_key = b._19_Invoice_no;
--- selekcja
CREATE OR REPLACE TABLE `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_FINAL` as 
SELECT DISTINCT
a.Insert_Code_Desc,
a.Insert_Code,
a.customerNo_key,
a._43_Customer_Name_1,
a._44_Customer_Name_2,
a._45_Customer_Name_3,
a._46_Customer_Name_4, 
a.invoiceNo_key,
b.date as dateDue_key,
a.customerPurchaseOrderNo,
a.orderNo_key,


FROM `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME3` as a,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b 

WHERE a.date_key = b.date_key;

DROP TABLE `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME1`;
DROP TABLE `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME2`;
DROP TABLE `ceeregion-prod.aa_grzesiek_zientkiewicz_faktury.Numery_faktur_OUTCOME3`;
