SELECT DISTINCT
a.date_key as _1_Data, 
c.profitCenter as _2_Profit_Center,
--Pola utworzeone poprzez wyrażenia warunkowe

CASE
WHEN salesDistrict = "5800"  or salesDistrict = "5801" or salesDistrict = "5802" or salesDistrict = "5806" or salesDistrict = "5823" THEN "KAM TEAM"  
WHEN salesDistrict != "5800" or salesDistrict != "5801" or salesDistrict = "5802" or salesDistrict = "5806" or salesDistrict = "5823" or salesDistrict is not null  THEN "SALES TEAM CUSTOMER" 
WHEN j.Grupa_Insert_1 ="95" THEN "MARKETPLACE CUSTOMERS"
WHEN j.Grupa_Insert_1 = "00" or j.Grupa_Insert_1 = "62" THEN "SHOP CUSTOMERS"
WHEN a.OrderNo = "9999999998" THEN "ADJUSTMENTS"
END as _3_Customer_Groups,

---koniec wartości warunkowej
c.salesDistrict as _4_Sales_District,
c.customerInformation as _5_Customer_information,
a.OrderNo as _6_Order_No,
g.insert_key as _7_Insert_DE,
j.Grupa_Insert_1  as _8_Group_Insert_1,
j.Grupa_Insert_2 as _9_Group_Insert_2,
j.Grupa_Insert_3 as _10_Grupa_Insert_3,
f.quarter as _11_Quarter_of_year,
f.monthNum as _12_Month,
f.dayOfMonth as _13_Day,
a.productNo_key as _14_Article_ID,
a.invoiceNo as _15_Invoice_no,
h.productNo_key as _16_Article_No,
h.brandManufactorer as _17_Brand,
h.matClass_key as _18_MATKL, 
d.billingKind_key as _19_Document_type,
d.billingKindDescEng as _20_Document_Name,
e.paymentMethodDescEng as _21_PaymentMethod,
k.productDesc as _22_Article_Name,
a.vv001 as _23_Catalog_Price_Gross_EURO,
(a.vv001 / m.rate) as _24_Catalog_Price_GROSS_Net_PLN,
a.vv002 as _25_Catalog_Price_Net_EUR0,
(a.vv002 / m.rate ) as _26_Catalog_Price_Net_PLN,
a.vv201 as _27_Catalog_revenues_EURO,
(a.vv201 / m.rate) as _28_Catalog_revenues_PLN,
a.nnt as _29_NNT_EURO,
(a.nnt / m.rate) _30_NNT_PLN,
a.movingAverageCOGS as _31_COGS_EURO,
(a.movingAverageCOGS / m.rate) as _32_COGS_PLN,
a.nnt - a.movingAverageCOGS as _33_CM1_EURO,
(a.nnt - a.movingAverageCOGS) / m.rate as _33_CM1_PLN,
a.discount as _34_Condition_EURO,
(a.discount / m.rate) as _35_Condition_EURO,
a.calcCashDiscount as _36_Calc_Discount_EURO,
a.calcCashDiscount / m.rate as _37_Calc_Discount_PLN,
a.customerDiscount as  _38_Customer_Discount_EURO,
a.customerDiscount / m.rate _39_Customer_Discount_PLN,
a.priceReduction as _40_Price_Reduction_EURO,
a.priceReduction / m.rate as _41_Price_Reduction_PLN,
a.userName as _42_User_Name,
c.name1 as _43_Customer_Name_1,
c.firstName as _44_Customer_Name_2,
c.name3 as _45_Customer_Name_3,
c.name4 as _46_Customer_Name_4,
(a.vv005 / m.rate)* -1 as _49_Staggered_discount_EURO,
(a.vv003 / m.rate)* -1 as _50_Customer_full_Discount_EURO,
(a.vv017 / m.rate)* -1 as _51_Increments_EURO,
(a.reduction / m.rate)* -1 as _52_Reduction_EURO,
b.maingrpDescEng as _53_Head_Group,
b.categoryDescEng as _54_Categorie,
b.category_key as _55_category_key



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
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCurr.DimCurr` l, 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` m


WHERE a.date_key BETWEEN 20191201 AND 20191210
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
and l.curr_key='PLN' 
and l.curr_key=m.curr_key 


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
m.rate

ORDER BY a.date_key,
f.dayOfMonth,
h.brandManufactorer, 
h.matClass_key,
b.category_key
DESC







