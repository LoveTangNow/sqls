

select sum(TBOOKREG.Fqtystr) box_,
       to_char(tbookreg.fbookdate, 'yyyyMMdd') date_
  from TBOOKREG
 group by to_char(tbookreg.fbookdate, 'yyyyMMdd')
 order by to_char(tbookreg.fbookdate, 'yyyyMMdd') desc;