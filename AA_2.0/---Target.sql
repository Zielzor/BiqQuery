---sprzedaz dzienna
CREATE OR REPLACE TABLE `ceeregion-prod.Target.Target_Daily_2020` as 
SELECT 
CAST(b.date as DATE) as Data,
a._2_Profit_Center as Profit_Center , 
a._3_Customer_Groups as Channels, 
a._13_Quarter_of_year as Quarter_of_year, 
a._14_Month as Month, 
a._15_Day as Day,
SUM(a._50_Conditions) as _50_Conditions,
SUM(a._35_NNT_EURO) as NNT_EURO, 
SUM(a._37_CM1_EURO) as CM1_EURO, 
SUM(a._39_NNT_PLN) as NNT_PLN, 
SUM(a._40_CM1_PLN) as CM1_PLN 

 FROM `ceeregion-prod.Dashboardy.Dashboard_PL_Sales_2020` as a,
      `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b
WHERE a._1_Data = b.date_key

GROUP BY CAST(b.date as DATE),
a._2_Profit_Center,
a._3_Customer_Groups,
a._13_Quarter_of_year,
a._14_Month,
a._15_Day,
a._50_Conditions

ORDER BY CAST(b.date as DATE)
ASC;

---dowizanie budzetu i wykonania
CREATE OR REPLACE TABLE `ceeregion-prod.Wykon.Wykonanie_dzienne_2020` as
SELECT 
cast(a.Data as DATE) as Data,
a.Month,
a.Day,
a.Quarter_of_year, 
a.Profit_Center,
CASE
WHEN a.Profit_Center = 51232 THEN  "B2B"
WHEN a.Profit_Center = 51230 THEN  "B2C"
END as B2B_B2C,
a.Channels,
sum(round(a._50_Conditions, 2 )) as Conditions,
sum(round(a.NNT_EURO, 2)) as Wykon_NNT_EUR,
round(b.NNT__EUR_, 2) as Daily_Distribution_NNT_EUR,
sum(round(a.NNT_PLN, 2)) as Wykon_NNT_PL,
round(b.NNT__PLN_, 2) as Daily_Distribution_NNT_PLN,
sum(round(a.CM1_EURO, 2)) as Wykon_CM1_Euro,
round(b.CM1__EUR_, 2) as Daily_Distribution_CM1_EUR,
sum(round(a.CM1_PLN, 2)) as Wykon_CM1_PLN,
round(b.CM1__PLN_, 2) as Daily_Distribution_CM1_PLN

FROM `ceeregion-prod.Target.Target_Daily_2020` as a
    LEFT JOIN   `ceeregion-prod.Tab_dane_Daily_Distribution_CEPL.Target_Daily_Distribution_2020` as b ON a.Channels = b.Channel
      
WHERE cast(a.Data as DATE) = cast( b.Date as DATE)
AND a.Profit_Center = b.PROFITCENTER
and a.Channels = b.Channel 
#AND cast(a.Data as DATE) = "2020-02-29"

GROUP BY 
a.Data,
a.Month,
a.Day,
a.Quarter_of_year,
a.Profit_Center,
a.Channels,
b.NNT__EUR_,
b.NNT__PLN_,
b.CM1__EUR_,
b.CM1__PLN_ 


Order by a.Data
ASC

