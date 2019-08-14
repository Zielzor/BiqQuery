SELECT 
a. productNo_key,
b. productNo,
a. distributionChannel,
a. salesPrice,
a. timestamp

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` as a
Left JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` as b
on a. productNo_key = b. productNo_key
WHERE a. salesOrg_key = '5810'
and  a. _PARTITIONTIME < "2019-01-01"
and productNo = 101860
