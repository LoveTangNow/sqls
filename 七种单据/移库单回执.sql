--上海的移库单  只选择特定的移动方式 （已部署）
select distinct tm.num, tm.flstupdtime
  from tmoveinv tm
  left join tmoveinvdtl tmd on tm.num = tmd.num
 where ((tmd.ffrompsn like '2%' and tmd.fdestpsn like '9%') or
       (tmd.ffrompsn like '91%' and tmd.fdestpsn like '92%') or
       (tmd.ffrompsn like '9%' and tmd.fdestpsn like '2%') or
       (tmd.ffrompsn like '92%' and tmd.fdestpsn like '91%'))
   and tm.num not in (select l.num
                        from ll_move_ok l
                       where l.type = 1
                         and l.time > sysdate - 8)
   and tm.flstupdtime > sysdate - 7
   and tm.ftype <> '门店退货'
   and tm.stat = 100
 order by tm.flstupdtime;





--北京的移库单 只选择特定的移动方式 （已部署）
select distinct tm.num, tm.flstupdtime
  from tmoveinv tm
  left join tmoveinvdtl tmd on tm.num = tmd.num
 where ((tmd.ffrompsn like '11%' and tmd.fdestpsn like '9%') or
       (tmd.ffrompsn like '93%' and tmd.fdestpsn like '94%') or
       (tmd.ffrompsn like '9%' and tmd.fdestpsn like '11%') or
       (tmd.ffrompsn like '94%' and tmd.fdestpsn like '93%'))
   and tm.num not in (select l.num
                        from ll_move_ok l
                       where l.type = 1
                         and l.time > sysdate - 8)
   and tm.flstupdtime > sysdate - 7
   and tm.ftype <> '门店退货'
   and tm.stat = 100
 order by tm.flstupdtime;


--北京的损耗单  排除掉虚拟仓 98 的影响
 SELECT distinct t.num outer_bill_no, t.flstupdtime bill_date
  from TDECINV t
  left join Tdecinvdtl td on td.num = t.num
 where t.stat = 100
   and t.num not in
       (select ll_move_ok.num from ll_move_ok where ll_move_ok.type = 3)
   and t.flstupdtime > sysdate - 20
   and td.fpsn not like '98%'
 ORDER BY t.num desc;
