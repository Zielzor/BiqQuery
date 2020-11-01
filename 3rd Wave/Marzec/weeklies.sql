create or replace table `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly_raw` as
select
*
,case when Programm_Selektion=1 then nnt_2020*linearer_Rabatt else null end as linearer_gutschein_2020
,case when Programm_Selektion=1 then nnt_2020*progressiver_Rabatt else null end as progressiver_gutschein_2020
,case when linearer_Rabatt>0 then 1 else 0 end as Gutschein_Dummy_2020
from (select
* 
,case when Allgemeine_Staffel=1 and NNT_2020_class='1000_1250'  then 0.00 else 
 case when Allgemeine_Staffel=1 and NNT_2020_class='1250_1500'  then 2.00 else 
 case when Allgemeine_Staffel=1 and NNT_2020_class='1500_1750'  then 3.33 else 
 case when Allgemeine_Staffel=1 and NNT_2020_class='1750_2000'  then 4.28 else 
 case when Allgemeine_Staffel=1 and (NNT_2020_class='2000_3000' or NNT_2020>2000)  then 5.00 else 
 case when Individuelle_Staffel=1 and Wachstum_2020_class='100_125'  then 0.00 else 
 case when Individuelle_Staffel=1 and Wachstum_2020_class='125_150'  then 2.00 else 
 case when Individuelle_Staffel=1 and Wachstum_2020_class='150_175'  then 3.33 else 
 case when Individuelle_Staffel=1 and Wachstum_2020_class='175_200'  then 4.28 else 
 case when Individuelle_Staffel=1 and (Wachstum_2020_class='200_300' or Wachstum_2020>2.00)  then 5.00  else null
end end end end end end end end end end as linearer_Rabatt

,case when Allgemeine_Staffel=1 and NNT_2020_class='1000_1250'  then 0.00 else 
 case when Allgemeine_Staffel=1 and NNT_2020_class='1250_1500'  then 2.00 else 
 case when Allgemeine_Staffel=1 and NNT_2020_class='1500_1750'  then 2.70 else 
 case when Allgemeine_Staffel=1 and NNT_2020_class='1750_2000'  then 3.68 else 
 case when Allgemeine_Staffel=1 and (NNT_2020_class='2000_3000' or NNT_2020>2000)  then 5.00 else 
 case when Individuelle_Staffel=1 and Wachstum_2020_class='100_125'  then 0.00 else 
 case when Individuelle_Staffel=1 and Wachstum_2020_class='125_150'  then 2.00 else 
 case when Individuelle_Staffel=1 and Wachstum_2020_class='150_175'  then 2.70 else 
 case when Individuelle_Staffel=1 and Wachstum_2020_class='175_200'  then 3.68 else 
 case when Individuelle_Staffel=1 and (Wachstum_2020_class='200_300' or Wachstum_2020>2.00)  then 5.00  else null
end end end end end end end end end end as progressiver_Rabatt
,case when Individuelle_Staffel=1 or Allgemeine_Staffel=1 then 1 else 0 end as Programm_Selektion
from (select
a.* 
,Gastbesteller
,Werbesperre
,b.deliveryBlock
,b.orderLock
,b.billingBlock 
,b.REIN_VKORG_CUST
,case when Under_1000=1 and Buyer_2017_or_2018_or_2019=1 then 1 else 0 end as Allgemeine_Staffel
,case when Under_1000=0 and Bad_Active_2017_2018_2019=1 and Over_10000=0 then 1 else 0 end as Individuelle_Staffel
--Over_10000,Under_1000,Buyer_2017_or_2018_or_2019,Bad_Active_2017_2018_2019
from (
select 
*
, case when nnt>10000      then 1 else 0 end as ap_kdnr_10000
, case when nnt>5000       then 1 else 0 end as ap_kdnr_5000
, case when nnt>1000       then 1 else 0 end as ap_kdnr_1000
, case when nnt>500        then 1 else 0 end as ap_kdnr_500
, case when nnt_2017>10000 then 1 else 0 end as ap_kdnr_2017_10000
, case when nnt_2017>5000  then 1 else 0 end as ap_kdnr_2017_5000
, case when nnt_2017>1000  then 1 else 0 end as ap_kdnr_2017_1000
, case when nnt_2017>500   then 1 else 0 end as ap_kdnr_2017_500
, case when nnt_2018>10000 then 1 else 0 end as ap_kdnr_2018_10000
, case when nnt_2018>5000  then 1 else 0 end as ap_kdnr_2018_5000
, case when nnt_2018>1000  then 1 else 0 end as ap_kdnr_2018_1000
, case when nnt_2018>500   then 1 else 0 end as ap_kdnr_2018_500
, case when nnt_2019>10000 then 1 else 0 end as ap_kdnr_2019_10000
, case when nnt_2019>5000  then 1 else 0 end as ap_kdnr_2019_5000
, case when nnt_2019>1000  then 1 else 0 end as ap_kdnr_2019_1000
, case when nnt_2019>500   then 1 else 0 end as ap_kdnr_2019_500

, case when nnt_2019>10000 then 'mt_10000' else
  case when nnt_2019>9000 and nnt_2019<=10000 then '9000_10000' else
  case when nnt_2019>8000 and nnt_2019<=9000  then '8000_9000' else
  case when nnt_2019>7000 and nnt_2019<=8000  then '7000_8000' else
  case when nnt_2019>6000 and nnt_2019<=7000  then '6000_7000' else
  case when nnt_2019>5000 and nnt_2019<=6000  then '5000_6000' else
  case when nnt_2019>4000 and nnt_2019<=5000  then '4000_5000' else
  case when nnt_2019>3000 and nnt_2019<=4000  then '3000_4000' else
  case when nnt_2019>2000 and nnt_2019<=3000  then '2000_3000' else
  case when nnt_2019>1000 and nnt_2019<=1250  then '1000_1250' else
  case when nnt_2019>1250 and nnt_2019<=1500  then '1250_1500' else
  case when nnt_2019>1500 and nnt_2019<=1750  then '1500_1750' else
  case when nnt_2019>1750 and nnt_2019<=2000  then '1750_2000' else 
  case when nnt_2019>  0  and nnt_2019<=1000  then '0000_1000' else null end end end end end end end end end end end end end end as NNT_2019_class

, case when nnt_2018>10000 then 'mt_10000' else
  case when nnt_2018>9000 and nnt_2018<=10000 then '9000_10000' else
  case when nnt_2018>8000 and nnt_2018<=9000  then '8000_9000' else
  case when nnt_2018>7000 and nnt_2018<=8000  then '7000_8000' else
  case when nnt_2018>6000 and nnt_2018<=7000  then '6000_7000' else
  case when nnt_2018>5000 and nnt_2018<=6000  then '5000_6000' else
  case when nnt_2018>4000 and nnt_2018<=5000  then '4000_5000' else
  case when nnt_2018>3000 and nnt_2018<=4000  then '3000_4000' else
  case when nnt_2018>2000 and nnt_2018<=3000  then '2000_3000' else
  case when nnt_2018>1000 and nnt_2018<=1250  then '1000_1250' else
   case when nnt_2018>1250 and nnt_2018<=1500  then '1250_1500' else
   case when nnt_2018>1500 and nnt_2018<=1750  then '1500_1750' else
   case when nnt_2018>1750 and nnt_2018<=2000  then '1750_2000' else  
  
  case when nnt_2018>  0  and nnt_2018<=1000  then '0000_1000' else null end end end end end end end end end end end end end end as NNT_2018_class

, case when nnt_2020>10000 then 'mt_10000' else
  case when nnt_2020>9000 and nnt_2020<=10000 then '9000_10000' else
  case when nnt_2020>8000 and nnt_2020<=9000  then '8000_9000' else
  case when nnt_2020>7000 and nnt_2020<=8000  then '7000_8000' else
  case when nnt_2020>6000 and nnt_2020<=7000  then '6000_7000' else
  case when nnt_2020>5000 and nnt_2020<=6000  then '5000_6000' else
  case when nnt_2020>4000 and nnt_2020<=5000  then '4000_5000' else
  case when nnt_2020>3000 and nnt_2020<=4000  then '3000_4000' else
  case when nnt_2020>2000 and nnt_2020<=3000  then '2000_3000' else
  case when nnt_2020>1000 and nnt_2020<=1250  then '1000_1250' else
  case when nnt_2020>1250 and nnt_2020<=1500  then '1250_1500' else
  case when nnt_2020>1500 and nnt_2020<=1750  then '1500_1750' else
  case when nnt_2020>1750 and nnt_2020<=2000  then '1750_2000' else 
  case when nnt_2020>  0  and nnt_2020<=1000  then '0000_1000' else null end end end end end end end end end end end end end end as NNT_2020_class

,case when Wachstum_2018>0.00 and Wachstum_2018<=0.25 then '000_025' else
 case when Wachstum_2018>0.25 and Wachstum_2018<=0.50 then '025_050' else
 case when Wachstum_2018>0.50 and Wachstum_2018<=0.75 then '050_075' else
 case when Wachstum_2018>0.75 and Wachstum_2018<=1.00 then '075_100' else
 case when Wachstum_2018>1.00 and Wachstum_2018<=1.25 then '100_125' else
 case when Wachstum_2018>1.25 and Wachstum_2018<=1.50 then '125_150' else
 case when Wachstum_2018>1.50 and Wachstum_2018<=1.75 then '150_175' else
 case when Wachstum_2018>1.75 and Wachstum_2018<=2.00 then '175_200' else
 case when Wachstum_2018>2.00 and Wachstum_2018<=3.00 then '200_300' else
 case when Wachstum_2018>3.00 and Wachstum_2018<=4.00 then '300_400' else
 case when Wachstum_2018>4.00 and Wachstum_2018<=5.00 then '400_500' else
 case when Wachstum_2018>5.00                         then 'mt_500' end end end end end end end end end end end end as Wachstum_2018_class

,case when Wachstum_2019>0.00 and Wachstum_2019<=0.25 then '000_025' else
 case when Wachstum_2019>0.25 and Wachstum_2019<=0.50 then '025_050' else
 case when Wachstum_2019>0.50 and Wachstum_2019<=0.75 then '050_075' else
 case when Wachstum_2019>0.75 and Wachstum_2019<=1.00 then '075_100' else
 case when Wachstum_2019>1.00 and Wachstum_2019<=1.25 then '100_125' else
 case when Wachstum_2019>1.25 and Wachstum_2019<=1.50 then '125_150' else
 case when Wachstum_2019>1.50 and Wachstum_2019<=1.75 then '150_175' else
 case when Wachstum_2019>1.75 and Wachstum_2019<=2.00 then '175_200' else
 case when Wachstum_2019>2.00 and Wachstum_2019<=3.00 then '200_300' else
 case when Wachstum_2019>3.00 and Wachstum_2019<=4.00 then '300_400' else
 case when Wachstum_2019>4.00 and Wachstum_2019<=5.00 then '400_500' else
 case when Wachstum_2019>5.00                         then 'mt_500' end end end end end end end end end end end end as Wachstum_2019_class

,case when Wachstum_2020>0.00 and Wachstum_2020<=0.25 then '000_025' else
 case when Wachstum_2020>0.25 and Wachstum_2020<=0.50 then '025_050' else
 case when Wachstum_2020>0.50 and Wachstum_2020<=0.75 then '050_075' else
 case when Wachstum_2020>0.75 and Wachstum_2020<=1.00 then '075_100' else
 case when Wachstum_2020>1.00 and Wachstum_2020<=1.25 then '100_125' else
 case when Wachstum_2020>1.25 and Wachstum_2020<=1.50 then '125_150' else
 case when Wachstum_2020>1.50 and Wachstum_2020<=1.75 then '150_175' else
 case when Wachstum_2020>1.75 and Wachstum_2020<=2.00 then '175_200' else
 case when Wachstum_2020>2.00 and Wachstum_2020<=3.00 then '200_300' else
 case when Wachstum_2020>3.00 and Wachstum_2020<=4.00 then '300_400' else
 case when Wachstum_2020>4.00 and Wachstum_2020<=5.00 then '400_500' else
 case when Wachstum_2020>5.00                         then 'mt_500' end end end end end end end end end end end end as Wachstum_2020_class
 
,(case when Wachstum_2018>2 then (-0.16*POW(2,7)+20*POW(2,2)+1*2)/10 else (-0.16*POW(Wachstum_2018,7)+20*POW(Wachstum_2018,2)+1*Wachstum_2018)/10 end)/100*nnt_2018 as Rabatt_2018
,(case when Wachstum_2019>2 then (-0.16*POW(2,7)+20*POW(2,2)+1*2)/10 else (-0.16*POW(Wachstum_2019,7)+20*POW(Wachstum_2019,2)+1*Wachstum_2019)/10 end)/100*nnt_2019 as Rabatt_2019

,case when Wachstum_2018>2 then (-0.16*POW(2,7)+20*POW(2,2)+1*2)/10 else (-0.16*POW(Wachstum_2018,7)+20*POW(Wachstum_2018,2)+1*Wachstum_2018)/10 end as Rabattpunkte_2018
,case when Wachstum_2019>2 then (-0.16*POW(2,7)+20*POW(2,2)+1*2)/10 else (-0.16*POW(Wachstum_2019,7)+20*POW(Wachstum_2019,2)+1*Wachstum_2019)/10 end as Rabattpunkte_2019
/*
,case when 
(ap_kdnr_2017 is null and ap_kdnr_2018 is not null and ap_kdnr_2019 is null) or
(ap_kdnr_2017 is not null and ap_kdnr_2018 is null and ap_kdnr_2019 is null) or
(ap_kdnr_2017 is null and ap_kdnr_2018 is null and ap_kdnr_2019 is not null)
then 1 else 0 end as Buyer_2017_or_2018_or_2019
*/
,case when (Wachstum_2018>0.00 and Wachstum_2018<=1.25) and (Wachstum_2019>0.00 and Wachstum_2019<=1.25) then 1 else 0 end as Bad_Active_2017_2018_2019


,case when 
(ap_kdnr_2017 is null and ap_kdnr_2018 is not null and ap_kdnr_2019 is not null) or
(ap_kdnr_2017 is not null and ap_kdnr_2018 is not null and ap_kdnr_2019 is null) or
(ap_kdnr_2017 is null and ap_kdnr_2018 is not null and ap_kdnr_2019 is null) or
(ap_kdnr_2017 is not null and ap_kdnr_2018 is null and ap_kdnr_2019 is null) or
(ap_kdnr_2017 is not null and ap_kdnr_2018 is null and ap_kdnr_2019 is not null)
then 1 else 0 end as Buyer_2017_or_2018_or_2019

,case when (ap_kdnr_2017 is null and ap_kdnr_2018 is not null and ap_kdnr_2019 is not null)     then '2018_2019'        else 
case when  (ap_kdnr_2017 is not null and ap_kdnr_2018 is not null and ap_kdnr_2019 is null)     then '2017_2018'        else 
case when  (ap_kdnr_2017 is null and ap_kdnr_2018 is not null and ap_kdnr_2019 is null)         then  '2018'            else 
case when  (ap_kdnr_2017 is not null and ap_kdnr_2018 is null and ap_kdnr_2019 is null)         then  '2017'            else 
case when  (ap_kdnr_2017 is not null and ap_kdnr_2018 is null and ap_kdnr_2019 is not null)     then  '2017_2019'       else 
case when  (ap_kdnr_2017 is not null and ap_kdnr_2018 is not null and ap_kdnr_2019 is not null) then  '2017_2018_2019'  else 
null end end end end end end as Buyer_2017_or_2018_or_2019_group

,case when ap_kdnr_2019 is not null and Under_1000_2019=1 then 1 else case when ap_kdnr_2019 is null and ap_kdnr_2018 is not null and Under_1000_2018<1000 then 1 else 0 end end as Under_1000
,case when ap_kdnr_2019 is not null and Over_10000_2019=1 then 1 else case when ap_kdnr_2019 is null and ap_kdnr_2018 is not null and Over_10000_2018<1000 then 1 else 0 end end as Over_10000
from
(select 
*
, case when nnt_2017>0 and nnt_2018>0 then ((nnt_2018)/nnt_2017) else 0 end as Wachstum_2018
, case when nnt_2018>0 and nnt_2019>0 then ((nnt_2019)/nnt_2018) else 0 end as Wachstum_2019
, case when nnt_2019>0 and nnt_2020>0 then ((nnt_2020)/nnt_2019) else 0 end as Wachstum_2020
from (
SELECT 
concat(cast(AP as string),'-',cast(KD_AG as string))  as ap_kdnr
,KD_AG
,AP
, round(sum(nnt),2) as nnt
, round(sum(cm1),2) as cm1
, Plattform
, yearno
, vkorg_cust_land_bez
, managed_c_d_only
,salesOrg_cust
FROM  `sm-smb2b-clc-misc.fungone.full_sales_data_BE_WE_CESD_54610` as a
where sellergrp_key in ('101','102','103','110') and salesorg_key in ('1000','5545','5550','5574','8000','5200','5210','5220','5230','5240','5250','5300','1860') and yearno in (2017,2018,2019,2020)
group by
concat(cast(KD_AG as string),'-',cast(AP as string)) 
, KD_AG
, AP
, yearNo
, vkorg_cust_land_bez
, managed_c_d_only
, salesOrg_cust
, Plattform
) as a
left join 
(select 
round(sum(nnt),2) as nnt_2017
, round(sum(cm1),2) as cm1_2017
, KD_AG as KD_AG_2017
, AP as AP_2017
, count(distinct order_id) as order_2017
, concat(cast(AP as string),'-',cast(KD_AG as string))  as ap_kdnr_2017 
, yearno as yearno_2017
from  `sm-smb2b-clc-misc.fungone.full_sales_data_BE_WE_CESD_54610`
where yearno=2017 and sellergrp_key in ('101','102','103','110') and salesorg_key in ('1000','5545','5550','5574','8000','5200','5210','5220','5230','5240','5250','5300','1860') group by KD_AG, AP, yearno) as b on a.ap_kdnr=b.ap_kdnr_2017 
/*--and a.yearno=b.yearno_2017*/

left join 
(select round(sum(nnt),2) as nnt_2018
,case when sum(nnt)<1000 and sum(nnt)>0 then 1 else 0 end as Under_1000_2018
,case when sum(nnt)>10000 then 1 else 0 end as Over_10000_2018
, round(sum(cm1),2) as cm1_2018
, KD_AG as KD_AG_2018
, AP as AP_2018 
, count(distinct order_id) as order_2018
, concat(cast(AP as string),'-',cast(KD_AG as string))  as ap_kdnr_2018 
, yearno as yearno_2018
from  `sm-smb2b-clc-misc.fungone.full_sales_data_BE_WE_CESD_54610`
where yearno=2018 and sellergrp_key in ('101','102','103','110') and salesorg_key in ('1000','5545','5550','5574','8000','5200','5210','5220','5230','5240','5250','5300','1860')group by KD_AG, AP, yearno) as c on a.ap_kdnr=c.ap_kdnr_2018 
/*--and a.yearno=c.yearno_2018*/
left join 
(select round(sum(nnt),2) as nnt_2019
,case when sum(nnt)<1000 and sum(nnt)>0 then 1 else 0 end as Under_1000_2019
,case when sum(nnt)>10000 then 1 else 0 end as Over_10000_2019
, round(sum(cm1),2) as cm1_2019
, KD_AG as KD_AG_2019
, AP as AP_2019 
, count(distinct order_id) as order_2019
, concat(cast(AP as string),'-',cast(KD_AG as string)) as ap_kdnr_2019 
, yearno as yearno_2019
from  `sm-smb2b-clc-misc.fungone.full_sales_data_BE_WE_CESD_54610`
where yearno=2019 and sellergrp_key in ('101','102','103','110') and salesorg_key in ('1000','5545','5550','5574','8000','5200','5210','5220','5230','5240','5250','5300','1860') group by KD_AG, AP, yearno) as d on a.ap_kdnr=d.ap_kdnr_2019 
/*--and a.yearno=d.yearno_2019*/
left join 
(select round(sum(nnt),2) as nnt_2020
, round(sum(cm1),2) as cm1_2020
, KD_AG as KD_AG_2020
, AP as AP_2020
, concat(cast(AP as string),'-',cast(KD_AG as string)) as ap_kdnr_2020 
, yearno as yearno_2020
from   `sm-smb2b-clc-misc.fungone.full_sales_data_BE_WE_CESD_54610`
where yearno=2020 and sellergrp_key in ('101','102','103','110') and salesorg_key in ('1000','5545','5550','5574','8000','5200','5210','5220','5230','5240','5250','5300','1860') group by KD_AG, AP, yearno) as e on a.ap_kdnr=e.ap_kdnr_2020


)) as a
left join fungone.customer_data_only_ar as b on a.KD_AG=b.customerno_dimcustomer	 
))
/*noch dummies für Kunden aktivität in den vorangegangen Jahren evtl. gleich CESS ziehen*/
;



