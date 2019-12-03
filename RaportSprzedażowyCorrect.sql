SELECT DISTINCT
a.date_key,
c.profitCenter,
c.salesDistrict,
a.OrderNo as Order_No,
g.insert_key,
j.Insert as Insert_PL,
j.Grupa_Insert_1,
j.Grupa_Insert_2 as TEAM,
g.insertDescEng,
g.advertisingMatOrderDescEng,
f.quartal_key as Kwartal,
f.monthNum as Miesiac,
f.dayOfMonth as Dzien,
a.productNo_key as ID_Artykulu,
a.customerNo_key,
a.invoiceNo as invoice_no,
h.productNo_key,
h.brandManufactorer as Marka,
h.matClass_key as MATKL, 
d.billingKind_key,
d.billingKindDescEng,
e.paymentMethodDescEng,
h.productDescEng,
a.fiscalYear as Rok,
a.vv001 as Catalog_Price_Gross,
a.vv002 as Catalog_Price_Net,
a.vv201 as Catalog_revenues,
a.nnt,
a.netTurnoverGoods,
a.movingAvgPrice as GLD,
a.mapReturn1,
a.movingAverageCOGS as COGS,
a.cm1/a.nnt as CM1_Procentowe,
a.discount as Znizka,
a.calcCashDiscount,
a.customerDiscount,
a.priceReduction, 
a.vv215 as Sales_Purchasing_Price,
a.supplierDiscount,
a.userName,
a.period,
c.customerNo_key as Nr_Klienta,
c.name1,
c.firstName,
c.name3,
c.name4,
c.street,
c.region,
c.zipCode,
c.city,
c.eMailAddress


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
`ceeregion-prod.InsertKody.Insert_Kod_PL` as j

WHERE a.date_key BETWEEN 20191001 AND 20191031
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

GROUP BY f.dayOfMonth, a.date_key, c.profitCenter, g.insert_key, g.advertisingMatOrderDescEng,h.brandManufactorer, a.OrderNo,g.insertDescGer, g.insertDescEng, g.advertisingMatOrderDescGer,f.quartal_key,f.monthNum,
a.productNo_key, a.globalProductHierarchy_key, a.customerNo_key, a.invoiceNo, h.productNo_key, h.matClass_key, d.billingKind_key, d.billingKindDescEng, e.paymentMethodDescEng, h.productDescEng, a.fiscalYear, a.vv001,a.vv002,a.vv201, a.CatalogPriceNet, a.CatalogPriceGross, a.nnt, a.nnt1 , a.nnt2, a.netTurnoverGoods,a.movingAvgPrice, a.mapReturn1, a.movingAverageCOGS, a.cm1, a.discount, a.calcCashDiscount, a.vv003,a.vv004, a.vv011, a.vv012, a.customerDiscount , a.priceReduction, a.vv005,a.vv006, a.vv215, a.supplierDiscount, a.userName, a.period, c.customerNo_key, c.name1, c.firstName, c.name3, c.name4, c.street, c.region, c.zipCode , c.city,c.eMailAddress,c.salesDistrict,j.Insert, j.Grupa_Insert_1, j.Grupa_Insert_2 

ORDER BY a.date_key, h.brandManufactorer, h.matClass_key DESC







