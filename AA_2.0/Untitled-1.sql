CREATE OR REPLACE TABLE `ceeregion-prod.aa_baza_klientow.building_technology_CZ` as 
SELECT 
customerNo,
name1,
firstName
name3,
dateCreation,
phoneNo1,
phoneNo2,
eMailAddress,
salesOrg

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` 
WHERE salesOrg = "5850"
and name1 like "%instalační%"  or name1 like "%instalace%" or name1 like "%developer%" or name1 like "%development%" or name1 like "%stavby%" 
or name1 like "%stavební%" or name1 like "%architekt%" or name1 like "%architektonický%" or name1 like "%opravy%" or name1 like "%realizace%" 
or name1 like "%stavitel%" or name1 like "%budova%" or name1 like "%konstrukce%" or name1 like "%rekonstrukce%" or name1 like "%rekonstrukční%" or name1 like "%dům%"
or name1 like "%byt%" or name1 like "%stavbař%" or name1 like "%stavět%" or name1 like "%zakládat%" or name1 like "%postavit%" or name1 like "%postavit%" or name1 like "%bourat%" 
or name1 like "%demolice%" or name1 like "%staveniště%" or name1 like "%výstavba%" or name1 like "%stavební projekt%"


AND salesOrg = "5850"
ORDER BY dateCreation DESC;

---------------------------------------------
CREATE OR REPLACE TABLE `ceeregion-prod.aa_baza_klientow.building_technology_SK` as 
SELECT 
customerNo,
name1,
firstName
name3,
dateCreation,
phoneNo1,
phoneNo2,
eMailAddress,
salesOrg

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` 
WHERE salesOrg = "5800"
and name1 like "%inštalačný%"  or name1 like "%inštalácia%" or name1 like "%developér%" or name1 like "%development%" or name1 like "%stavby%" 
or name1 like "%stavebný%" or name1 like "%architekt%" or name1 like "%architektonický%" or name1 like "%opravy%" or name1 like "%realizácia%" 
or name1 like "%staviteľ%" or name1 like "%budova%" or name1 like "%konštrukcia%" or name1 like "%rekonštrukcia%" or name1 like "%dom%" or name1 like "%byt%"
or name1 like "%stavbár%" or name1 like "%stavať%" or name1 like "%založiť%" or name1 like "%postaviť%" or name1 like "%zbúrať%" or name1 like "%demolácia%" or name1 like "%výstavba%" 
or name1 like "%stavebný projekt%" or name1 like "%stavenisko%" 


AND salesOrg = "5800"
ORDER BY dateCreation DESC;

-------------- Nowa Wersja
CREATE OR REPLACE TABLE `ceeregion-prod.aa_baza_klientow.building_technology_CZ` as 
SELECT 
customerNo,
name1,
firstName
name3,
dateCreation,
dateLastOrder,
phoneNo1,
phoneNo2,
eMailAddress,
salesOrg

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` 
WHERE salesOrg = "5850"
and name1 like "%instalační%"  or name1 like "%instalace%" or name1 like "%developer%" or name1 like "%development%" or name1 like "%stavby%" 
or name1 like "%stavební%" or name1 like "%architekt%" or name1 like "%architektonický%" or name1 like "%opravy%" or name1 like "%realizace%" 
or name1 like "%stavitel%" or name1 like "%budova%" or name1 like "%konstrukce%" or name1 like "%rekonstrukce%" or name1 like "%rekonstrukční%" or name1 like "%dům%"
or name1 like "%byt%" or name1 like "%stavbař%" or name1 like "%stavět%" or name1 like "%zakládat%" or name1 like "%postavit%" or name1 like "%postavit%" or name1 like "%bourat%" 
or name1 like "%demolice%" or name1 like "%staveniště%" or name1 like "%výstavba%" or name1 like "%stavební projekt%"


AND salesOrg = "5850"
ORDER BY dateCreation DESC;
----
CREATE OR REPLACE TABLE `ceeregion-prod.aa_baza_klientow.building_technology_CZ` as 
SELECT *
FROM `ceeregion-prod.aa_baza_klientow.building_technology_CZ`
WHERE alesOrg = "5850"
