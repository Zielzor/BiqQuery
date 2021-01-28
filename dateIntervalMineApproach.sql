CREATE OR REPLACE TABLE `ceeregion-prod.FactKursWymiany.PreviusDateDatekey` as
SELECT 
curr_key,
date_key,
CAST(date_key as INT64) - 1 as DatePreviusDay,
rate


FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` 
WHERE curr_key = "PLN"
AND version_key = "ISJA20060201"
ORDER BY date_key DESC;

CREATE OR REPLACE TABLE `ceeregion-prod.FactKursWymiany.PreviusDateDatekey` as 
SELECT
b.date,
a.curr_key,
a.date_key,
a.DatePreviusDay,
a.rate

FROM `ceeregion-prod.FactKursWymiany.PreviusDateDatekey` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` as b on a.date_key = b.date_key 
ORDER BY date_key DESC
----------------------
SELECT 
Data, 
Month, 
a.Day, 
a.Quarter_of_year, 
a.Profit_Center, 
a.B2B_B2C, 
a.Channels, 
a.Conditions, 
a.Wykon_NNT_EUR, 
a.Daily_Distribution_NNT_EUR, 
a.Wykon_NNT_PL, 
a.Daily_Distribution_NNT_PLN, 
a.Wykon_CM1_Euro, 
a.Daily_Distribution_CM1_EUR, 
a.Wykon_CM1_PLN, 
a.Daily_Distribution_CM1_PLN

FROM `ceeregion-prod.Wykon.Wykonanie_dzienne_2020` as a
LEFT JOIN `ceeregion-prod.FactKursWymiany.PreviusDateDatekey as b` on  a.Data = b.date