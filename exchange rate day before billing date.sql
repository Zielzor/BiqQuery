-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- \big data\sql\lokal\zielinski lukasz\exchange rate day before billing date\exchange rate day before billing date.sql
--
-- 
-- Output: `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_12`
--
-- 2020-11-04
--
-- Important:
-- Change table name praefixes "ceeregion-prod.AA_LZielinski." first
-- 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- Create table with all dates needed for the script
--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_5` AS
SELECT 
-- country definitions OR 0, '', 'EUR'	
	countryData.country_id,
	countryData.countryCode,
	countryData.salesOrg_key,
	countryData.localCurrency,
-- date sale figures
	DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH) AS dateFrom, 	-- CAST('2018-01-01' AS DATE) AS dateFrom,
	DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS dateTo, 		-- CAST('2020-04-30' AS DATE) AS dateTo,
--
-- group date by
	--'YEAR' AS dateGroup,
	--'MONTH' AS dateGroup,
	--'WEEK' AS dateGroup,
	--'DAY' AS dateGroup,
	'' AS dateGroup,
--
-- table with datas is partitioned by dateType or not			-- here `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactInvoiceHead.FactInvoiceHead` -> monthly date partitioned
	--'YEAR' AS tableDatePartitiontypeId,
	'MONTH' AS tableDatePartitiontypeId,
	--'DAY' AS tableDatePartitiontypeId,
	--'' AS tableDatePartitiontypeId,
	-- date handling absolute
	1 AS dateHandlingAbsolute,		 							-- e.g. YEAR-> Date range=2020-01-01 - 2020-12-31
	--0 AS dateHandlingAbsolute,	 							-- e.g. YEAR-> dateTo=2020-08-01 Date range=2019-08-01 - 2020-07-31
--
-- currency rate of day(s) before in days
	1 currencyDateCountSubDays,
-- budget Type 
	'IS' AS budgetType_key
FROM 
( 
	SELECT countryItem.updateDate,
		IF( countryItem.country_id IS NULL, 	0,		countryItem.country_id ) 	AS country_id,
		IF( countryItem.countryCode IS NULL,   	'',		countryItem.countryCode ) 	AS countryCode,
		IF( countryItem.salesOrg_key IS NULL,	'',		countryItem.salesOrg_key ) 	AS salesOrg_key,
		IF( countryItem.localCurrency IS NULL, 	'EUR',	countryItem.localCurrency ) AS localCurrency
	FROM 
	(
		-- set up your country code, salesOrg_key AND local currency
		SELECT CURRENT_DATE() AS UpdateDate, 
		NULL AS country_id,
		'PL' AS countryCode,
		'5810' AS salesOrg_key,
		'PLN' AS localCurrency
	) AS countryItem
) AS countryData;

-- Poland
--		'PL' AS countryCode,
--		'5810' AS salesOrg_key,
--		'PLN' AS localCurrency

-- Switzerland
--		'CH' AS countryCode,
--		'5300' AS salesOrg_key,
--		'CHF' AS localCurrency

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- get Date ranges, table date Partition infos
--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- sales figures
CREATE OR REPLACE TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_daterange` AS SELECT ROW_NUMBER() OVER() dateId, daterange.dateFrom, daterange.dateTo, daterange.dateFrom_key, daterange.dateTo_key, daterange.dateFromPartition, daterange.dateToPartition FROM ( SELECT a.dateGroup, a.tableDatePartitionTypeId, daterangeraw.dateFrom, daterangeraw.dateTo, MIN(c.date_key) AS dateFrom_key, MIN(d.date_key) AS dateTo_key, CASE a.tableDatePartitionTypeId WHEN 'YEAR' THEN DATE_TRUNC(daterangeraw.dateFrom, YEAR) WHEN 'MONTH' THEN DATE_TRUNC(daterangeraw.dateFrom, MONTH) WHEN 'DAY' THEN DATE_TRUNC(daterangeraw.dateFrom, DAY) ELSE NULL END AS dateFromPartition, CASE a.tableDatePartitionTypeId WHEN 'YEAR' THEN DATE_TRUNC(daterangeraw.dateTo, YEAR) WHEN 'MONTH' THEN DATE_TRUNC(daterangeraw.dateTo, MONTH) WHEN 'DAY' THEN DATE_TRUNC(daterangeraw.dateTo, DAY) ELSE NULL END AS dateToPartition FROM ( SELECT srctbl.dateFrom AS dateFrom, srctbl.dateTo AS dateTo, srctbl.dateGroup AS dateGroup, srctbl.dateHandlingAbsolute AS dateHandlingAbsolute, srctbl.tableDatePartitionTypeId AS tableDatePartitionTypeId FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_5` AS srctbl ) a, `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` c, `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` d, ( SELECT IF( a.dateHandlingAbsolute=1, datesabsolute.dateFrom, datesrelative.dateFrom	) AS dateFrom, IF( a.dateHandlingAbsolute=1, datesabsolute.dateTo, datesrelative.dateTo	) AS dateTo FROM ( SELECT srctbl.dateFrom AS dateFrom, srctbl.dateTo AS dateTo, srctbl.dateGroup AS dateGroup, srctbl.dateHandlingAbsolute AS dateHandlingAbsolute, srctbl.tableDatePartitionTypeId AS tableDatePartitionTypeId FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_5` AS srctbl ) a LEFT JOIN ( SELECT CASE a.dateGroup WHEN 'YEAR' THEN CASE DATE_TRUNC(b.date, YEAR)<a.dateFrom WHEN true THEN a.dateFrom ELSE DATE_TRUNC(b.date, YEAR) END WHEN 'MONTH' THEN CASE DATE_TRUNC(b.date, MONTH)<a.dateFrom WHEN true THEN a.dateFrom ELSE DATE_TRUNC(b.date, MONTH) END WHEN 'WEEK'	THEN CASE DATE_TRUNC(b.date, WEEK)<a.dateFrom WHEN true THEN a.dateFrom ELSE DATE_TRUNC(b.date, WEEK) END WHEN 'DAY' THEN CASE b.date<a.dateFrom WHEN true THEN a.dateFrom ELSE b.date END ELSE a.dateFrom END AS dateFrom, CASE a.dateGroup WHEN 'YEAR' THEN CASE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 YEAR), YEAR), INTERVAL 1 DAY)>a.dateTo WHEN true THEN a.dateTo ELSE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 YEAR), YEAR), INTERVAL 1 DAY) END WHEN 'MONTH' THEN CASE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY)>a.dateTo WHEN true THEN a.dateTo ELSE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY) END WHEN 'WEEK' THEN CASE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 WEEK), WEEK), INTERVAL 1 DAY)>a.dateTo WHEN true THEN a.dateTo ELSE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 WEEK), WEEK), INTERVAL 1 DAY) END WHEN 'DAY' THEN CASE b.date>a.dateTo WHEN true THEN a.dateTo ELSE b.date END ELSE a.dateTo END AS dateTo FROM ( SELECT srctbl.dateFrom AS dateFrom, srctbl.dateTo AS dateTo, srctbl.dateGroup AS dateGroup, srctbl.dateHandlingAbsolute AS dateHandlingAbsolute, srctbl.tableDatePartitionTypeId AS tableDatePartitionTypeId FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_5` AS srctbl ) a, `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` b WHERE a.dateHandlingAbsolute=1 AND b.date BETWEEN a.dateFrom AND a.dateTo AND b.monthNum BETWEEN 1 AND 12 GROUP BY CASE a.dateGroup WHEN 'YEAR' THEN CASE DATE_TRUNC(b.date, YEAR)<a.dateFrom WHEN true THEN a.dateFrom ELSE DATE_TRUNC(b.date, YEAR) END  WHEN 'MONTH' THEN CASE DATE_TRUNC(b.date, MONTH)<a.dateFrom	WHEN true THEN a.dateFrom ELSE DATE_TRUNC(b.date, MONTH) END WHEN 'WEEK' THEN CASE DATE_TRUNC(b.date, WEEK)<a.dateFrom WHEN true THEN a.dateFrom	ELSE DATE_TRUNC(b.date, WEEK) END WHEN 'DAY' THEN CASE b.date<a.dateFrom WHEN true THEN a.dateFrom ELSE b.date END ELSE a.dateFrom END, CASE a.dateGroup WHEN 'YEAR' THEN CASE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 YEAR), YEAR), INTERVAL 1 DAY)>a.dateTo WHEN true THEN a.dateTo ELSE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 YEAR), YEAR), INTERVAL 1 DAY) END WHEN 'MONTH' THEN CASE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY)>a.dateTo WHEN true THEN a.dateTo ELSE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY) END WHEN 'WEEK' THEN CASE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 WEEK), WEEK), INTERVAL 1 DAY)>a.dateTo WHEN true THEN a.dateTo ELSE DATE_SUB( DATE_TRUNC( DATE_ADD(b.date, INTERVAL 1 WEEK), WEEK), INTERVAL 1 DAY)	END WHEN 'DAY' THEN CASE b.date>a.dateTo WHEN true THEN a.dateTo ELSE b.date END ELSE a.dateTo END ) AS datesabsolute ON 1=1 LEFT JOIN ( SELECT CASE a.dateGroup WHEN 'YEAR' THEN CASE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 YEAR), INTERVAL 1 DAY)<a.dateFrom WHEN true THEN a.dateFrom ELSE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 YEAR), INTERVAL 1 DAY) END WHEN 'MONTH' THEN CASE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 MONTH), INTERVAL 1 DAY)<a.dateFrom	WHEN true THEN a.dateFrom ELSE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 MONTH), INTERVAL 1 DAY) END WHEN 'WEEK' THEN CASE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 WEEK), INTERVAL 1 DAY)<a.dateFrom WHEN true THEN a.dateFrom ELSE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 WEEK), INTERVAL 1 DAY) END WHEN 'DAY' THEN CASE c.date<a.dateFrom WHEN true THEN a.dateFrom ELSE c.date END ELSE a.dateFrom END AS dateFrom, CASE c.date>a.dateTo WHEN true THEN a.dateTo ELSE c.date END AS dateTo FROM ( SELECT srctbl.dateFrom AS dateFrom, srctbl.dateTo AS dateTo, srctbl.dateGroup AS dateGroup, srctbl.dateHandlingAbsolute AS dateHandlingAbsolute, srctbl.tableDatePartitionTypeId AS tableDatePartitionTypeId FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_5` AS srctbl ) a, `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` c WHERE a.dateHandlingAbsolute<>1 AND c.date BETWEEN a.dateFrom AND a.dateTo AND c.monthNum BETWEEN 1 AND 12 AND ( ( a.dateGroup='YEAR' AND c.date=DATE_SUB(a.dateTo, INTERVAL (DATE_DIFF(a.dateTo, c.date, YEAR)) YEAR ) ) OR  ( a.dateGroup='MONTH' AND c.date=DATE_SUB(a.dateTo, INTERVAL (DATE_DIFF(a.dateTo, c.date, MONTH)) MONTH ) ) OR  ( a.dateGroup='WEEK' AND c.date=DATE_SUB(a.dateTo, INTERVAL (DATE_DIFF(a.dateTo, c.date, WEEK)) WEEK ) ) OR  ( a.dateGroup='DAY' ) OR  ( a.dateGroup='' AND c.date=a.dateTo ) ) GROUP BY CASE a.dateGroup WHEN 'YEAR' THEN CASE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 YEAR), INTERVAL 1 DAY)<a.dateFrom WHEN true THEN a.dateFrom	ELSE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 YEAR), INTERVAL 1 DAY) END WHEN 'MONTH' THEN CASE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 MONTH), INTERVAL 1 DAY)<a.dateFrom	WHEN true THEN a.dateFrom ELSE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 MONTH), INTERVAL 1 DAY) END WHEN 'WEEK' THEN CASE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 WEEK), INTERVAL 1 DAY)<a.dateFrom WHEN true THEN a.dateFrom	ELSE DATE_ADD( DATE_SUB(c.date, INTERVAL 1 WEEK), INTERVAL 1 DAY) END WHEN 'DAY' THEN CASE c.date<a.dateFrom WHEN true THEN a.dateFrom ELSE c.date END ELSE a.dateFrom END, CASE c.date>a.dateTo WHEN true THEN a.dateTo ELSE c.date END ) AS datesrelative ON 1=1 ) AS daterangeraw WHERE daterangeraw.dateFrom=c.date AND daterangeraw.dateTo=d.date GROUP BY a.dateGroup, a.tableDatePartitionTypeId, daterangeraw.dateFrom, daterangeraw.dateTo, CASE a.tableDatePartitionTypeId WHEN 'YEAR' THEN DATE_TRUNC(daterangeraw.dateFrom, YEAR) WHEN 'MONTH' THEN DATE_TRUNC(daterangeraw.dateFrom, MONTH) WHEN 'DAY' THEN DATE_TRUNC(daterangeraw.dateFrom, DAY) ELSE NULL END, CASE a.tableDatePartitionTypeId WHEN 'YEAR' THEN DATE_TRUNC(daterangeraw.dateTo, YEAR) WHEN 'MONTH' THEN DATE_TRUNC(daterangeraw.dateTo, MONTH) WHEN 'DAY' THEN DATE_TRUNC(daterangeraw.dateTo, DAY) ELSE NULL END ORDER BY daterangeraw.dateFrom DESC ) AS daterange ORDER BY daterange.dateFrom DESC;



