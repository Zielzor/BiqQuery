CREATE OR REPLACE TABLE `ceeregion-prod.AA__CEPL_ReferenceInvoiceNumber.RefernceInvoiceNo_done`  AS
SELECT DISTINCT
a.referenceInvoiceNo,
b.invoiceNo_key,
b.orderNo_key,
b.salesOrg 

FROM `ceeregion-prod.AA__CEPL_ReferenceInvoiceNumber.RefernceInvoiceNo` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactInvoiceHead.FactInvoiceHead` as b on cast(a.referenceInvoiceNo as STRING) = cast(b.referenceInvoiceNo as STRING)

WHERE b.version_key = "ISJA20060201"