Select DISTINCT
a. TAG_ID
a. KAUFN_ID as "Order_No"
b. KUNDENNUMMER_KEY as "COMPANY_ID"
b. RBELN_ID as "INVOICE_NO"

a. NAME1
a. NAME2
a. NAME3
a. NAME4 
a. PLZ as "Kod Pocztowy"
a. ORT as "MIEJSCOWOSC"
from
COBIS_DWH.V_F_AUFTRAG_ABWEICHENDER_WE_PL  a
COBIS_DWH.V_F_VERKAUF_PL b
where a. KAUFN_ID=b. KAUFN_ID   and VKORG='5810' and a.TAG_ID>=20190101

----------------------------------------
SELECT DISTINCT

a.date_key,
a.orderNo_key,
a.customerNo_key,
b.invoiceNo,
a.name1,
a.name2,
a.name3,
a.name4,
a.zipCode,
a.city

FROM
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactOrderDifferentRecipient.FactOrderDifferentRecipien` as a,
`conrad-cbdp-prod-core:de_conrad_dwh1000_dwh_FactSalesBudget.FactSalesBudget` as b 

WHERE a.partitionDate BETWEEN  "2019-01-01"  and "2019-12-31"
and a.orderNo_key = b.orderNo_key
and a.salesOrg = "5810"
