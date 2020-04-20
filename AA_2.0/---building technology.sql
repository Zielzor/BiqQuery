CREATE OR REPLACE TABLE `ceeregion-prod:aa_baza_klientow.building_technology_PL` as 
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
WHERE salesOrg = "5810"
and name1 like "%instalator%"  or name1 like "%zakład instalacyjny%" or name1 like "%firma instalatorska%" or name1 like "%zakład prefabrykacyjny%" or name1 like "%deweloper%" 
or name1 like "%developer%" or name1 like "%deweloperski%" or name1 like "%developerski%" or name1 like "%biuro projektowe%"

AND salesOrg = "5810"
ORDER BY dateCreation DESC;

#  instalatorzy (zakłady/ firmy instalacyjne), 
#prefabrykatorzy (zakłady prefabrykacyjne), 
#inwestorzy (firmy developerskie), 
#ntegratorzy. 
#Ewentualnie projektanci (biura projektowe), ale tutaj byłbym ostrożny.. 

--------------------------------------------------------------------------
CREATE OR REPLACE TABLE `ceeregion-prod.aa_baza_klientow.building_technology_PL` as 
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
WHERE salesOrg = "5810"
and name1 like "%instalator%"  or name1 like "%zakład instalacyjny%" or name1 like "%firma instalatorska%" or name1 like "%zakład prefabrykacyjny%" or name1 like "%deweloper%" 
or name1 like "%developer%" or name1 like "%deweloperski%" or name1 like "%developerski%" or name1 like "%biuro projektowe%"

AND salesOrg = "5810"
ORDER BY dateCreation DESC;
---------------------------------------------------------
CREATE OR REPLACE TABLE `ceeregion-prod.aa_baza_klientow.building_technology_PL` as 
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
WHERE salesOrg = "5810"
and name1 like "%instalator%"  or name1 like "%zakład instalacyjny%" or name1 like "%firma instalatorska%" or name1 like "%zakład prefabrykacyjny%" or name1 like "%deweloper%" 
or name1 like "%developer%" or name1 like "%deweloperski%" or name1 like "%developerski%" or name1 like "%biuro projektowe%"

AND salesOrg = "5810"
ORDER BY dateCreation DESC;
-----------------------------------------
#CREATE OR REPLACE TABLE `ceeregion-prod:aa_baza_klientow.building_technology_PL` as 
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
WHERE salesOrg = "5810"
and name1 like "%instalator%"  or name1 like "%zakład instalacyjny%" or name1 like "%firma instalatorska%" or name1 like "%zakład prefabrykacyjny%" or name1 like "%deweloper%" 
or name1 like "%developer%" or name1 like "%deweloperski%" or name1 like "%developerski%" or name1 like "%biuro projektowe%"

AND salesOrg = "5810"
ORDER BY dateCreation DESC;
-----------------------------------------------
#CREATE OR REPLACE TABLE `ceeregion-prod:aa_baza_klientow.building_technology_PL` as 
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
WHERE salesOrg = "5810"
and name1 like "%instalator%"  or name1 like "%zakład instalacyjny%" or name1 like "%firma instalatorska%" or name1 like "%zakład prefabrykacyjny%" or name1 like "%deweloper%" 
or name1 like "%developer%" or name1 like "%deweloperski%" or name1 like "%developerski%" or name1 like "%biuro projektowe%"

AND salesOrg = "5810"
ORDER BY dateCreation DESC;
----------------------------------
#CREATE OR REPLACE TABLE `ceeregion-prod:aa_baza_klientow.building_technology_PL` as 
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
WHERE salesOrg = "5810"
and name1 like "%instalator%"  or name1 like "%zakład instalacyjny%" or name1 like "%firma instalatorska%" or name1 like "%zakład prefabrykacyjny%" or name1 like "%deweloper%" 
or name1 like "%developer%" or name1 like "%deweloperski%" or name1 like "%developerski%" or name1 like "%biuro projektowe%"

AND salesOrg = "5810"
ORDER BY dateCreation DESC;
