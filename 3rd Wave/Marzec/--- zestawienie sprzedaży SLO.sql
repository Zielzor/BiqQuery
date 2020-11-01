--- zestawienie sprzedaży SLO 
CREATE OR REPLACE TABLE   `ceeregion-prod.Dashboards_CEPL_2020.aa_sales_SLO` AS 
SELECT 
a.date_key as _1_Data, 
i.profitcenterCe_key  as _2_Profit_Center,

--Pola utworzeone poprzez wyrażenia warunkowe
CASE
WHEN c.salesDistrict = "5800"  or c.salesDistrict = "5801" or c.salesDistrict = "5802" or c.salesDistrict = "5806" or c.salesDistrict = "5823"  THEN "2.KAM TEAM"  
WHEN c.salesDistrict != "5800" or c.salesDistrict != "5801" or c.salesDistrict != "5802" or c.salesDistrict != "5806" or c.salesDistrict != "5823" or c.salesDistrict is not null  THEN "3.SALES TEAM" 
WHEN j.Grupa_Insert_1 ="95" THEN "4.MARKETPLACE"
WHEN j.Grupa_Insert_1 = "00" or j.Grupa_Insert_1 = "62" THEN "1.ONLINE"
WHEN  c.salesDistrict is null THEN "3.SALES TEAM"
END as _3_Customer_Groups,
---koniec wartości warunkowej

c.salesDistrict as _4_Sales_District,
n.KamName as Name_SalesDistrict,
c.customerInformation as _5_Customer_information,
a.OrderNo as _6_Order_No,
a.dateCreation DESC as _7_Customer_No,
g.insert_key as _8_Insert_DE,
a.orderType_key as _9_PO_Type,
f.quarter as _10_Quarter_of_year,
f.monthNum as _11_Month,
f.dayOfMonth as _12_Day,
a.productNo_key as _13_Article_ID,
h.privateLabelManufactorer as _14_Conrad_External,
a.quantitySales as _15_ABSMG_Sales_Quantity,
a.invoiceNo as _16_Invoice_no,
h.productNo_key as _17_Article_No,
a.salesOrderPos as _18_Pos_no,
h.brandManufactorer as _19_Brand,
h.matClass_key as _20_MATKL, 
d.billingKind_key as _21_Document_type,
d.billingKindDescEng as _22_Document_Name,
e.paymentMethodDescEng as _23_PaymentMethod,
k.productDesc as _24_Article_Name,
a.vv002 as _25_Catalog_Price_Net_EUR0,
(a.discount * -1) as _26_Price_Reduction_EURO,
(a.vv005 * -1) as _27_Staggered_discount,
(a.customerDiscount * -1) as _28_Customer_Discount_EURO,
(a.reduction * -1) as _29_Reduction,
(a.vv003 * -1) as _30_Customer_full_Discount,
(a.vv017 * -1) as _31_Increments,
a.nnt as _32_NNT_EURO,
a.movingAverageCOGS as _33_COGS_EURO, 
a.nnt - a.movingAverageCOGS as _34_CM1_EURO,
a.vv201 as _35_Catalog_revenues_EURO,
(a.nnt / m.rate) as _36_NNT_NAT_CURRENCY,
(a.nnt - a.movingAverageCOGS) / m.rate as _37_CM1_NAT_CURRENCY,
a.calcCashDiscount as _38_Calc_Discount_EURO,
a.userName as _39_User_Name,
c.name1 as _40_Customer_Name_1,
c.firstName as _41_Customer_Name_2,
c.name3 as _42_Customer_Name_3,
c.name4 as _43_Customer_Name_4,
b.maingrpDescEng as _44_Head_Group, -- dopóki nie rozwiążę  problemu z hed grupami nie będziemy wykorzystywać tego zgrupowania
b.categoryDescEng as _45_Categorie,
b.category_key as _46_category_key,
(a.conditionstotal * -1) as _47_Conditions,
(a.nnt - a.cm1) as _48_Costs


FROM
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as b,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as c,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimBillingType.DimBillingType` as d ,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimPaymentCondition.DimPaymentCondition` as e,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as f,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimAdvertisingMaterial.DimAdvertisingMaterial` as g,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as h,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as i,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as k,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as m
    LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST`as n on  n.SalesDistrict = c.salesDistrict
    LEFT JOIN `ceeregion-prod.InsertKody.TabelaInsertKody` as j on  g.insert_key = j.Grupa_Insert_1