-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- sales Figures Head
--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_10` AS
SELECT daterange1.dateId,
	e1.salesOrg AS salesOrg_key,
	a1.customerNo_key,
	IF( a1.contactPersonNo IS NULL, 0, SAFE_CAST(a1.contactPersonNo AS INT64) ) contactPersonNo,
	a1.customerNoRecipient_key,
	IF( a1.contactPersonRecipient IS NULL, 0, SAFE_CAST(a1.contactPersonRecipient AS INT64) ) contactPersonRecipient,
	c1.date AS billingDate,
	-- calculate currency rate date
	DATE_SUB(c1.date, INTERVAL d1.currencyDateCountSubDays DAY) currencyRateDate,
	a1.orderNo_key,
	a1.invoiceNo_key,
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), 0, 1) flagOrder,
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), 1, 0) flagReturn,
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.valueInvoice*(-1), a1.valueInvoice ) AS valueInvoice, -- RECHNUNGSBETRAG
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), (a1.valueInvoice-a1.shippingCosts-a1.valueWarranty)*(-1), (a1.valueInvoice-a1.shippingCosts-a1.valueWarranty) ) AS valueSalesGrossBill, -- RECHNUNGSBETRAG-Porto-Garantie
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.valuePur*(-1), a1.valuePur ) AS valuePur, -- EINKAUFSWERT
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), (a1.valueInvoice-a1.vat-a1.valueWarranty-a1.shippingCosts-a1.insurance)*(-1), (a1.valueInvoice-a1.vat-a1.valueWarranty-a1.shippingCosts-a1.insurance) ) AS valueNNT,
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), (a1.valueInvoice-a1.vat-a1.valueWarranty-a1.shippingCosts-a1.insurance-a1.valuePur)*(-1), (a1.valueInvoice-a1.vat-a1.valueWarranty-a1.shippingCosts-a1.insurance-a1.valuePur) ) AS valueDBI,
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.vat*(-1), a1.vat ) AS vat, -- MWSTBETRAG
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.valueDiscount*(-1), a1.valueDiscount ) AS valueDiscount, -- RABATTWERT
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.vatShareDiscount*(-1), a1.vatShareDiscount ) AS vatShareDiscount, -- RAB_MWSTBETRAG
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.valueWarranty*(-1), a1.valueWarranty ) AS valueWarranty, -- BETRAG_GARANTIE
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.revenuesOther*(-1), a1.revenuesOther ) AS revenuesOther, -- SONST_ERLOESE
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.shippingCosts*(-1), a1.shippingCosts ) AS shippingCosts, -- VERSANDKOSTEN
	IF( a1.billingKind_Key IN ('S1', 'YGF', 'RE', 'G2', 'IVS', 'ZZF2', 'LRS', 'LGS', 'LG', 'ZPLR'), a1.insurance*(-1), a1.insurance ) AS insurance
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactInvoiceHead.FactInvoiceHead` a1,
	`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` c1, -- date information billing date
	`ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_5` d1,
	`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` e1,
	`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` g1,	
	`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimBillingType.DimBillingType` h1,
	`ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_daterange` AS daterange1
