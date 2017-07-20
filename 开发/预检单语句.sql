--预检单新明细查询语句
--包括已收。
SELECT t.fgid as id,
       tp.fpaqstandard ps,
       t.fname as NAME,
       t.FSPEC as SPE,
       t.FVALIDPERIOD as ALLTIME,
       t.FSTKLMTDAYS as TIME,
       tp.FQTY,
       tsd.fqty,
       t.fmixstkin as min
  FROM TPREVEXAMDTL tp
  left join tarticle t on t.fgid = tp.farticle
  left join tstkin ts on ts.fprenum = tp.num
  left join tstkindtl tsd on (tsd.num = ts.num and tsd.farticle = tp.farticle)
 WHERE tp.num = '00011707000004'
