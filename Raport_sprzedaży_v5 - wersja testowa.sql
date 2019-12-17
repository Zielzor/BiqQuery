SELECT DISTINCT
a.date_key as _1_Data, 
c.profitCenter as _2_Profit_Center,
--Pola utworzeone poprzez wyrażenia warunkowe
CASE
WHEN salesDistrict = "5800"  or salesDistrict = "5801" or salesDistrict = "5802" or salesDistrict = "5806" or salesDistrict = "5823"  THEN "KAM TEAM"  
WHEN salesDistrict != "5800" or salesDistrict != "5801" or salesDistrict = "5802" or salesDistrict = "5806" or salesDistrict = "5823" or salesDistrict is not null  THEN "SALES TEAM CUSTOMER" 
WHEN j.Grupa_Insert_1 ="95" THEN "MARKETPLACE CUSTOMERS"
WHEN j.Grupa_Insert_1 = "00" or j.Grupa_Insert_1 = "62" THEN "SHOP CUSTOMERS"
WHEN a.OrderNo = "9999999998" THEN "ADJUSTMENTS"
END as _3_Customer_Groups,

CASE
WHEN j.Grupa_Insert_2 = "OCI" and salesDistrict = "5806" THEN "E-procurement"
WHEN j.Grupa_Insert_2 = "e-catalog" and salesDistrict = "5806" THEN "E-procurement"
WHEN j.Grupa_Insert_2 = "Conrad Smart Procure" THEN "E-procurement"
END as _4_E_Procurment_Groups,

---koniec wartości warunkowej
c.salesDistrict as _5_Sales_District,
c.customerInformation as _6_Customer_information,
a.OrderNo as _7_Order_No,
g.insert_key as _8_Insert_DE,
j.Grupa_Insert_1  as _9_Group_Insert_1,
j.Grupa_Insert_2 as _10_Group_Insert_2,
j.Grupa_Insert_3 as _11_Grupa_Insert_3,
f.quarter as _11_Quarter_of_year,
f.monthNum as _12_Month,
f.dayOfMonth as _13_Day,
a.productNo_key as _14_Article_ID,
a.quantitySales as _15_ABSMG_Sales_Quantity,
a.invoiceNo as _16_Invoice_no,
h.productNo_key as _17_Article_No,
h.brandManufactorer as _18_Brand,
h.matClass_key as _19_MATKL, 
d.billingKind_key as _20_Document_type,
d.billingKindDescEng as _21_Document_Name,
e.paymentMethodDescEng as _22_PaymentMethod,
k.productDesc as _23_Article_Name,
a.vv001 as _24_Catalog_Price_Gross_EURO,
a.vv002 as _25_Catalog_Price_Net_EUR0,
a.discount as _26_Condition_EURO,
(a.vv005 * -1) as _27_Staggered_discount,
a.customerDiscount as  _28_Customer_Discount_EURO,
(a.reduction * -1) as _29_Reduction,
(a.vv003 * -1) as _30_Customer_full_Discount,
(a.vv017 * -1) as _31_Increments,
a.nnt as _32_NNT_EURO,
a.movingAverageCOGS as _33_COGS_EURO, 
a.nnt - a.movingAverageCOGS as _34_CM1_EURO,
a.vv201 as _35_Catalog_revenues_EURO,
(a.nnt / m.rate) as _36_NNT_PLN,
(a.nnt - a.movingAverageCOGS) / m.rate as _37_CM1_PLN,
a.calcCashDiscount as _38_Calc_Discount_EURO,
a.priceReduction as _39_Price_Reduction_EURO, 
a.userName as _40_User_Name,
c.name1 as _41_Customer_Name_1,
c.firstName as _42_Customer_Name_2,
c.name3 as _43_Customer_Name_3,
c.name4 as _44_Customer_Name_4,
b.maingrpDescEng as _45_Head_Group, -- dopóki nie rozwiążę  problemu z hed grupami nie będziemy wykorzystywać tego zgrupowania
b.categoryDescEng as _46_Categorie,
b.category_key as _47_category_key,
a.conditions as _49_Condition

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


WHERE a.partitionDate BETWEEN  "2019-12-01"  and CURRENT_DATE() #wycinek poddawany analizie
and a.date_key BETWEEN 20191201 AND 20191215 #zakres analizy 
and a.productNo_key = b.productNo_key
and a.productNo_key = h.productNo_key
and a.customerNo_key = c.customerNo_key
and a.billingKind_key = d.billingKind_key
and a.termsOfPayment = e.termsOfPayment
and a.date_key = f.date_key
and a.hGlobalAdvertisingMaterial_key = g.globalAdvertisingMaterial_key
and a.globalPc_key = i.globalPc_key
and i.companyCode_key = '0581'
and a.nnt != 0 
and g.insert_key = j.Grupa_Insert_1
and k.productNo_key = h.productNo_key
and k.salesOrg_key = "5810"
-- relacje do kursu walut
and m.curr_key = "PLN"
and m.date_key = 20191213 #DATE KURSU NALEŻY ZAWSZE BRAC Z DNIA POPRZEDNIEGO
and m.version_key = "ISJA20060201"
and b.matClassDescEng != "***INACTIVE***"

GROUP BY a.date_key,
c.profitCenter,
c.salesDistrict, 
a.OrderNo,
j.Grupa_Insert_1,
j.Grupa_Insert_3,
j.Grupa_Insert_2,
a.fiscalYear,
f.quarter,
f.monthNum,
f.dayOfMonth,
a.productNo_key,
a.customerNo_key,
a.invoiceNo,
h.productNo_key,
h.brandManufactorer,
h.matClass_key, 
d.billingKind_key,
d.billingKindDescEng,
e.paymentMethodDescEng,
k.productDesc,
a.vv001,
a.vv002,
a.vv201,
a.nnt,
a.netTurnoverGoods,
a.movingAvgPrice,
a.mapReturn1,
a.movingAverageCOGS, 
a.nnt - a.movingAverageCOGS,
a.discount,
a.calcCashDiscount,
a.customerDiscount,
a.priceReduction, 
a.vv215,
a.supplierDiscount,
a.userName,
a.period,
c.customerNo_key,
c.name1,
c.firstName,
c.name3,
c.name4,
g.insert_key,
c.customerInformation,
a.vv005,
a.vv003,
a.vv017,
a.reduction,
b.maingrpDescEng,
b.categoryDescEng,
b.category_key,
a.quantitySales,
m.rate,
a.conditions



ORDER BY a.date_key,
f.dayOfMonth,
h.brandManufactorer, 
h.matClass_key 
DESC







