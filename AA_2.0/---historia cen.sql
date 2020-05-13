----wyciągniecie id dla PL
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Sales_Price_History.Products_ID` as 
SELECT
productNo_key, 
Product_ID
FROM `ceeregion-prod.PriceFile.PriceFile_PL`;
---- dowiązanie do historii 
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Sales_Price_History.History` as 
SELECT
a.Product_ID,
b.dateValidFrom_key, 
b.dateValidTo_key,
b.salesPrice,
b.qtyScaled1, 	
b.salesPriceScaled1, 	
b.salesPriceScaled2, 	
b.qtyScaled2, 	
b.qtyScaled3, 	
b.salesPriceScaled3,
b.qtyScaled4, 	
b.salesPriceScaled4,
b.qtyScaled5, 	
b.salesPriceScaled5, 	
b.qtyScaled6, 	
b.salesPriceScaled6,
b.unitSalesPrice

FROM `ceeregion-prod.CEPL_Sales_Price_History.Products_ID` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_HistProductSalesOrg.HistProductSalesOrg` as b on a.productNo_key = b.productNo_key

WHERE salesOrg_key = '5810'
AND dateValidFrom_key > 20200101;
-----------poprawienie dat
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Sales_Price_History.Prodct_Price_HistoryPL1` as 
SELECT
a.Product_ID,
b.date as dateValidFrom_key, 
a.dateValidTo_key,
a.salesPrice,
a.qtyScaled1, 	
a.salesPriceScaled1, 	
a.salesPriceScaled2, 	
a.qtyScaled2, 	
a.qtyScaled3, 	
a.salesPriceScaled3,
a.qtyScaled4, 	
a.salesPriceScaled4,
a.qtyScaled5, 	
a.salesPriceScaled5, 	
a.qtyScaled6, 	
a.salesPriceScaled6,
a.unitSalesPrice

FROM `ceeregion-prod.CEPL_Sales_Price_History.History` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b ON a.dateValidFrom_key = b.date_key;
---------poprawienie dat2
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Sales_Price_History.Prodct_Price_HistoryPL2` as 
SELECT
a.Product_ID,
a.dateValidFrom_key, 
b.date as dateValidTo_key,
a.salesPrice,
a.qtyScaled1, 	
a.salesPriceScaled1, 	
a.salesPriceScaled2, 	
a.qtyScaled2, 	
a.qtyScaled3, 	
a.salesPriceScaled3,
a.qtyScaled4, 	
a.salesPriceScaled4,
a.qtyScaled5, 	
a.salesPriceScaled5, 	
a.qtyScaled6, 	
a.salesPriceScaled6,
a.unitSalesPrice

FROM `ceeregion-prod.CEPL_Sales_Price_History.Prodct_Price_HistoryPL1` as a 
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b ON a.dateValidTo_key = b.date_key;
-------dowiazanie pelnej listy 
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Sales_Price_History.Prodct_Price_HistoryPL_Final` as
SELECT 
a.Product_ID as Wsad_ID,
b.*
FROM `ceeregion-prod.CEPL_Sales_Price_History.Wsad_HISTORY_ID` as a
LEFT JOIN `ceeregion-prod.CEPL_Sales_Price_History.Prodct_Price_HistoryPL2` as b on a.Product_ID = b.Product_ID;

---drop śmietnika
DROP TABLE `ceeregion-prod.CEPL_Sales_Price_History.History`;
DROP TABLE `ceeregion-prod.CEPL_Sales_Price_History.Prodct_Price_HistoryPL1`;
DROP TABLE `ceeregion-prod.CEPL_Sales_Price_History.Prodct_Price_HistoryPL2`;
#DROP TABLE `ceeregion-prod.CEPL_Sales_Price_History.Products_ID`;
----------------dołożenie daty sprzedaży
CREATE OR REPLACE TABLE `ceeregion-prod.CEPL_Sales_Price_History.DataZamowienia1` as 
SELECT 
a.productNo_key,
a.Product_ID,
b._1_Data  as Data_Zamowienia

FROM `ceeregion-prod.CEPL_Sales_Price_History.Products_ID` as a 
JOIN `ceeregion-prod.Dashboardy.Dashboard_PL_Sales_2020`  as b on a.productNo_key = b._16_Article_ID;
-----------------
CREATE OR REPLACE TABLE  `ceeregion-prod.CEPL_Sales_Price_History.DataZamowienia2` as
SELECT
a.Product_ID,
b.Date as Data_sprzedazy

FROM `ceeregion-prod.CEPL_Sales_Price_History.DataZamowienia1` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b ON a.Data_Zamowienia = b.date_key;