WHERE ( (daterange1.dateFromPartition IS NOT NULL AND a1.partitionDate BETWEEN daterange1.dateFromPartition AND daterange1.dateToPartition) OR (daterange1.dateFromPartition IS NULL) )
	AND a1.date_key BETWEEN daterange1.dateFrom_key AND daterange1.dateTo_key
	AND a1.date_key=c1.date_key
	AND a1.customerNo_key=e1.customerNo_key
	AND a1.version_key=g1.version_key
	AND a1.billingKind_key=h1.billingKind_key
	AND d1.budgetType_key=g1.budgetType_key
	--- no salesOrg_key defined OR customer in defined salesOrg
	AND ( (d1.salesOrg_key='') OR (d1.salesOrg_key<>'' AND d1.salesOrg_key=e1.salesOrg) )
	AND h1.flagChargeInternally IS NULL;



-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- sales Figures Head with local currency and currency rate of calculated date
--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_11` AS
SELECT raw.dateId,
	raw.salesOrg_key,
	raw.customerNo_key,
	raw.contactPersonNo,
	raw.customerNoRecipient_key,
	raw.contactPersonRecipient,
	raw.billingDate,
	raw.currencyRateDate,
	mindate_key.date_key currencyRateDate_key,
	d2.dateGroup,
	raw.orderNo_key,
	raw.invoiceNo_key,
	raw.flagOrder,
	raw.flagReturn,
	-- local currency values
	i2.curr_key,
	ROUND( (raw.valueInvoice/i2.rate), 2 ) AS valueInvoiceLC,
	ROUND( (raw.valueSalesGrossBill/i2.rate), 2 ) AS valueSalesGrossBillLC,
	ROUND( (raw.valuePur/i2.rate), 2 ) AS valuePurLC,
	ROUND( (raw.valueNNT/i2.rate), 2 ) AS valueNNTLC,
	ROUND( (raw.valueDBI/i2.rate), 2 ) AS valueDBILC,
	ROUND( (raw.vat/i2.rate), 2 ) AS vatLC,
	ROUND( (raw.valueDiscount/i2.rate), 2 ) AS valueDiscountLC,
	ROUND( (raw.vatShareDiscount/i2.rate), 2 ) AS vatShareDiscountLC,
	ROUND( (raw.valueWarranty/i2.rate), 2 ) AS valueWarrantyLC,
	ROUND( (raw.revenuesOther/i2.rate), 2 ) AS revenuesOtherLC,
	ROUND( (raw.shippingCosts/i2.rate), 2 ) AS shippingCostsLC,
	ROUND( (raw.insurance/i2.rate), 2 ) insuranceLC,
	-- values in EUR
	raw.valueInvoice,
	raw.valueSalesGrossBill,
	raw.valuePur,
	raw.valueNNT,
	raw.valueDBI,
	raw.vat,
	raw.valueDiscount,
	raw.vatShareDiscount,
	raw.valueWarranty,
	raw.revenuesOther,
	raw.shippingCosts,
	raw.insurance
FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_10` raw,
	( 
		SELECT q1.orderNo_key, q1.invoiceNo_key, MIN(q2.date) qdate, MIN(q2.date_key) date_key
		FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_10` q1,
			`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCalendar.DimCalendar` q2
		WHERE q1.currencyRateDate=q2.date
		GROUP BY q1.orderNo_key, q1.invoiceNo_key
	) mindate_key,
	`ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_5` d2,
	`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimVersion.DimVersion` g2,
	`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactExchangeRate.FactExchangeRate` i2
WHERE mindate_key.orderNo_key=raw.orderNo_key
	AND mindate_key.invoiceNo_key=raw.invoiceNo_key
	AND mindate_key.date_key=i2.date_key
	AND d2.budgetType_key=g2.budgetType_key
	AND d2.localCurrency=i2.curr_key
	AND g2.version_key=i2.version_key;
 



-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- sales Figures Head group by date range
--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_12` AS
SELECT a.dateId, 
	a.dateFrom dateRangeFrom, 
	a.dateTo dateRangeTo,
	b.dateGroup,
	b.salesOrg_key,
	COUNT(DISTINCT b.orderNo_key) countOrderNo_key,
	COUNT(DISTINCT b.invoiceNo_key) countInvoiceNo_key,
	SUM(b.flagOrder) countOrder,
	SUM(b.flagReturn) countReturn,
	b.curr_key,
	ROUND( SUM(b.valueInvoiceLC), 2) valueInvoiceLC,
	ROUND( SUM(b.valueSalesGrossBillLC), 2) valueSalesGrossBillLC,
	ROUND( SUM(b.valuePurLC), 2) valuePurLC,
	ROUND( SUM(b.valueNNTLC), 2) valueNNTLC,
	ROUND( SUM(b.valueDBILC), 2) valueDBILC,
	ROUND( SUM(b.vatLC), 2) vatLC,
	ROUND( SUM(b.valueDiscountLC), 2) valueDiscountLC,
	ROUND( SUM(b.vatShareDiscountLC), 2) vatShareDiscountLC,
	ROUND( SUM(b.valueWarrantyLC), 2) valueWarrantyLC,
	ROUND( SUM(b.revenuesOtherLC), 2) revenuesOtherLC,
	ROUND( SUM(b.shippingCostsLC), 2) shippingCostsLC,
	ROUND( SUM(b.insuranceLC), 2) insuranceLC,
	ROUND( SUM(b.valueInvoice), 2) valueInvoice,
	ROUND( SUM(b.valueSalesGrossBill), 2) valueSalesGrossBill,
	ROUND( SUM(b.valuePur), 2) valuePur,
	ROUND( SUM(b.valueNNT), 2) valueNNT,
	ROUND( SUM(b.valueDBI), 2) valueDBI,
	ROUND( SUM(b.vat), 2) vat,
	ROUND( SUM(b.valueDiscount), 2) valueDiscount,
	ROUND( SUM(b.vatShareDiscount), 2) vatShareDiscount,
	ROUND( SUM(b.valueWarranty), 2) valueWarranty,
	ROUND( SUM(b.revenuesOther), 2) revenuesOther,
	ROUND( SUM(b.shippingCosts), 2) shippingCosts,
	ROUND( SUM(b.insurance), 2) insurance
FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_daterange` a,
	`ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_11` b
WHERE a.dateId=b.dateId
GROUP BY a.dateId, 
	a.dateFrom, 
	a.dateTo,
	b.dateGroup,
	b.salesOrg_key,
	b.curr_key;




-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- Show result
--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
stop;

-- date table
SELECT * 
FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_daterange`;

-- result table with calculated currency rate date
SELECT * 
FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_11`;

-- summary values per date group
SELECT * 
FROM `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_12` 
ORDER BY dateId;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- Drop unneeded tables
--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
stop;

DROP TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_5`;
DROP TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_10`;
DROP TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_11`;
DROP TABLE `ceeregion-prod.AA_LZielinski.zz_examplefactinvoicehead_12`;