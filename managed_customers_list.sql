SELECT
    a.customerNo_key,
    a.timestamp as DATA,
    a.customerNo as Customer_no,
    CONCAT(a.name1," ",a.firstName," ",a.name3)  as Company,
    b.termsOfPaymentDescEng as Forma_Platnosci,
    b.paymentMethodDescEng as Rodzaj_Platnosci,
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
    a.vendorGrp_key,
    a.district_key,
    a.taxNo1,
    a.discountFull

FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer`as a,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimPaymentCondition.DimPaymentCondition` as b

WHERE b.termsOfPayment = a.paymentTerm 

and a.salesOrg ='5810' 
and a.salesDistrict <> ''  

ORDER BY a.customerNo_key
