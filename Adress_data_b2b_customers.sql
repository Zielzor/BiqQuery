SELECT
a.customerNo_key,
a.timestamp as DATA,
a.customerNo as Customer_no,
CONCAT(a.name1," ",a.firstName," ",a.name3) as Company,#czemu kurwy nie działacie  tak jak chce?
CONCAT(a.name1," ",a.name3," ",a.name4) as Company_2, #czemu kurwy nie działacie  tak jak chce?
a.paymentTerm as Forma_Platnosci,
a.sellerGrp_key,
a.creditLimit as Limit_Kredytowy,
a.street as ulica,
a.isoCountryCode,
a.region,
a.adressNo,
a.eMailAddress as EMAIL,
a.profitCenter,
a.zipCode as Kod_Pocztowy,
a.city as Miejscowosc,
a.telexNo,
a.phoneNo1,
a.phoneNo2,
a.district as Poczta,
a.deliveryBlock as BLOKADA,
a.salesDistrict,
a.taxNo1,
a.discountFull as RABAT_STALY


FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as a

WHERE a.salesOrg='5810'  
and a.profitCenter='51232'

ORDER BY a.customerNo_key
