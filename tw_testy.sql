SELECT

MAT_HIER_ID, 
MATNR_ID,
MATNR_KEY, 
MATKLASSE_KEY, 
MATKLASSE_BEZ_EN, 
OBERGRUPPE_BEZ_EN, 
HAUPTGRUPPE_BEZ_EN, 
FACHBEREICH_BEZ_EN

FROM COBIS_DWH.D_ARTIKELHIERARCHIE
WHERE     and AKTIV_KNZ=1
###################################################################

SELECT 
c.globalProductHierarchy_key,
c.productNo_key,
c.matClass_key,
c.matClassDescEng,
c.ordinateDescEng,
c.maingrpDescEng,
c.categoryDescEng,
c.category_key

FROM
`conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProductHierarchy.DimProductHierarchy` as c 

WHERE c.flagActive = 1

