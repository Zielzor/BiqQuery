SELECT distinct
(b.productNo_key),
b.productDesc,
b.salesPrice as Sprzedaz_Brutto_PLN,
round((b.salesPrice / 1.23)) as Sprzedaz_Netto_PLN,
b.unitSalesPrice
b.priceUnit,
b.salesUnit,
b.productTaxClassification,
b.flagPriceControl,
a.productDescEng,  
a.statusCrossSite , -- in COBIS_DWH D_ARTIKEL.mstae
a.statusCrossDistrChain , -- in COBIS_DWH D_ARTIKEL.mstav
a.statusDistriChainSpecific, -- in COBIS_DWH D_ARTIKEL.vmsta
b.salesOrg_key,
b.statusDistriChainSpecific 
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` a
INNER JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` b
  ON a.productNo_key=b.productNo_key

WHERE DATE(a._PARTITIONTIME) >= "2019-01-01"

AND b.salesOrg_key="5810"
AND a.statusCrossSite IN UNNEST(["07"])
AND b.statusDistriChainSpecific IS NOT NULL
AND a.statusWebshop ='C'
ORDER BY a.productNo_key