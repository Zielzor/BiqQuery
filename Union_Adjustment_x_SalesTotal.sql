SELECT *

FROM
  `ceeregion-prod.Tab_Sales_CEPL_2019.Sales_Total` as a

UNION ALL

SELECT
b._1_Data,
b._2_Profit_Center,
NULL as _3_Puste,
NULL as _4_Puste,
NULL as _5_Puste,
b._6_Order_No,
b._8_Insert_DE,
b._9_Group_Insert_1,
b._10_Group_Insert_2,
b._11_Grupa_Insert_3,
b._12_PO_Type,
b._13_Quarter_of_year,
b._14_Month,
b._15_Day,
NULL as _16_Puste,
NULL as _17_Puste,
NULL as _18_Puste,
b._19_Invoice_no,
b._20_Article_No,
NULL as _22_Puste,
NULL as _23_Puste,
b._25_Document_type,
NULL as _25_Puste,
NULL as _26_Puste,
NULL as _27_Puste,
NULL as _28_Puste,
NULL as _29_Puste,
NULL as _30_Puste,
NULL as _31_Puste,
NULL as _32_Puste,
NULL as _33_Puste,
NULL as _34_Puste,
NULL as _35_Puste, 
b._36_NNT_EURO,
NULL as _37_Puste,
b._38_CM1_EURO
NULL as _39_Puste
b._40_NNT_PLN,
b._41_CM1_PLN,
NULL as _42_Puste
b._43_User_Name,
NULL as _44_Puste
NULL as _45_Puste
NULL as _46_Puste
NULL as _47_Puste
NULL as _48_Puste
NULL as _49_Puste
NULL as _50_Puste
NULL as _51_Puste
b._52_Costs
NULL as _53_Puste
FROM
  `ceeregion-prod.Adjustmets.Adjustments_PL` as b