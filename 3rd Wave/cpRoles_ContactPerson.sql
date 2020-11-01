CREATE OR REPLACE TABLE `ceeregion-prod.Inne.ContactPerson_Roles` as 
SELECT 
a._7_Customer_No as customerNo,
b.contactPerson_key,
b.cpDepartment_key, 
b.apFunkt_id


FROM `ceeregion-prod.Dashboards_CEPL_2020.Dashboard_CEPL_2020_PL` as a
LEFT JOIN `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimContactPerson.DimContactPerson` as b on a._7_Customer_No = b.customerNo_key

ORDER BY a._7_Customer_No DESC

