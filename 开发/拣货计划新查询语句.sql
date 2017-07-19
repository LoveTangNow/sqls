
-- 统计本年月内总计拣货的箱数，
-- 同时可用于  统计本月内 拣货单的明细数据。

select sum(tpd.fqtystr) --tpd.num, tpd.line, tpd.fqtystr, tp.flstupdtime
  from tpickupdtl tpd
  left join tpickup tp on tp.num = tpd.num
 where to_char(tp.flstupdtime, 'yyyyMMdd') like '201706%'
   and tpd.fqtystr not like '%+%'
   and tpd.fowner = '100081'
 order by tpd.num, tpd.line;


--统计本月内 每个员工总计拣货箱数。
select sum(tpd.fqtystr) num,
       tpd.fpicker,
       (select employee.name from employee where employee.gid = tpd.fpicker) fname
  from tpickupdtl tpd
  left join tpickup tp on tp.num = tpd.num
 where tpd.fowner = '100081'
   and tp.stat <> 5210
   and tpd.fqtystr not like '%+%'
   and tpd.fpicker <> 0
   and tpd.fpicker||'-' <> '-'
   and to_char(tp.flstupdtime, 'yyyyMMdd') like '201707%'
 group by tpd.fpicker;


 
 