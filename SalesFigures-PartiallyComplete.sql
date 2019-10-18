SELECT DISTINCT
a.date_key,
c.profitCenter,
a.OrderNo as Order_No,
g.insert_key,
g.insertDescGer,
g.insertDescEng,
g.advertisingMatOrderDescGer,
g.advertisingMatOrderDescEng,
f.quartal_key as Kwartal,
f.monthNum as Miesiac,
f.dayOfMonth as Dzien,
a.productNo_key as ID_Artykulu,
a.globalProductHierarchy_key,
a.customerNo_key,
a.invoiceNo as invoice_no,
h.productNo_key,
d.billingKind_key,
d.billingKindDescEng,
e.paymentMethodDescEng,
h.productDescEng,
a.fiscalYear as Rok,
a.nnt,
a.netTurnoverGoods,
a.movingAvgPrice as GLD,
a.mapReturn1,
a.movingAverageCOGS as COGS,
a.cm1,
a.userName,
a.period,
c.customerNo_key as Nr_Klienta,
CONCAT(c.name1," ",c.firstName," ",c.name3) as Customer_Name,
CONCAT(c.name1," ",c.name3," ",c.name4) as Customer_Name_2,
c.street,
c.region,
c.zipCode,
c.city,
c.eMailAddress


FROM
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as a,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as b,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as c,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimBillingType.DimBillingType` as d,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimPaymentCondition.DimPaymentCondition` as e,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as f,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimAdvertisingMaterial.DimAdvertisingMaterial` as g,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as h,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as i

WHERE a.date_key BETWEEN 20191015 AND 20191015
and a.productNo_key = b.productNo_key
and a.productNo_key = h.productNo_key
and a.customerNo_key = c.customerNo_key
and a.billingKind_key = d.billingKind_key
and a.termsOfPayment = e.termsOfPayment
and a.date_key = f.date_key
and a.hGlobalAdvertisingMaterial_key = g.globalAdvertisingMaterial_key
and a.globalPc_key = i.globalPc_key
and i.companyCode_key = '0581'


