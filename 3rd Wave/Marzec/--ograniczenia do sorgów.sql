--ograniczenia do sorgów
CREATE OR REPLACE TABLE `ceeregion-prod.AA_Szpitale.hospitals_CZ` as 
SELECT 
salesOrg, 
customerNo,
name1,
firstName
name3,
dateCreation,

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer`
WHERE salesOrg  = "5850";
--- filtr po słowach 
CREATE OR REPLACE TABLE `ceeregion-prod.AA_Szpitale.hospitals_CZ` as 
SELECT *
FROM `ceeregion-prod.AA_Szpitale.hospitals_CZ` 

WHERE name1 like "%lékař%"  or name1 like "%sestra%" or name1 like "%ordinace%" or name1 like "%nemocnice%"  or name1 like "%klinika%" or name1 like "%rehabilitační%"  or name1 like "%medicína%"
or name1 like "%fyzioterapie%" or name1 like "%léčebna%" or name1 like "%nemocný%" or name1 like "%nemocní%" or name1 like "%poliklinika%" or name1 like "%zdravotnické%"  or name1 like "%zdravotník%" 
or name1 like "%lékařský dům%"  or name1 like "%ambulance%"  or name1 like "%pohotovost%" 

ORDER BY dateCreation DESC
#CZ
#lékař, sestra, zdravotní, ordinace, nemocnice, klinika, rehabilitační, medicína, fyzioterapie, léčebna, nemocný, nemocní, poliklinika, zdravotnické, zdravotník, lékařský dům, ambulance, pohotovost 