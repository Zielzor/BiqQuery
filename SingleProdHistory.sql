SELECT 
a. productNo_key,
a. salesOrg_key,
a. salesPrice,
a. unitSalesPrice,
b. purPriceNetNet,
a. timestamp


FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a
RIGHT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as b
ON a. productNo_key = b. productNo_key
WHERE  salesOrg_key = '5810' 
and a._PARTITIONDATE > "2019-06-01"
and a. productNo_key = '000000000001681221'