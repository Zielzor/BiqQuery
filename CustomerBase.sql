SELECT
a.customerNo,
CONCAT(a.firstName, " ", a.name1)
  AS full_name,
a.creator,
a.customerClass,
a.paymentTerm,
a.salesOffice,
a.originCustomer,
a.dateFirstOrder,
a.dateLastOrder,
a.profitCenter
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as a  
WHERE salesOrg = '5810' 
and DATE(_PARTITIONTIME) >= "2017-07-22" 

