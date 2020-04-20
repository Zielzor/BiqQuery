CREATE OR REPLACE TABLE `ceeregion-prod.Inne.KlienciOczekujacy1` as 
SELECT  
a.Numer_klienta,
b.street,
b.zipCode,
b.city,
CASE
WHEN b.profitCenter = "51230" THEN "B2C"
WHEN b.profitCenter = "51232" THEN "B2B"
END as B2B_B2C,
b.profitCenter,
eMailAddress
FROM `ceeregion-prod.AA_Tabela_Testowa.ListaKlientowOczekujacych_Marzec`  as a
      LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as b on a.Numer_klienta  = b.customerNo

ORDER BY Numer_klienta DESC;
--------------
CREATE OR REPLACE TABLE `ceeregion-prod.Inne.KlienciOczekujacy2` as 
SELECT
a.*,
b.dateCreation DESC,
b.phoneNo as NumerOsobyKontaktowej,
b.eMailAddress as MailOsobyKontaktowej



FROM `ceeregion-prod.Inne.KlienciOczekujacy1` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimContactPerson.DimContactPerson` as b on a.Numer_klienta = b.customerNo;
----------------------
CREATE OR REPLACE TABLE `ceeregion-prod.Inne.KlienciOczekujacy3` as 
SELECT  
a.*,
b.customerShippingLastname,
b.customerShippingFirstname,
b.customerShippingCompany,
b.customerShippingStreet1,
b.customerShippingCity,
b.customerShippingAdditionalInfo

FROM `ceeregion-prod.Inne.KlienciOczekujacy2` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactOrderHeadMkp.FactOrderHeadMkp` as b on a.dateCreation DESC = b.dateCreation DESC;