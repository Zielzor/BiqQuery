--- customers list containing SA and spzoo
CREATE OR REPLACE TABLE `ceeregion-prod.aa_klienci_rozwojowi.customer_saspzoo` AS
SELECT  DISTINCT
_1_Data as Data,
_2_Profit_Center as Profit_Center,
_3_Customer_Groups as Customer_Groups,
_6_Order_No  as Order_No,
_7_Customer_No as Customer_No, 
_8_Insert_DE as Insert_DE, 	
_9_Group_Insert_1 as Group_Insert_1, 	
_10_Group_Insert_2 as Group_Insert_2,	
_11_Grupa_Insert_3 as Grupa_Insert_3, 	
_12_PO_Type as PO_Type,
_19_Invoice_no as Invoice_no,
_35_NNT_EURO  as NNT_EUR,
_43_Customer_Name_1 as Customer_Name_1, 	
_44_Customer_Name_2 as Customer_Name_2, 	
_45_Customer_Name_3 as Customer_Name_3, 	
_46_Customer_Name_4 as Customer_Name_4 

FROM `ceeregion-prod.Dashboardy.Dashboard_PL_Sales_2020`  as a
WHERE _43_Customer_Name_1 like "%S.A.%"  or  _43_Customer_Name_1 like '%Sp. z o. o.%' or _43_Customer_Name_1 like "%s.a.%"  or  _43_Customer_Name_1 like '%sp. z o. o.%';
--- Filtering customers from online 
CREATE OR REPLACE TABLE `ceeregion-prod.aa_klienci_rozwojowi.customer_saspzoo` AS
SELECT  DISTINCT
Data,
Profit_Center,
Customer_Groups,
Order_No,
Customer_No, 
Insert_DE, 	
Group_Insert_1, 	
Group_Insert_2,	
Grupa_Insert_3, 	
PO_Type,
Invoice_no,
NNT_EUR,
Customer_Name_1, 	
Customer_Name_2, 	
Customer_Name_3, 	
Customer_Name_4 

FROM `ceeregion-prod.aa_klienci_rozwojowi.customer_saspzoo`  as a
WHERE Customer_Groups = "1.ONLINE";
--- Filtering customer creation date 
CREATE OR REPLACE TABLE `ceeregion-prod.aa_klienci_rozwojowi.customer_saspzoo` AS
SELECT DISTINCT c.date,
b.dateCreation,
a.* 

FROM `ceeregion-prod.aa_klienci_rozwojowi.customer_saspzoo` as a,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as b,
    `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as c

WHERE  a.Customer_No = b.customerNo_key 
AND a.Data = c.date_key
AND b.dateCreation >='2020-01-01'
ORDER BY c.date ASC;
--- Filtering customer by order value
CREATE OR REPLACE TABLE `ceeregion-prod.aa_klienci_rozwojowi.customer_saspzoo` AS
SELECT *

FROM `ceeregion-prod.aa_klienci_rozwojowi.customer_saspzoo` as a 

WHERE NNT_EUR > 100

ORDER BY dateCreation ASC 

