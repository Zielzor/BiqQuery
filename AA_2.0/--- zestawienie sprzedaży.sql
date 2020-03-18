--- zestawienie sprzedaży
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.aa_sales_pl` AS
SELECT DISTINCT
a.date_key as _1_Data, 
i.profitcenterCe_key as _2_Profit_Center,

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
n.KamName as Name_Sales_District,
c.customerInformation as _5_Customer_information,
a.OrderNo as _6_Order_No,
a.customerNo_key as _7_Customer_No,
g.insert_key as _8_Insert_DE,
j.Grupa_Insert_1  as _9_Group_Insert_1,
j.Grupa_Insert_2 as _10_Group_Insert_2,
j.Grupa_Insert_3 as _11_Grupa_Insert_3,
a.orderType_key as _12_PO_Type,
f.quarter as _13_Quarter_of_year,
f.monthNum as _14_Month,
f.dayOfMonth as _15_Day,
a.productNo_key as _16_Article_ID,
CASE
WHEN h.privateLabelManufactorer is not null THEN "CONRAD" 
END as _17_Conrad_External,
#h.privateLabelManufactorer as _17_Conrad_External,
a.quantitySales as _18_ABSMG_Sales_Quantity,
a.invoiceNo as _19_Invoice_no,
h.productNo_key as _20_Article_No,
a.salesOrderPos as _21_Order_Pos,
h.brandManufactorer as _22_Brand,
h.matClass_key as _23_MATKL, 
d.billingKind_key as _24_Document_type,
d.billingKindDescEng as _25_Document_Name,
e.paymentMethodDescEng as _26_PaymentMethod,
k.productDesc as _27_Article_Name,
a.vv002 as _28_Catalog_Price_Net_EUR0,
(a.discount * -1) as _29_Price_Reduction_EURO,
(a.vv005 * -1) as _30_Staggered_discount,
(a.customerDiscount * -1) as _31_Customer_Discount_EURO,
(a.reduction * -1) as _32_Reduction,
(a.vv003 * -1) as _33_Customer_full_Discount,
(a.vv017 * -1) as _34_Increments,
a.nnt as _35_NNT_EURO,
a.movingAverageCOGS as _36_COGS_EURO, 
a.cm1 as _37_CM1_EURO,
a.vv201 as _38_Catalog_revenues_EURO,
(a.nnt / m.rate) as _39_NNT_PLN,
a.cm1 / m.rate as _40_CM1_PLN,
a.calcCashDiscount as _41_Calc_Discount_EURO,
a.userName as _42_User_Name,
c.name1 as _43_Customer_Name_1,
c.firstName as _44_Customer_Name_2,
c.name3 as _45_Customer_Name_3,
c.name4 as _46_Customer_Name_4,
b.maingrpDescEng as _47_Head_Group, -- dopóki nie rozwiążę  problemu z hed grupami nie będziemy wykorzystywać tego zgrupowania
b.categoryDescEng as _48_Categorie,
b.category_key as _49_category_key,
(a.conditionstotal * -1) as _50_Conditions,
(a.nnt - a.cm1) as _51_Costs


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
    `ceeregion-prod.InsertKody.TabelaInsertKody` as j,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as k,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` as m
    LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST`as n on  n.SalesDistrict = c.salesDistrict



WHERE a.partitionDate BETWEEN  "2019-12-29"  and CURRENT_DATE() #wycinek poddawany analizie

------
and a.productNo_key = b.productNo_key
and a.productNo_key = h.productNo_key
and a.customerNo_key = c.customerNo_key
and a.billingKind_key = d.billingKind_key
and a.termsOfPayment = e.termsOfPayment
and a.date_key = f.date_key
and a.pGlobalAdvertisingMaterial_key = g.globalAdvertisingMaterial_key
and a.globalPc_key = i.globalPc_key
and i.companyCode_key = '0581'
and a.nnt != 0 
and g.insert_key = j.Grupa_Insert_1
and k.productNo_key = h.productNo_key
and k.salesOrg_key = "5810"
-- relacje do kursu walut
and m.curr_key = "PLN"
and a.date_key = m.date_key  #DATE KURSU NALEŻY ZAWSZE BRAC Z DNIA POPRZEDNIEGO
and m.version_key = "ISJA20060201"
and b.flagActive  != 0;

--- stworzenie adjustemntsów
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.aa_adjustments_pl` AS
SELECT 
a.date_key as _1_Data,
e.profitcenterCe_key as _2_Profit_Center,
--Pola utworzeone poprzez wyrażenia warunkowe
CASE
WHEN a.orderNo = '9999999998' THEN "5.NIEPRZYPISANE"
END as _3_Customer_Groups,
---koniec wartości warunkowej
a.orderNo as _6_Order_No,
h.insert_key as _8_Insert_DE,
i.Grupa_Insert_1  as _9_Group_Insert_1,
i.Grupa_Insert_2 as _10_Group_Insert_2,
i.Grupa_Insert_3 as _11_Grupa_Insert_3,
a.orderType_key as _12_PO_Type, 
b.quarter as _13_Quarter_of_year,
b.monthNum as _14_Month,
b.dayOfMonth as _15_Day,
a.invoiceNo as _19_Invoice_no,
a.productNo_key  as _20_Article_No,
a.billingKind_key as _24_Document_type,
a.nnt as _35_NNT_EURO,
a.cm1 as _37_CM1_EURO,
(a.nnt / c.rate) as _39_NNT_PLN,
(a.cm1 / c.rate) as  _40_CM1_PLN,
a.userName as _42_User_Name,
(a.nnt - a.cm1) as _51_Costs,

 
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
and e.salesOrg_key='5810'
and a.version_key  = "ISJA20060201"
and a.version_key  = d.VERSION_KEY 
and a.customerNo_key  = f.customerNo_key 
and e.costCenterNo != 4211
and a.date_key  = g.date_key
and a.hGlobalAdvertisingMaterial_key = h.globalAdvertisingMaterial_key
and h.insert_key = i.Grupa_Insert_1
-- relation to version
and a.version_key=d.version_key
and d.budgetart_key='IS' -- type of version is "IS"
--waluty
and c.curr_key = "PLN"
and a.date_key = c.date_key 
and a.date_key = b.date_key 
and c.version_key = "ISJA20060201"
---reszta 
and orderNo = "9999999998";

