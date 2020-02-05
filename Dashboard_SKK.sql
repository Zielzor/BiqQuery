SELECT *

FROM
  `ceeregion-prod.Sales_SKK_2020.Sales_SKK_2020` as a

UNION ALL

SELECT
b._1_Data,
b._2_Profit_Center,
NULL as _3_Puste,
NULL as _4_Puste,
Null as Name_SalesDistrict,
NULL as _5_Puste,
b._6_Order_No,
NULL as _7_Puste,
b._8_Insert_DE,
b._9_PO_Type,
b._10_Quarter_of_year,
b._11_Month,
b._12_Day,
NULL as _13_Puste,
NULL as _14_Puste,
NULL as _15_Puste,
b._16_Invoice_no,
b._17_Article_No,
NULL as _18_Puste,
NULL as _19_Puste,
NULL as _20_Puste,
b._21_Document_type,
NULL as _22_Puste,
NULL as _23_Puste,
NULL as _24_Puste,
NULL as _25_Puste,
NULL as _26_Puste,
NULL as _27_Puste,
NULL as _28_Puste,
NULL as _29_Puste,
NULL as _30_Puste,
NULL as _31_Puste, 
b._32_NNT_EURO,
NULL as _33_Puste,
b._34_CM1_EURO,
NULL AS CM1_Pole,
NULL AS CM1_Pole,
NULL as _35_Puste,
b._36_NNT_NAT_CURRENCY,
b._37_CM1_NAT_CURRENCY,
NULL as _38_Puste,
b._39_User_Name,
NULL as _40_Puste,
NULL as _41_Puste,
NULL as _42_Puste,
NULL as _43_Puste,
NULL as _44_Puste,
NULL as _45_Puste,
NULL as _46_Puste,
NULL as _47_Puste,
b._48_Costs

FROM
  `ceeregion-prod.Adjustmets.Adjustments_SKK` as b