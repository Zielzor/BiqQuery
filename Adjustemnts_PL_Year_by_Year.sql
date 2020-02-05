SELECT 
a.date_key as _1_Data,
f.profitCenter as _2_Profit_Center,
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

WHERE partitionDate BETWEEN  "2019-01-01"  and CURRENT_DATE()
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
and orderNo = "9999999998"

ORDER BY a.date_key ASC
