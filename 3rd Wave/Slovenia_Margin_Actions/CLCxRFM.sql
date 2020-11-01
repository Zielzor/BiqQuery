SELECT *
FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_ci_HistCustomerRfmClc.HistCustomerRfmClc`
WHERE dateValidFrom_key <= 20200101 AND 20200101 <= dateValidTo_key 
AND customerNo_key like "_7%"
