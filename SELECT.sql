SELECT 
Week, 
_1_Data,
_2_Profit_Center,
_3_Customer_Groups,
CASE
WHEN _9_Group_Insert_1 IN("00","62") THEN "1.ONLINE"
WHEN _4_Sales_District IN("5800","5801","5802","5806","5823") and _9_Group_Insert_1 NOT IN("00","62")  THEN "2.KAM TEAM" 
WHEN _4_Sales_District NOT IN("5800","5801","5802","5806","5823") AND Name_Sales_District  IS NOT null THEN "3.SALES TEAM"
WHEN _9_Group_Insert_1 = "95" THEN "4.MARKETPLACE"
-- WHEN c.salesDistrict != "5800" or c.salesDistrict != "5801" or c.salesDistrict != "5802" or c.salesDistrict != "5806" or c.salesDistrict != "5823" or c.salesDistrict is not null  THEN "3.SALES TEAM" 
-- WHEN j.Grupa_Insert_1 ="95" THEN "4.MARKETPLACE"
-- WHEN j.Grupa_Insert_1 = "00" or j.Grupa_Insert_1 = "62" THEN "1.ONLINE"
-- WHEN  c.salesDistrict is null THEN "3.SALES TEAM"
END as SalesChannels,

_4_Sales_District, Name_Sales_District, sellerGrp_key, _5_Customer_information, _6_Order_No, _7_Customer_No, _8_Insert_DE, _9_Group_Insert_1, _10_Group_Insert_2, _11_Grupa_Insert_3, _12_PO_Type, _13_Quarter_of_year, _14_Month, _15_Day, _16_Article_ID, _17_Conrad_External, _18_ABSMG_Sales_Quantity, _19_Invoice_no, _20_Article_No, _21_Order_Pos, _22_Brand, _23_MATKL, _24_Document_type, _25_Document_Name, _26_PaymentMethod, _27_Article_Name, _28_Catalog_Price_Net_EUR0, _29_Price_Reduction_EURO, _30_Staggered_discount _31_Customer_Discount_EURO, _32_Reduction, _33_Customer_full_Discount, _34_Increments, _35_NNT_EURO, _36_COGS_EURO, _37_CM1_EURO, _38_Catalog_revenues_EURO, _39_NNT_PLN, _40_CM1_PLN, _41_Calc_Discount_EURO, _42_User_Name, _43_Customer_Name_1, _44_Customer_Name_2, _45_Customer_Name_3, _46_Customer_Name_4, _47_Head_Group, _48_Categorie, _49_category_key, _50_Conditions, _51_Costs, Managed_As 


FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_PL` 



--Pola utworzeone poprzez wyrażenia warunkowe
CASE
WHEN c.salesDistrict = "5800"  or c.salesDistrict = "5801" or c.salesDistrict = "5802" or c.salesDistrict = "5806" or c.salesDistrict = "5823"  THEN "2.KAM TEAM"  
-- WHEN c.salesDistrict != "5800" or c.salesDistrict != "5801" or c.salesDistrict != "5802" or c.salesDistrict != "5806" or c.salesDistrict != "5823" or c.salesDistrict is not null  THEN "3.SALES TEAM" 
WHEN j.Grupa_Insert_1 ="95" THEN "4.MARKETPLACE"
WHEN j.Grupa_Insert_1 = "00" or j.Grupa_Insert_1 = "62" THEN "1.ONLINE"
WHEN  c.salesDistrict is null THEN "3.SALES TEAM"
ELSE  "3.SALES TEAM"
END as _3_Customer_Groups,
---koniec wartości warunkowej