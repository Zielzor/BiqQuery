SELECT 
a.productNo_key,
a.dateValidFrom_10,
a.datevalidTo_10,
a.purPriceAverage_10,
a.priceUnit_10,
a.salesPrice_10,
a.unitSalesPrice_10,
b.dateValidFrom_11, 
b.datevalidTo_11, 
b.purPriceAverage_11, 
b.priceUnit_11, 
b.salesPrice_11, 
b.unitSalesPrice_11,
ROUND(((purPriceAverage_11 - purPriceAverage_10 )/ purPriceAverage_10),3) as DiffPercentageInPurPrice


FROM `ceeregion-prod.DimPLPurPriceHistory.step3` as a
LEFT JOIN `ceeregion-prod.DimPLPurPriceHistory.step4` as b on a.productNo_key = b.productNo_key
WHERE purPriceAverage_10 !=0
AND purPriceAverage_11 !=0