--- union całości
CREATE OR REPLACE TABLE `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_PL` AS
SELECT *

FROM
  `ceeregion-prod.Dashboards_CEPL_2020.aa_sales_pl` as a

UNION ALL

SELECT 
b._1_Data,
b._2_Profit_Center,
b._3_Customer_Groups,
NULL as _4_,
NULL as Name_Sales_Districts,
NULL as _5_,
b._6_Order_No,
NULL as _7_,
b._8_Insert_DE,
b._9_Group_Insert_1,
b._10_Group_Insert_2,
b._11_Grupa_Insert_3,
b._12_PO_Type,
b._13_Quarter_of_year, 
b._14_Month,
b._15_Day,
NULL as _16_,
NULL as _17_,
NULL as _18_,
b._19_Invoice_no,
b._20_Article_No,
NULL as _21_,
NULL as _22_,
NULL as _23_,
b._24_Document_type,
NULL as _25_,
NULL as _26_,
NULL as _27_,
NULL as _28_,
NULL as _29_,
NULL as _30_,
NULL as _31_,
NULL as _32_,
NULL as _33_,
NULL as _34_,
b._35_NNT_EURO,
NULL as _36_,
b._37_CM1_EURO,
NULL as _38_,
b._39_NNT_PLN,
b._40_CM1_PLN,
NULL as _41_,
b._42_User_Name,
NULL as _43_Costs,
NULL as_44_Costs,
NULL as_45_Costs,
NULL as_46_Costs,
NULL as_47_Costs,
NULL as_48_Costs,
NULL as_49_Costs,
NULL as_50_Costs,
b._51_Costs
FROM
  `ceeregion-prod.Dashboards_CEPL_2020.aa_adjustments_pl` as b;

--- usuwanie niepotrzebnych tabel
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.aa_sales_pl`;
DROP TABLE `ceeregion-prod.Dashboards_CEPL_2020.aa_adjustments_pl`;

