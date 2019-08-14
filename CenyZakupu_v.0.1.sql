SELECT 
productNo_key,
productNo,
dateCreation,
salesOrg,
efeuNo,
purPriceNetNet,
unitSalesPrice,
priceUnit,
purPriceNetNet as EK, 
salesPrice as VK,
salesPrice * 4.35 * 1.23 as VkPL,
(purPriceNetNet) *4.35 * 1.23  as EK_PLN,
((salesPrice) * 4.35 * 1.23) - (purPriceNetNet) *4.35 * 1.23  as Zysk,
(((salesPrice) * 4.35 * 1.23) - (purPriceNetNet) *4.35 * 1.23) / ((salesPrice) * 4.35 * 1.23) as Marza


FROM `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimProduct.DimProduct` where purPriceNetNet !=0 and salesPrice != 0