WHERE a.partitionDate BETWEEN  "2020-01-01"  and CURRENT_DATE() #wycinek poddawany analizie
and a.date_key>=20200101
------
and a.productNo_key = b.productNo_key
and a.productNo_key = h.productNo_key
and a.dateCreation DESC = c.dateCreation DESC
and a.billingKind_key = d.billingKind_key
and a.termsOfPayment = e.termsOfPayment
and a.date_key = f.date_key
and a.pGlobalAdvertisingMaterial_key = g.globalAdvertisingMaterial_key
and a.globalPc_key = i.globalPc_key
and i.salesOrg_key = "5900" #zmienic na sales_org key
and a.nnt != 0 
#and g.insert_key = j.Grupa_Insert_1
and k.productNo_key = h.productNo_key
and k.salesOrg_key = "5900"
-- relacje do kursu walut
and m.curr_key = "EUR"
and a.date_key = m.date_key  #DATE KURSU NALEŻY ZAWSZE BRAC Z DNIA POPRZEDNIEGO
and m.version_key = "ISJA20060201"
and b.flagActive  != 0;
------

---zestawienie adjustments SLO 
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.aa_adjustments_SLO` AS
SELECT 
a.date_key as _1_Data,
e.profitcenterCe_key as _2_Profit_Center,
a.orderNo as _6_Order_No,
h.insert_key as _8_Insert_DE,
a.orderType_key as _9_PO_Type, 
b.quarter as _10_Quarter_of_year,
b.monthNum as _11_Month,
b.dayOfMonth as _12_Day,
a.invoiceNo as _16_Invoice_no,
a.productNo_key  as _17_Article_No,
a.billingKind_key as _21_Document_type,
a.nnt as _32_NNT_EURO,
a.cm1 as _34_CM1_EURO,
(a.nnt / c.rate) as _36_NNT_NAT_CURRENCY,
(a.cm1 / c.rate) as  _37_CM1_NAT_CURRENCY,
a.userName as _39_User_Name,
(a.nnt - a.cm1) as _48_Costs,

 
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.ViewDimVersion` as d,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as e,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as f,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar`as g,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimAdvertisingMaterial.DimAdvertisingMaterial` as h,
    `ceeregion-prod.InsertKody.TabelaInsertKody` i,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as c

WHERE partitionDate BETWEEN  "2020-01-01"  and CURRENT_DATE()
and a.globalPc_key=e.globalPc_key
and e.salesOrg_key='5900'
and a.version_key  = "ISJA20060201"
and a.version_key  = d.VERSION_KEY 
and a.dateCreation DESC  = f.dateCreation DESC 
and e.costCenterNo != 4211
and a.date_key  = g.date_key
and a.hGlobalAdvertisingMaterial_key = h.globalAdvertisingMaterial_key
and h.insert_key = i.Grupa_Insert_1
-- relation to version
and a.version_key=d.version_key
and d.budgetart_key='IS' -- type of version is "IS"
--waluty
and c.curr_key = "EUR"
and a.date_key = c.date_key 
and a.date_key = b.date_key 
and c.version_key = "ISJA20060201"
---reszta 
and orderNo = "9999999998";

--- union wszystkiego 
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_PL` AS 
SELECT *

FROM
  `ceeregion-prod.Dashboards_CEPL_2020.aa_sales_SLO` as a

UNION ALL

SELECT
b._1_Data,
b._2_Profit_Center,
NULL as _3_Puste,
NULL as _4_Puste,
Null as Name_SalesDistrict,
NULL as _5_Puste,
b._6_Order_No,
NULL as _7_Puste,
b._8_Insert_DE,
b._9_PO_Type,
b._10_Quarter_of_year,
b._11_Month,
b._12_Day,
NULL as _13_Puste,
NULL as _14_Puste,
NULL as _15_Puste,
b._16_Invoice_no,
b._17_Article_No,
NULL as _18_Puste,
NULL as _19_Puste,
NULL as _20_Puste,
b._21_Document_type,
NULL as _22_Puste,
NULL as _23_Puste,
NULL as _24_Puste,
NULL as _25_Puste,
NULL as _26_Puste,
NULL as _27_Puste,
NULL as _28_Puste,
NULL as _29_Puste,
NULL as _30_Puste,
NULL as _31_Puste, 
b._32_NNT_EURO,
NULL as _33_Puste,
b._34_CM1_EURO,
NULL as _35_Puste,
b._36_NNT_NAT_CURRENCY,
b._37_CM1_NAT_CURRENCY,
NULL as _38_Puste,
b._39_User_Name,
NULL as _40_Puste,
NULL as _41_Puste,
NULL as _42_Puste,
NULL as _43_Puste,
NULL as _44_Puste,
NULL as _45_Puste,
NULL as _46_Puste,
NULL as _47_Puste,
b._48_Costs

FROM
  `ceeregion-prod.Dashboards_CEPL_2020.aa_adjustments_SLO` as b;

--- usuwanie niepotrzebnych tabel
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.aa_sales_SLO`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.aa_adjustments_SLO`;







