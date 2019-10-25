SELECT a.productNo_key,
a.productDescEng,  
a.statusCrossSite statusCrossSiteDE, -- in COBIS_DWH D_ARTIKEL.mstae
a.statusCrossDistrChain statusCrossDistrChainDE, -- in COBIS_DWH D_ARTIKEL.mstav
a.statusDistriChainSpecific statusDistriChainSpecificDE, -- in COBIS_DWH D_ARTIKEL.vmsta
b.salesOrg_key,
  b.statusDistriChainSpecific statusDistriChainSpecificSalesOrg -- in COBIS_DWH D_ARTIKEL_VKORG.vmsta
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` a
INNER JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` b
  ON a.productNo_key=b.productNo_key
WHERE DATE(a._PARTITIONTIME) >= "2019-01-01"
AND b.salesOrg_key="5810"
AND a.statusCrossSite IN UNNEST(["07"])
AND b.statusDistriChainSpecific IS NOT NULL
ORDER BY a.productNo_key
LIMIT 1000