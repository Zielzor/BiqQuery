--- lista dla pl
CREATE OR REPLACE TABLE `ceeregion-prod.Adresy_klientow_B2B.Klienci_b2b_adresy` as 
SELECT 
a.dateCreation DESC,
a.timestamp as DATA,
a.dateCreation, 
a.customerNo as Customer_no,
a.name1,
a.firstName,
a.name3,
a.name4, 
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
and a.profitCenter= '51232'

ORDER BY  a.dateCreation DESC;
------lista  slovakia 
CREATE OR REPLACE TABLE `ceeregion-prod.Adresy_klientow_B2B.Klienci_b2b_adresy_SK` as 
SELECT 
a.dateCreation DESC,
a.timestamp as DATA,
a.dateCreation, 
a.customerNo as Customer_no,
a.name1,
a.firstName,
a.name3,
a.name4, 
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

WHERE a.salesOrg='5800'  
and a.profitCenter= '51232'

ORDER BY  a.dateCreation DESC;

--- lista czechy
CREATE OR REPLACE TABLE `ceeregion-prod.Adresy_klientow_B2B.Klienci_b2b_adresy_CZK` as 
SELECT 
a.dateCreation DESC,
a.timestamp as DATA,
a.dateCreation, 
a.customerNo as Customer_no,
a.name1,
a.firstName,
a.name3,
a.name4, 
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

WHERE a.salesOrg='5850'  
and a.profitCenter= '51232'

ORDER BY  a.dateCreation DESC;

--- lista Slovenia 
CREATE OR REPLACE TABLE `ceeregion-prod.Adresy_klientow_B2B.Klienci_b2b_adresy_SI` as 
SELECT 
a.dateCreation DESC,
a.timestamp as DATA,
a.dateCreation, 
a.customerNo as Customer_no,
a.name1,
a.firstName,
a.name3,
a.name4, 
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

WHERE a.salesOrg='5900'  
and a.profitCenter= '51232'

ORDER BY  a.dateCreation DESC;
----------lista Croatia 
CREATE OR REPLACE TABLE `ceeregion-prod.Adresy_klientow_B2B.Klienci_b2b_adresy_HR` as 
SELECT 
a.dateCreation DESC,
a.timestamp as DATA,
a.dateCreation, 
a.customerNo as Customer_no,
a.name1,
a.firstName,
a.name3,
a.name4, 
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

WHERE a.salesOrg='5910'  
and a.profitCenter= '51232'

ORDER BY  a.dateCreation DESC;

---Lista hungary 
CREATE OR REPLACE TABLE `ceeregion-prod.Adresy_klientow_B2B.Klienci_b2b_adresy_HU` as 
SELECT 
a.dateCreation DESC,
a.timestamp as DATA,
a.dateCreation, 
a.customerNo as Customer_no,
a.name1,
a.firstName,
a.name3,
a.name4, 
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

WHERE a.salesOrg='5950'  
and a.profitCenter= '51232'

ORDER BY  a.dateCreation DESC