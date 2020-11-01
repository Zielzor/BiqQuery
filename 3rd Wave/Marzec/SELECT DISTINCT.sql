SELECT DISTINCT
fiscalYear as FiscalYear,
_2_Profit_Center as ProfitCenter,
_4_Sales_District as SalesDistrcit, 
Name_Sales_District as NameSalesDistrict,
_3_Customer_Groups as CustomerGroups,
_7_Customer_No as CustomerNo,
_43_Customer_Name_1 as NAME,
_44_Customer_Name_2 AS NAME2,
_39_NNT_PLN as NNT_PLN 
FROM `ceeregion-prod.AA_Tabela_Testowa.aa_sales2019_pl` 

WHERE _39_NNT_PLN >= 1000