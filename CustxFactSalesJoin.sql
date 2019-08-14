SELECT
a. customerNo_key,
CONCAT(a. firstName, " ", a. name1)
  AS full_name,
b. productNo_key,
b. termsOfPayment,
b. invoiceDate,
b. distributionChannel,
b. invoiceNo,
b. incotermOrder,
b. incotermCustomer,
b. quantitySales,
b. catalogPriceGross,
b. catalogPriceNet,
b. customerDiscount,
b. timestampSAP,
b. userName,
b. vv020 as COGS,
b. nnt,
b. cm1


FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as a 
JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as b
ON a.customerNo_key = b.customerNo_key
WHERE DATE(_PARTITIONTIME) BETWEEN "2019-01-01" and "2019-07-22"  
and a.salesOrg = '5810' 
and b.invoiceDate BETWEEN  "2019-01-01" and "2019-07-22" 
ORDER BY b.invoiceDate DESC