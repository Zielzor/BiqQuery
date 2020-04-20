CREATE OR REPLACE TABLE  `ceeregion-prod.Dashboards_CEPL_2020.slowenia1` AS 
SELECT
a.date_key,
a.globalPc_key,
a.version_key,
a.pGlobalAdvertisingMaterial_key, 
a.customerNo_key,
a.invoiceNo_key,
a.orderNo_key,
a.OrderNo,
a.orderType_key as POType,
a.quantitySales as ABSMGSalesQuantity,
a.invoiceNo as InvoiceNo,
a.termsOfPayment,
a.billingKind_key,
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
  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` c

WHERE PARTITIONDATE >= "2019-12-29" #Wystarczy zmienić miesiąc aby dostać nowy raport
AND a.globalpc_key=b.globalpc_key
AND b.salesOrg_key='5900'
AND a.version_key='ISJA20060201' #Filtr
AND a.date_key>=20191229
---------DimProduct
AND a.productNo_key = c.productNo_key


GROUP BY a.customerNo_key,a.invoiceNo_key,a.orderNo_key,a.OrderNo,a.orderType_key,a.quantitySales,a.invoiceNo,a.salesOrderPos, 
a.vv002,a.discount,a.vv005,a.customerDiscount,a.reduction,a.vv003,a.vv017,a.calcCashDiscount,
a.userName,a.conditionstotal,a.nnt,a.cm1,a.fiscalYear,a.period,a.productNo_key,b.profitcenterCe_key,
c.privateLabelManufactorer,c.brandManufactorer,c.matClass_key,a.date_key,a.globalPc_key,a.version_key,
a.pGlobalAdvertisingMaterial_key,a.termsOfPayment,a.billingKind_key;

---------etap drugi dowiązanie DimProductHierarchy
CREATE OR REPLACE TABLE  `ceeregion-prod.Dashboards_CEPL_2020.slowenia2` AS 
SELECT 
a.*,
b.maingrpDescEng as HeadGroup, -- dopóki nie rozwiążę  problemu z hed grupami nie będziemy wykorzystywać tego zgrupowania
b.categoryDescEng as Categorie,
b.category_key as categoryKey,


FROM `ceeregion-prod.Dashboards_CEPL_2020.slowenia1`  a,
      `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` b

WHERE a.productNo_key = b.productNo_key 
AND b.flagActive  != 0;

---------etap trzeci dowiązanie DimProductSalesOrg
CREATE OR REPLACE TABLE  `ceeregion-prod.Dashboards_CEPL_2020.slowenia3` AS 
SELECT DISTINCT
a.*,
b.productDesc as bArticle_Name,

FROM `ceeregion-prod.Dashboards_CEPL_2020.slowenia2` a
      LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` b on a.productNo_key = b.productNo_key and b.salesOrg_key = "5900";

---------etap czwarty dowiązanie DimCustomer
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia4` AS 
SELECT
a.*,
b.salesDistrict as SalesDistrict,
b.name1 as CustomerName1,
b.firstName as CustomerName2,
b.name3 as CustomerName3,
b.name4 as CustomerName4,
b.customerInformation as Customer_information


FROM  `ceeregion-prod.Dashboards_CEPL_2020.slowenia3` a,
      `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as b

WHERE  a.customerNo_key = b.customerNo_key;
---------etap piąty dowiązanie DimAdvertisingMaterial
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia5` AS 
SELECT
a.*,
b.insert_key as InsertKey
FROM `ceeregion-prod.Dashboards_CEPL_2020.slowenia4` a,
      `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimAdvertisingMaterial.DimAdvertisingMaterial` as b

WHERE a.pGlobalAdvertisingMaterial_key = b.globalAdvertisingMaterial_key;

---------etap szósty dowiązanie DimPaymentCondition
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia6` AS 
SELECT 
a.*,
b.paymentMethodDescEng as PaymentMethod


FROM `ceeregion-prod.Dashboards_CEPL_2020.slowenia5` a,
      `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimPaymentCondition.DimPaymentCondition` as b

WHERE  a.termsOfPayment = b.termsOfPayment;

---------etap siódmy dowiązanie DimBillingType 
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia7` AS 
SELECT 
a.*,
b.billingKind_key as Document_type,
b.billingKindDescEng as Document_Name,

FROM  `ceeregion-prod.Dashboards_CEPL_2020.slowenia6` a,
      `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimBillingType.DimBillingType` as b

WHERE  a.billingKind_key = b.billingKind_key;

---------etap ósmy dowiązanie GlobalnychInsertów
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia8` AS 
SELECT 
a.*,
b.Grupa_Insert_1

FROM `ceeregion-prod.Dashboards_CEPL_2020.slowenia7` as a
LEFT JOIN `ceeregion-prod.InsertKody.TabelaInsertKody` as b on  a.InsertKey = b.Grupa_Insert_1;

---------etap dziwwiąty dowiązanie GlobalnychSalesDistrów
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia9` AS 
SELECT 
a.*,
b.KamName
FROM `ceeregion-prod.Dashboards_CEPL_2020.slowenia8` as a 
LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST` b on a.SalesDistrict = b.SalesDistrict;

---------etap dziesiąty dowiązanie Dat
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia10` AS 
SELECT 
a.*,
b.date

FROM `ceeregion-prod.Dashboards_CEPL_2020.slowenia9` as a, 
      `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b
WHERE a.date_key = b.date_key;

---------etap Finalny/agregacja/selekcja 
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_SLO` AS 
SELECT	
a.date as Data,
a.fiscalYear,	
a.period,
a.customerNo_key,	
a.ProfitCenter,	
a.SalesDistrict,	
a.InsertKey,
a.Grupa_Insert_1,	
a.KamName,	
a.invoiceNo_key,	
a.InvoiceNo,	
a.Document_Name,	
a.Document_type,	
a.PaymentMethod,	
a.orderNo_key,	
a.OrderNo,	
a.POType,	
a.termsOfPayment,	
a.billingKind_key,	
a.productNo_key,	
a.bArticle_Name,	
a.categoryKey,	
a.Brand,	
a.MATKL,	
a.Categorie,	
a.HeadGroup,
a.Conrad_External,	
a.ABSMGSalesQuantity,	
a.PosNo,	
a.CatalogPriceNetEUR0,	
a.PriceReductionEURO,	
a.StaggeredDiscount,	
a.CustomerDiscountEURO,	
a._Reduction,	
a.CustomerFullDiscount,	
a.Increments,	
a.CalcDiscountEURO,	
a.UserName,	
a.Conditions,	
a.Costs,	
a.nnt	,
a.cm1	,
a.GLD	,
a.COGS,	
a.Customer_information,	
a.CustomerName1,
a.CustomerName2,	
a.CustomerName3,	
a.CustomerName4	


FROM `ceeregion-prod.Dashboards_CEPL_2020.slowenia10` as a

ORDER BY DATA DESC;

---drop śmietnika
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia1`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia2`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia3`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia4`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia5`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia6`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia7`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia8`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia9`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.slowenia10`;