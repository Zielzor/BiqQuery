--- dowiązanie sales district names
---PL
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_klientow_zarzadzanyc` as 
SELECT
a.customerNo_key, 
a.DATA, 
a.dateCreation, 
a.Customer_no, 
a.name1, 
a.firstName, 
a.Pierwsze_Zamowienie, 
a.Ostatnie_Zamowienie, 
a.Forma_Platnosci, 
a.Rodzaj_Platnosci, 
a.sellerGrp_key, 
a.Limit_Kredytowy, 
a.ulica, 
a.isoCountryCode, 
a.region, 
a.adressNo, 
a.EMAIL, 
a.profitCenter, 
a.Kod_Pocztowy, 
a.Miejscowosc, 
a.telexNo, 
a.phoneNo1, 
a.phoneNo2, 
a.Poczta, 
a.BLOKADA, 
a.salesDistrict,
b.KamName as  salesDistrictName,
a.vendorGrp_key, 
a.district_key, 
a.taxNo1, 
a.discountFull    
FROM
    `ceeregion-prod.Klienci_Zarzadzani.Lista_klientow_zarzadzanych` as a
LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST` as b on a.salesDistrict = b.SalesDistrict
ORDER BY a.DATA DESC; 
-----SK
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5800_SK` as 
SELECT
a.customerNo_key, 
a.DATA, 
a.Customer_no, 
a.name1, 
a.firstName, 
a.Pierwsze_Zamowienie, 
a.Ostatnie_Zamowienie, 
a.Forma_Platnosci, 
a.Rodzaj_Platnosci, 
a.sellerGrp_key, 
a.Limit_Kredytowy, 
a.ulica, 
a.isoCountryCode, 
a.region, 
a.adressNo, 
a.EMAIL, 
a.profitCenter, 
a.Kod_Pocztowy, 
a.Miejscowosc, 
a.telexNo, 
a.phoneNo1, 
a.phoneNo2, 
a.Poczta, 
a.BLOKADA, 
a.salesDistrict,
b.KamName as  salesDistrictName,
a.vendorGrp_key, 
a.district_key, 
a.taxNo1, 
a.discountFull    
FROM
    `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5800_SK` as a
LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST` as b on a.salesDistrict = b.SalesDistrict
ORDER BY a.DATA DESC;
----CZ
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5850_CZ` as 
SELECT
a.customerNo_key, 
a.DATA, 
a.Customer_no, 
a.name1, 
a.firstName, 
a.Pierwsze_Zamowienie, 
a.Ostatnie_Zamowienie, 
a.Forma_Platnosci, 
a.Rodzaj_Platnosci, 
a.sellerGrp_key, 
a.Limit_Kredytowy, 
a.ulica, 
a.isoCountryCode, 
a.region, 
a.adressNo, 
a.EMAIL, 
a.profitCenter, 
a.Kod_Pocztowy, 
a.Miejscowosc, 
a.telexNo, 
a.phoneNo1, 
a.phoneNo2, 
a.Poczta, 
a.BLOKADA, 
a.salesDistrict,
b.KamName as  salesDistrictName,
a.vendorGrp_key, 
a.district_key, 
a.taxNo1, 
a.discountFull    
FROM
    `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5850_CZ` as a
LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST` as b on a.salesDistrict = b.SalesDistrict
ORDER BY a.DATA DESC;
---SLO
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5900_SLO` as 
SELECT
a.customerNo_key, 
a.DATA, 
a.Customer_no, 
a.name1, 
a.firstName, 
a.Pierwsze_Zamowienie, 
a.Ostatnie_Zamowienie, 
a.Forma_Platnosci, 
a.Rodzaj_Platnosci, 
a.sellerGrp_key, 
a.Limit_Kredytowy, 
a.ulica, 
a.isoCountryCode, 
a.region, 
a.adressNo, 
a.EMAIL, 
a.profitCenter, 
a.Kod_Pocztowy, 
a.Miejscowosc, 
a.telexNo, 
a.phoneNo1, 
a.phoneNo2, 
a.Poczta, 
a.BLOKADA, 
a.salesDistrict,
b.KamName as  salesDistrictName,
a.vendorGrp_key, 
a.district_key, 
a.taxNo1, 
a.discountFull    
FROM
    `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5900_SLO` as a
LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST` as b on a.salesDistrict = b.SalesDistrict
ORDER BY a.DATA DESC;
---HR
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5910_HR` as 
SELECT
a.customerNo_key, 
a.DATA, 
a.Customer_no, 
a.name1, 
a.firstName, 
a.Pierwsze_Zamowienie, 
a.Ostatnie_Zamowienie, 
a.Forma_Platnosci, 
a.Rodzaj_Platnosci, 
a.sellerGrp_key, 
a.Limit_Kredytowy, 
a.ulica, 
a.isoCountryCode, 
a.region, 
a.adressNo, 
a.EMAIL, 
a.profitCenter, 
a.Kod_Pocztowy, 
a.Miejscowosc, 
a.telexNo, 
a.phoneNo1, 
a.phoneNo2, 
a.Poczta, 
a.BLOKADA, 
a.salesDistrict,
b.KamName as  salesDistrictName,
a.vendorGrp_key, 
a.district_key, 
a.taxNo1, 
a.discountFull    
FROM
    `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5910_HR` as a
LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST` as b on a.salesDistrict = b.SalesDistrict
ORDER BY a.DATA DESC;
---HU
CREATE OR REPLACE TABLE `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5950_HU` as 
SELECT
a.customerNo_key, 
a.DATA, 
a.Customer_no, 
a.name1, 
a.firstName, 
a.Pierwsze_Zamowienie, 
a.Ostatnie_Zamowienie, 
a.Forma_Platnosci, 
a.Rodzaj_Platnosci, 
a.sellerGrp_key, 
a.Limit_Kredytowy, 
a.ulica, 
a.isoCountryCode, 
a.region, 
a.adressNo, 
a.EMAIL, 
a.profitCenter, 
a.Kod_Pocztowy, 
a.Miejscowosc, 
a.telexNo, 
a.phoneNo1, 
a.phoneNo2, 
a.Poczta, 
a.BLOKADA, 
a.salesDistrict,
b.KamName as  salesDistrictName,
a.vendorGrp_key, 
a.district_key, 
a.taxNo1, 
a.discountFull    
FROM
    `ceeregion-prod.Klienci_Zarzadzani.Lista_Klientow_Zarzadzanych_5950_HU` as a
LEFT JOIN `ceeregion-prod.Tab_Sales_District_2020_EAST.Tab_Sales_District_2020_EAST` as b on a.salesDistrict = b.SalesDistrict
ORDER BY a.DATA DESC;