SELECT DISTINCT
a.date_key,
a.orderNo,
a.orderNo_key,
a.customerNo_key,
b.contactPerson_key,
b.customerNo_key,
b.customerNo,
b.contactPerson_key,
b.lastName,
b.firstName,
b.phoneNo,
b.eMailAddress,
c.street,
c.zipCode,
c.city

FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as a,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimContactPerson.DimContactPerson` as b,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactOrderDifferentRecipient.FactOrderDifferentRecipient` as c

WHERE a.contactPersonNo = b.contactPerson_key 
and  c.customerNo_key = a.customerNo_key  
and c.salesOrg='5810' 
and a.date_key= 20191010