create or replace table `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly` as
select a.*, 1 as test,b.yearno_max,yearno_min, progressiver_Rabatt_2020
from `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly_raw` as a
left join (select max(yearno) as yearno_max, ap_kdnr from `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly_raw` where yearno<2020 group by ap_kdnr) as b on a.ap_kdnr=b.ap_kdnr
and yearno=yearno_max
left join (select min(yearno) as yearno_min, ap_kdnr from `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly_raw` where yearno<2020 group by ap_kdnr) as c on a.ap_kdnr=c.ap_kdnr
and yearno=yearno_min
left join (select distinct(ap_kdnr) as ap_kdnr ,max(progressiver_Rabatt) as progressiver_Rabatt_2020 from `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly_raw` where yearno=2020 group by ap_kdnr) as d on a.ap_kdnr=d.ap_kdnr
left join (select *,
case when PARTNERNUMMER is not null then concat(cast(PARTNERNUMMER as string),'-',cast(KUNDENNUMMER as string)) else concat('9999999998','-',cast(KUNDENNUMMER as string)) end as ap_kdnr from `sm-smb2b-clc-misc.SalesForce_Selection.Telefonpotenzial_202003`) as f on a.ap_kdnr=f.ap_kdnr
left join `sm-smb2b-clc-misc.SalesForce_Selection.current_Selected_Customer` as u on a.ap_kdnr=u.ap_kdnr
where f.ap_kdnr is not null and u.ap_kdnr is null
;


