CREATE OR REPLACE TABLE `ceeregion-prod.V_PODSTAWOWE_KPI_CEPL.5810_PODSTAWOWE_KPI_CEPL` as 
SELECT 
a.Week,
a._3_Customer_Groups as Csutomer_Groups,
CASE 
WHEN _2_Profit_Center = 51232 THEN "B2B"
WHEN _2_Profit_Center = 51230 THEN "B2C"
END AS B2B_B2C,
SUM(_35_NNT_EURO) as NNT_EUR,
SUM(_37_CM1_EURO) as CM1_EUR,
COUNT(CASE WHEN Managed_As = "DMC" THEN 1 else null END )AS Count_DMC_Customers,
COUNT(CASE WHEN Managed_As = "PMC" THEN 1 else null  END) AS Count_PMC_Customers,
COUNT(DISTINCT _7_Customer_No) as Count_Unique_Customers,
COUNT(DISTINCT _6_Order_No) as Count_Unique_Orders

FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_PL`  as a

GROUP BY a.Week, a._3_Customer_Groups, a._2_Profit_Center
ORDER BY a.Week, _3_Customer_Groups DESC