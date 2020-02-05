SELECT 
a.date_key as _1_Data,
f.profitCenter as _2_Profit_Center,
NULL as _3_,
NULL as _4_,
NULL as _5_,
a.orderNo as _6_Order_No,
NULL as _7_,
h.insert_key as _8_Insert_DE,
a.orderType_key as _9_PO_Type, 
b.quarter as _10_Quarter_of_year,
b.monthNum as _11_Month,
b.dayOfMonth as _12_Day,
NULL as _13_,
NULL as _14_,
NULL as _15_,
a.invoiceNo as _16_Invoice_no,
a.productNo_key  as _17_Article_No,
NULL as _18_,
NULL as _19_,
NULL as _20_,
a.billingKind_key as _21_Document_type,
NULL as _22_,
NULL as _23_,
NULL as _24_,
NULL as _25_,
NULL as _26_,
NULL as _27_,
NULL as _28_,
NULL as _29_,
NULL as _30_,
NULL as _31_,
a.nnt as _32_NNT_EURO,
NULL as _33_,
a.cm1 as _34_CM1_EURO,
NULL as _35_,
(a.nnt / c.rate) as _36_NNT_NAT_CURRENCY,
(a.cm1 / c.rate) as  _37_CM1_NAT_CURRENCY,
NULL as _38_,
a.userName as _39_User_Name,
NULL as _40_,
NULL as _41_,
NULL as _42_,
NULL as _43_,
NULL as _44_,
NULL as _45_,
NULL as _46_,
NULL as _47_,
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
and e.salesOrg_key='5850'
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
and c.curr_key = "CZK"
and a.date_key = c.date_key 
and a.date_key = b.date_key 
and c.version_key = "ISJA20060201"
---reszta 
and orderNo = "9999999998"

ORDER BY a.date_key ASC