create or replace table `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly_final` as
select distinct ap_kdnr, PRIO from(
select *
, case when Wachstum_2018_class in ('125_150','150_175','175_200','200_300','300_400','400_500','mt_500' ) and Wachstum_2019_class in ('125_150','150_175','175_200','200_300','300_400','400_500','mt_500' ) then 'PRIO_I' else 
case when Wachstum_2018_class in ('000_025','025_050','050_075','075_100','100_125') and Wachstum_2019_class in ('000_025','025_050','050_075','075_100','100_125') then 'PRIO_II' else 
case when Buyer_2017_or_2018_or_2019_group in ('2018_2019','2017_2018','2017_2019','2017_2018_2019') and ap_kdnr_2020 is null then 'PRIO_III' else null end end end as PRIO

from `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly` where  managed_c_d_only='PMC' )
where PRIO is not null 
group by ap_kdnr,PRIO
;




select count(distinct ap_kdnr), PRIO from(
select *
, case when Wachstum_2018_class in ('125_150','150_175','175_200','200_300','300_400','400_500','mt_500' ) and Wachstum_2019_class in ('125_150','150_175','175_200','200_300','300_400','400_500','mt_500' ) then 'PRIO_I' else 
case when Wachstum_2018_class in ('000_025','025_050','050_075','075_100','100_125') and Wachstum_2019_class in ('000_025','025_050','050_075','075_100','100_125') then 'PRIO_II' else 
case when Buyer_2017_or_2018_or_2019_group in ('2018_2019','2017_2018','2017_2019','2017_2018_2019') and ap_kdnr_2020 is null then 'PRIO_III' else null end end end as PRIO

from `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly` where  managed_c_d_only='PMC' )
where PRIO is not null 
group by PRIO



