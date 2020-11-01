DECLARE prevMonth, prevYear INT64;
SET prevMonth = EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH));
SET prevYear  = EXTRACT(YEAR  FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH));


-- Article Weights
CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.ce_rechnungsposition_sap` AS
SELECT 
	   customerNo_key,
	   salesOrg,
	   
	   orderNo_key,
	   invoiceNo_key,
	   PARSE_DATE("%Y%m%d",CAST(date_key AS STRING)) AS invoiceDate,
	   productNo_key,
	   statusDelivery_key,
	   
      
       CASE WHEN statusDelivery_key IN ('7','9','A','B','Y') THEN -1.0 * valueSalesGrossInLocalCurrency ELSE valueSalesGrossInLocalCurrency END AS sellingPrice,
       CASE WHEN statusDelivery_key IN ('7','9','A','B','Y') THEN -1.0 * vat                            ELSE vat                            END AS vat ,
       CASE WHEN statusDelivery_key IN ('7','9','A','B','Y') THEN -1.0 * qtyDelivered 
            WHEN statusDelivery_key IN ('2','3','4','5','8','D') THEN 1.0 * qtyDelivered
            ELSE 0 END AS shippedItems

FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactInvoicePos.FactInvoicePos`  
WHERE 
partitionDate = DATE(prevYear, prevMonth, 1) AND
salesOrg IN ("5800","5810","5850","5900", "5910", "5950") AND
invoiceNo_key > "9000000000"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticles` AS
SELECT a.*,
       b.productDescGer,
       c.matClass_key ,
       c.matClassDescGer ,

      CASE WHEN unitWeightProduct = "KG" THEN grossWeightProduct * 1000 ELSE grossWeightProduct END AS article_gross_weight,
      b.unitMeasurementProduct,
      b.lengthProduct,
      b.widthProduct,
      b.heightProduct,
      
      b.priceUnit,
      b.commodityCode
      
FROM `ci-test-182812.nagel_work.ce_rechnungsposition_sap` a, `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` b, `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimMaterialClass.DimMaterialClass` c
WHERE a.productNo_key = b.productNo_key AND b.matClass_key = c.matClass_key 
;



CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticleWeights` AS
SELECT a.orderNo_key,
       a.salesorg,
       b.invoiceNo_key,
       
       MAX(
       CASE WHEN b.transportType_key = "02" THEN 104
            WHEN b.transportType_key = "05" THEN 136
            WHEN b.transportType_key = "10" THEN 219
            WHEN b.transportType_key = "20" THEN 246
            WHEN b.transportType_key = "40" THEN 315
            WHEN b.transportType_key = "50" THEN 757
            WHEN b.transportType_key = "60" THEN 875
            WHEN b.transportType_key = "70" THEN 1030
            WHEN b.transportType_key = "80" THEN 1136
            WHEN b.transportType_key = "81" THEN 1508
            WHEN b.transportType_key = "82" THEN 1651
            WHEN b.transportType_key = "83" THEN 1871
            WHEN b.transportType_key = "84" THEN 2625
            WHEN b.transportType_key = "85" THEN 2625
            WHEN b.transportType_key = "970" THEN 1192
            WHEN b.transportType_key = "1000" THEN 384
            WHEN b.transportType_key = "1020" THEN 724
            WHEN b.transportType_key = "1100" THEN 1124
            WHEN b.transportType_key = "1200" THEN 449
            WHEN b.transportType_key = "1600" THEN 540
            WHEN b.transportType_key = "2100" THEN 745
            ELSE Null END
              )AS cardboard_weight
            
       
FROM `ci-test-182812.nagel_work.internationalArticles` a, `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactInvoiceHead.FactInvoiceHead` b
WHERE a.orderNo_key = b.orderNo_key AND a.invoiceNo_key = b.invoiceNo_key
GROUP BY 1,2,3
;


-- Minus Receipts
CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.minusReceipts` AS
SELECT CONCAT(CAST(EXTRACT(YEAR FROM invoiceDate) AS STRING), ".", LPAD(CAST (EXTRACT(MONTH FROM invoiceDate) AS STRING),2,"0")) AS yearMonth,
	   a.salesOrg,
       a.invoiceNo_key,
       a.orderNo_key,
       a.productNo_key,
       a.productDescGer,
       a.matClass_key,
       a.shippedItems,
       a.sellingPrice,
       a.vat,
       CASE WHEN a.shippedItems = 0 THEN 0 ELSE ROUND(a.sellingPrice / a.shippedItems, 2) END AS valuePerArticle,
       
       b.billingKind_key,
       a.commodityCode

FROM `ci-test-182812.nagel_work.internationalArticles` a, `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactInvoiceHead.FactInvoiceHead` b
WHERE a.invoiceNo_key = b.invoiceNo_key 
AND a.sellingPrice < 0
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticlesSlovenia` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticles` 
WHERE salesOrg = "5900"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticlesCroatia` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticles` 
WHERE salesOrg = "5910"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticlesCzechia` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticles` 
WHERE salesOrg = "5850"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticlesSlovakia` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticles` 
WHERE salesOrg = "5800"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticlesPoland` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticles` 
WHERE salesOrg = "5810"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticleWeightsSlovenia` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticleWeights` 
WHERE salesOrg = "5900"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticleWeightsCroatia` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticleWeights` 
WHERE salesOrg = "5910"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticleWeightsCzechia` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticleWeights` 
WHERE salesOrg = "5850"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticleWeightsSlovakia` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticleWeights` 
WHERE salesOrg = "5800"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.internationalArticleWeightsPoland` AS
SELECT *
FROM `ci-test-182812.nagel_work.internationalArticleWeights` 
WHERE salesOrg = "5810"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.minusReceiptsSlovenia` AS
SELECT *
FROM `ci-test-182812.nagel_work.minusReceipts` 
WHERE salesOrg = "5900"
;

CREATE OR REPLACE TABLE `ci-test-182812.nagel_work.minusReceiptsCroatia` AS
SELECT *
FROM `ci-test-182812.nagel_work.minusReceipts` 
WHERE salesOrg = "5910"
;