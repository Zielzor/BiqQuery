SELECT
    a.date_key,
    a.customerNo_key, 
    b.costCenterNo, 
    b.pcDescGer,
    b.pcDescEng,
    a.docNo,
    a.invoiceNo,
    sum(a.vv197)
FROM
   `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales` as a,
   `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProfitcenter.DimProfitcenter` as b,
   `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as c
WHERE date_key BETWEEN '20190601' AND '20190831'
and a.globalPc_key = b.globalPc_key
and b.companyCode_key = '0581'
and c.customerNo_key = a.customerNo_key
and vv197 <> '0'

GROUP BY a.date_key,b.costCenterNo,b.pcDescGer,b.pcDescEng,a.docNo,a.invoiceNo,a.customerNo_key
    