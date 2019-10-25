SELECT distinct
b.productNo_key,
b.productDesc,
b.salesPrice as Sprzedaz_Brutto_PLN,
round((b.salesPrice / 1.23)) as Sprzedaz_Netto_PLN,
b.unitSalesPrice,
b.priceUnit, 
b.salesUnit,
b.productTaxClassification,
b.flagPriceControl,
a.productDescEng,  
a.statusCrossSite , -- in COBIS_DWH D_ARTIKEL.mstae
a.statusCrossDistrChain , -- in COBIS_DWH D_ARTIKEL.mstav
a.statusDistriChainSpecific, -- in COBIS_DWH D_ARTIKEL.vmsta
b.salesOrg_key

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` a
INNER JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` b
  ON a.productNo_key=b.productNo_key

WHERE b.salesOrg_key="5810"
AND b.statusWebshop ='C'

ORDER BY b.productNo_key