create or replace table `sm-smb2b-clc-misc.SalesForce_Selection.Total_sales` as
select 
ap_kdnr
,sum(case when yearno=2019 then nnt else 0 end) as nnt_2019
,sum(case when yearno=2020 then nnt else 0 end) as nnt_2020
from(
select 
concat(cast(AP as string),'-',cast(KD_AG as string)) as ap_kdnr
,KD_AG
, AP
, productno
, order_id
, nnt
, cm1
, vkorg_cust_land_Bez
, managed
, date_key
, months_key
, yearno 
, branddesceng as brand
, efeuClassDescEng
, b.district_key
, districtDescEng
from `sm-smb2b-clc-misc.fungone.full_sales_data_BE_WE_20190826`  as a
left join 
(select 
case when safe_cast((customerNo) as numeric) is null 
then 0 else safe_cast((customerNo) as numeric) end    as KD_AG_dimcustomer
, salesorg as salesorg_key
, district_key
from  `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer`) as b on a.KD_AG=b.KD_AG_dimcustomer          /*A = DimCustomer*/  
left join `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomerDistrict.DimCustomerDistrict` as c on b.district_key= c.district_key  
where 
yearno in (2019,2020)
)
group by ap_kdnr;

/*Join Wim & Carsten & Total Sales tabellen*/
create or replace table `sm-smb2b-clc-misc.SalesForce_Selection.Potential` as
select selection_for_date
, e.salesDistrict
, e.sellerGrp_key
, e.enterpriseNumber
, a.ap_kdnr
, e.customerNo_key
, f.contactPerson_key as contactPersonNo
, concat(e.firstname,' ',e.name1) as CompanyName
, e.city
, 'PMC' as managed_group
, phoneNo1 as Customer_phone1
, f.salutation
, f.firstName
, f.lastName
, f.phoneNo as AP_phoneNo
, f.eMailAddress as contacts_EmailAdresse
, b.DatumAnlage
, b.FREMDSPRACH_KZ1
, b.WER
, Laendercode
, PRIO
,c.* except (ap_kdnr)
from (select *, '2020-05-04' as selection_for_date             /*******************selection adjustmen************************1*****/
/*selection adjustment*/

 from `sm-smb2b-clc-misc.SalesForce_Selection.Two_weekly_final`) as a /*****************selection adjustment***********2******/


