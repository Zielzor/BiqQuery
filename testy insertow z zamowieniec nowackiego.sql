SELECT 
a.*

FROM 
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimAdvertisingMaterial.DimAdvertisingMaterial`  as a,
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_FactSales.FactSales` as b
where b.partitionDate between "2019-12-01" and CURRENT_DATE()
and b.OrderNo = "1076184151"
and a.insert_key = "DN"
and salesOrg_key 	="5810"