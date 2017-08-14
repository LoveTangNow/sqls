
-- 统计本年月内总计拣货的箱数，
-- 同时可用于  统计本月内 拣货单的明细数据。

select sum(tpd.fqtystr) --tpd.num, tpd.line, tpd.fqtystr, tp.flstupdtime
  from tpickupdtl tpd
  left join tpickup tp on tp.num = tpd.num
 where to_char(tp.flstupdtime, 'yyyyMMdd') like '201706%'
   and tpd.fqtystr not like '%+%'
   and tpd.fowner = '100081'
 order by tpd.num, tpd.line;


--统计本月内 每个员工总计拣货箱数。上海
select sum(tpd.fqtystr) num,
       tpd.fpicker,
       (select employee.name from employee where employee.gid = tpd.fpicker) fname
  from tpickupdtl tpd
  left join tpickup tp on tp.num = tpd.num
 where tpd.fowner = '100081'
   and tp.stat <> 5210
   and tpd.fqtystr not like '%+%'
   and tpd.fpicker <> 0
   and tpd.fpicker || '-' <> '-'
   and to_char(tp.flstupdtime, 'yyyyMMdd') like '201707%'
 group by tpd.fpicker;

--统计本月内 每个员工总计拣货箱数。北京
select *
  from (select sum(tpd.fqtystr) num,
               tpd.fpicker,
               (select employee.name from employee where employee.gid = tpd.fpicker) fname
          from tpickupdtl tpd
          left join tpickup tp on tp.num = tpd.num
         where tpd.fowner = '100161'
           and tp.stat <> 5210
           and tpd.fqtystr not like '%+%'
           and tpd.fpicker <> 0
           and tpd.fpicker || '-' <> '-'
           and to_char(tp.flstupdtime, 'yyyyMMdd') like '201708%'
         group by tpd.fpicker)
 order by num desc;

select tpd.num,
       tpd.fqtystr,
       tpd.fpicker,
       (select employee.name from employee where employee.gid = tpd.fpicker) fname
  from tpickupdtl tpd
  left join tpickup tp on tp.num = tpd.num
 where tpd.fowner = '100081'
   and tp.stat <> 5210
   and tpd.fqtystr like '%+%'
   and tpd.fpicker <> 0
   and tpd.fpicker || '-' <> '-'
   and to_char(tp.flstupdtime, 'yyyyMMdd') like '201707%'


select tc.FSRCNUM      来源单号,
       TC.FJOBID       配货作业号,
       tc.num          配货通知单号,
       tp.num          拣货单号,
       tpd.line        行号,
       ts.fname        门店名称,
       t.fcode         商品代码,
       t.fname         商品名称,
       tpd.fqpcstr     商品规格,
       tpd.fqtystr     箱数,
       tpd.fqpc        包装规格,
       tpd.fqty        件数,
       tpd.fpalletcode 托盘条码,
       tpd.FCHESTNUM   周转箱条码,
       E.NAME          拣货员,
       TP.FLSTUPDTIME  时间
  from TPICKUPDTL tpd
  left join tpickup tp on tp.num = tpd.num
  left join talcntc tc on tpd.falcntc = tc.num
  left join tstore ts on TP.FSTORE = TS.FCODE
  left join tarticle t ON tpd.farticle = t.fgid
  left join employee e on tpd.fpicker = E.GID
 where tpd.fowner = '100081'
   and tp.stat <> 5210
   and tpd.fqtystr not like '%+%'
   and tpd.fpicker <> 0
   and tpd.fpicker || '-' <> '-'
   and to_char(tp.flstupdtime, 'yyyyMMdd') like '201707%'
 order by TP.FLSTUPDTIME;