/*selection adjustment*/
inner join (select * ,
case when PARTNERNUMMER is not null then concat(cast(PARTNERNUMMER as string),'-',cast(KUNDENNUMMER as string)) else concat('0','-',cast(KUNDENNUMMER as string)) end as ap_kdnr_tele from `sm-smb2b-clc-misc.SalesForce_Selection.Telefonpotenzial_202003`) as b on a.ap_kdnr=b.ap_kdnr_tele
left join `sm-smb2b-clc-misc.SalesForce_Selection.Total_sales` as c on a.ap_kdnr=c.ap_kdnr
left join `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimCustomer.DimCustomer` as E on b.KUNDENNUMMER=e.customerno
left join `conrad-cbdp-prod-core.de_conrad_dwh1000_dwh_DimContactPerson.DimContactPerson` as F on b.PARTNERNUMMER=cast(f.contactPerson_key as numeric) and b.KUNDENNUMMER=f.customerNo
where f.firstName is not null and f.lastName is not Null and (e.phoneNo1 is not null or f.phoneNo is not null);



create or replace table `sm-smb2b-clc-misc.SalesForce_Selection.PMC_part` as
select 
a.*
,b.districtDescEng
,b.district_key
,c.teiler
,c.vkorg_cust_land_Bez
from `sm-smb2b-clc-misc.SalesForce_Selection.Potential`  as a
left join `sm-smb2b-clc-misc.SalesForce_Selection.Country_to_district` as b on a.salesDistrict=b.district_key
left join 
(select max(rownum) as teiler, vkorg_cust_land_Bez 
from `sm-smb2b-clc-misc.SalesForce_Selection.Country_to_district` group by vkorg_cust_land_Bez) as c on a.LAENDERCODE=c.vkorg_cust_land_Bez
where AP_phoneNo is not null and managed_group='PMC' and b.district_key is not null
;



