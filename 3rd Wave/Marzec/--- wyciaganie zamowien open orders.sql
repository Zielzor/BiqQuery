--- wyciaganie zamowien
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_1` as 
SELECT 
a.date_key,
a.orderNo_key,
a.orderNo,
a.customerNo_key,
a.salesOrg,
a.valueNet,
a.valueSalesGross,
a.vat 

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactOrderHead.FactOrderHead`  as a

WHERE a.partitionDate > "2020-01-01"
and date_key > 20200101
#AND orderNo = '1080014056'
AND salesOrg = "5810"
AND flagActive = '1';
--- dowiazanie numerów produktów
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_2` as 
SELECT 
a.*,
productNo_key,
matClass_key,
posNo,
priceNet,
b.valueNet as valueNet_2,
salesUnit,
orderQty
 
FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_part_1`  as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactOrderPos.FactOrderPos` as b on a.orderNo_key = b.orderNo_key

WHERE b.partitionDate > "2020-01-01"
and b.date_key > 20200101
AND flagActive = '1';
--- dowiązanie danych o produktach
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_3` as
SELECT 
a.*,
b.productDescEng,
b.brandManufactorer,
b.productNo,
b.productNo_key as productNo_key2

FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_part_2` as  a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as b on a.productNo_key = b.productNo_key;
--- dowiazanie kategorii i hedd grup
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_4` as
SELECT   
a.*,
b.maingrpDescEng as Kategoria,
b.categoryDescEng as HeadGroup

FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_part_3` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as b  on a.productNo_key = b.productNo_key

where b.flagActive = 1;
--- dodanie daty
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_5` as
SELECT 
b.date,
a.*

FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_part_4` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b on a.date_key = b.date_key;
--- finał
CREATE OR REPLACE TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_PL` as 
SELECT
date as Date,
orderNo as OrderNo,
customerNo_key  as CustomerNo,
salesOrg,
productNo as Product_ID,
productDescEng,
brandManufactorer as Brand,
matClass_key as MATKL,
Kategoria,
HeadGroup,
valueNet,
priceNet,
valueSalesGross,
vat,
salesUnit,
orderQty


FROM `ceeregion-prod.AA_OpenOrders.OpenOrders_part_5` as a
ORDER BY date DESC;

DROP TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_1`;
DROP TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_2`;
DROP TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_3`;
DROP TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_4`;
DROP TABLE `ceeregion-prod.AA_OpenOrders.OpenOrders_part_5`;