SELECT DISTINCT
a.date_key as Data, 
c.profitCenter as Profit_Center,
c.salesDistrict as Sales_District, 
a.OrderNo as Order_No,
j.Insert as Group_Insert_1,
j.Grupa_Insert_2 as Group_Insert_2 ,
a.fiscalYear as Yer,
f.quarter as Quarter_of_year,
f.monthNum as Month,
f.dayOfMonth as Day,
a.productNo_key as Article_ID,
a.invoiceNo as invoice_no,
h.productNo_key as Article_No,
h.brandManufactorer as Brand,
h.matClass_key as MATKL, 
d.billingKind_key as Document_type,
d.billingKindDescEng as Document_Name,
e.paymentMethodDescEng as PaymentMethod,
k.productDesc as Article_Name,
a.vv001 as Catalog_Price_Gross(EUR),
a.vv002 as Catalog_Price_Net(EUR),
a.vv201 as Catalog_revenues(EUR),
a.nnt as NNT(EUR),
a.movingAverageCOGS as COGS(EUR), 
a.nnt - a.movingAverageCOGS as CM1(EUR),
a.discount as Condition(EUR),
a.calcCashDiscount as Calc_Discount (EUR),
a.customerDiscount as  Customer_Discount (EUR),
a.priceReduction as Price_Reduction (EUR), 
a.userName as User_Name,
c.name1 as Customer_Name_1,
c.firstName as Customer_Name_2,
c.name3 as Customer_Name_3,
c.name4 as Customer_Name_4,

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
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as k

WHERE a.date_key BETWEEN 20191101 AND 20191131
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
and g.insert_key = j.Insert
and k.productNo_key = h.productNo_key
and k.salesOrg_key = "5810"

GROUP BY a.date_key,
c.profitCenter,
c.salesDistrict, 
a.OrderNo,
j.Insert,
j.Nazwa_Insert,
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
c.name4



ORDER BY a.date_key,
f.dayOfMonth,
h.brandManufactorer, 
h.matClass_key 
DESC