/*Vorselektion wird ausgeschlossen*/
create 
or replace 
table `sm-smb2b-clc-misc.SalesForce_Selection.All_CW_19_20` as   /*****************selection adjustment***********3******/
select a.* from
(select 
*
from `sm-smb2b-clc-misc.SalesForce_Selection.PMC_part`
) as a
/*excluding previous selection, should be only one table in near future*/

left join (select * from `sm-smb2b-clc-misc.SalesForce_FB.salesforce_feedback` where (Succesful=1 or comments_cluster in ('No need','closed','exclude'))) as b on a.ap_kdnr=b.ap_kdnr  /*excluding previous selection, should be only one table in near future*/



where b.ap_kdnr is null 
--and f.ap_kdnr is null                                                                         /*****************selection adjustment***********5******/

/*excluding previous selection, should be only one table in near future*/
order by  a.district_key, PRIO;


create 
or replace 
table `sm-smb2b-clc-misc.SalesForce_Selection.All_CW_19_20_rank` as  /*****************selection adjustment***********5******/
select * from (
select * except(teiler,vkorg_cust_land_Bez)
,ROW_NUMBER() OVER (PARTITION BY district_key order by Prio asc, rfm_class asc) as rownum 
from (select * from `sm-smb2b-clc-misc.SalesForce_Selection.All_CW_19_20`  as a
inner join (select  rfm.cy.class as rfm_class, ap_kdnr_ag FROM 
--`ci-test-182812.RFM.RFM_all_ag_ap_all_b2b` 
`sm-smb2b-clc-misc.original.RFM_all_ag_ap_all_b2b`
where sellerGrp_ag in ('101','102','103','110')) as b /*rfm class*/
on a.ap_kdnr=b.ap_kdnr_ag
left join (select district_key as district_key_c, districtDescEng as salesDistrict_DescEng from `sm-smb2b-clc-misc.SalesForce_Selection.Country_to_district`) as c on a.salesdistrict=c.district_key_c
) ) where rownum<=400
order by district_key
,rownum
;


create 
or replace 
table `sm-smb2b-clc-misc.SalesForce_Selection.DACH_CW_19_20_rank` as /*****************selection adjustment***********6******/
select * 
from (select * except(Laendercode,ap_kdnr_Ag),  Laendercode  as Country_key from `sm-smb2b-clc-misc.SalesForce_Selection.All_CW_19_20_rank`)  as a    /*****************selection adjustment***********7******/
where Country_key in ('DE','AT','CH') and district_key is not null and district_key in (select district_key from  `sm-smb2b-clc-misc.SalesForce_Selection.Country_to_district` where rownum_filial=0)
order by Country_key desc,district_key,rownum;

