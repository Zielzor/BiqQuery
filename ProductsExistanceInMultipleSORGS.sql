-- define interest sales Org
CREATE OR REPLACE TABLE `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist1` AS
SELECT salesOrg_key,
salesOrgDescEng
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimSalesOrg.DimSalesOrg`
WHERE salesOrg_key IN UNNEST(['5900', '5810', '5950']);  -- 5900 Slovenia, 5810 Poland, 5950 Hungary-
-- main article information
CREATE OR REPLACE TABLE `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist2` AS
SELECT productNo_key,
productDescEng
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct`
WHERE productNo<>0; -- only valid numbers (e.g. exclude productNo_key='02-166_4P1_4P0')
-- get article list from countries
CREATE OR REPLACE TABLE `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist3` AS
SELECT a.salesOrg_key,
b.productNo_key,
'X' productExist
FROM `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist1` a, -- list of salesOrg_keys
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` b -- article list sales Org
WHERE a.salesOrg_key=b.salesOrg_key;
-- generate result list
-- 5900 Slovenia, 5810 Poland, 5950 Hungary
CREATE OR REPLACE TABLE `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist` AS
SELECT a.productNo_key,
a.productDescEng,
b.productExist AS PL,
c.productExist AS SI,
d.productExist AS HU
FROM `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist2` a
-- enum each country
-- poland
LEFT JOIN `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist3` b ON a.productNo_key=b.productNo_key AND b.salesOrg_key='5810'
-- Slovenia
LEFT JOIN `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist3` c ON a.productNo_key=c.productNo_key AND c.salesOrg_key='5900'
-- Hungary
LEFT JOIN `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist3` d ON a.productNo_key=d.productNo_key AND d.salesOrg_key='5950';

-- output results
--stop;

-- count records
SELECT COUNT(*) countRecords FROM `ceeregion-prod.aa_lista_mailingowa_id_east.articlecountrieslist`;

-- datas
SELECT * FROM `ceeregion-prod.aa_lista_mailingowa_id_east.articlecountrieslist`;
-- drop unneeded tables
DROP TABLE `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist1`;
DROP TABLE `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist2`;
DROP TABLE `ceeregion-prod.aa_lista_mailingowa_id_east.zz_articlecountrieslist3`;
DROP TABLE `ceeregion-prod.aa_lista_mailingowa_id_east.articlecountrieslist`; 