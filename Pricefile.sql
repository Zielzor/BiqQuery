SELECT 
distinct( productNo_key ),
productDesc,
salesPrice as Sprzedaz_Brutto_PLN,
round((salesPrice / 1.23)) as Sprzedaz_Netto_PLN,
unitSalesPrice
priceUnit,
salesUnit,
productTaxClassification,
flagPriceControl
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` 
WHERE salesOrg_key='5810' 
AND  salesPrice>0 
AND statusWebshop ='C'
ORDER BY salesPrice  DESC