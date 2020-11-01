---- lista pl 
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_klientow_zarzadzanych` as 
SELECT
    a.customerNo_key,
    a.dateCreation as DATA,
    a.customerNo as Customer_no, 
    a.name1, 
    a.firstName,
    a.dateFirstOrder as Pierwsze_Zamowienie,
    a.dateLastOrder as Ostatnie_Zamowienie,
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

WHERE  b.termsOfPayment = a.paymentTerm 
and a.salesOrg ='5810' 
and a.salesDistrict <> ''  


ORDER BY a.dateCreation DESC;
--- lista slovakia
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5800_SK` as 
SELECT
    a.customerNo_key,
    a.dateCreation as DATA,
    a.customerNo as Customer_no, 
    a.name1, 
    a.firstName,
    a.dateFirstOrder as Pierwsze_Zamowienie,
    a.dateLastOrder as Ostatnie_Zamowienie,
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

WHERE  b.termsOfPayment = a.paymentTerm 
and a.salesOrg ='5800' 
and a.salesDistrict <> ''  


ORDER BY a.dateCreation DESC;

--- lista czechia
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5850_CZ` as 
SELECT
    a.customerNo_key,
    a.dateCreation as DATA,
    a.customerNo as Customer_no, 
    a.name1, 
    a.firstName,
    a.dateFirstOrder as Pierwsze_Zamowienie,
    a.dateLastOrder as Ostatnie_Zamowienie,
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

WHERE  b.termsOfPayment = a.paymentTerm 
and a.salesOrg ='5850' 
and a.salesDistrict <> ''  


ORDER BY a.dateCreation DESC;

----  lista slovenia 
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5900_SLO` AS 
SELECT
    a.customerNo_key,
    a.dateCreation as DATA,
    a.customerNo as Customer_no, 
    a.name1, 
    a.firstName,
    a.dateFirstOrder as Pierwsze_Zamowienie,
    a.dateLastOrder as Ostatnie_Zamowienie,
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

WHERE  b.termsOfPayment = a.paymentTerm 
and a.salesOrg ='5900' 
and a.salesDistrict <> ''  


ORDER BY a.dateCreation DESC;

--- lista HR
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5910_HR` as  
SELECT
    a.customerNo_key,
    a.dateCreation as DATA,
    a.customerNo as Customer_no, 
    a.name1, 
    a.firstName,
    a.dateFirstOrder as Pierwsze_Zamowienie,
    a.dateLastOrder as Ostatnie_Zamowienie,
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

WHERE  b.termsOfPayment = a.paymentTerm 
and a.salesOrg ='5910' 
and a.salesDistrict <> ''  


ORDER BY a.dateCreation DESC;

--- lista hungary
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5950_HU` as  
SELECT
    a.customerNo_key,
    a.dateCreation as DATA,
    a.customerNo as Customer_no, 
    a.name1, 
    a.firstName,
    a.dateFirstOrder as Pierwsze_Zamowienie,
    a.dateLastOrder as Ostatnie_Zamowienie,
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

WHERE  b.termsOfPayment = a.paymentTerm 
and a.salesOrg ='5950' 
and a.salesDistrict <> ''  


ORDER BY a.dateCreation DESC