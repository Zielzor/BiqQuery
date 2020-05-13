#Łukasz, mam prośbę... Potrzebuję do całej aktywnej oferty DE dodać
#DE
#1) cenę zakupu
#2) ilość zakupu
#3) cenę sprzedaży netto
#4) zysk
#11:00
#całej aktynwej oferty de ?
#o kurwa
#Sebastian, 11:00
#5) Marżę
---PL
#6) cenę sprzedaży PL netto
#7)zysk pl
#8) marżę
#jeśli jest cena PL to oczywiście znaczy że produkt jest u nad
#nas*
#jak nie ma to znaczy, że nie jest dodany/nie możemy dodać
#Dzisiaj jestem do 12:00 więc jutro będe truł tyłek o to
#9) matklass
#10) brand 
---------------------------------------------------------------------------------------------

--- tabela z ofertą DE
SELECT DISTINCT
a.productNo, 
b.productDesc,
b.salesPrice as Sprzedaż_DE,
a.purPriceAverage AS Zakup_DE
b.unitSalesPrice,
b.priceUnit, 
b.salesUnit,
b.flagPriceControl,
a.productDescEng,  
a.statusCrossSite , -- in COBIS_DWH D_ARTIKEL.mstae
a.statusCrossDistrChain , -- in COBIS_DWH D_ARTIKEL.mstav
a.statusDistriChainSpecific, -- in COBIS_DWH D_ARTIKEL.vmsta
b.salesOrg_key

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` a
INNER JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductSalesOrg.DimProductSalesOrg` b
  ON a.productNo_key=b.productNo_key

WHERE b.salesOrg_key="1000"
AND b.statusWebshop ='C'

ORDER BY b.productNo_key
--------------------- Tabela z oferta PL 


