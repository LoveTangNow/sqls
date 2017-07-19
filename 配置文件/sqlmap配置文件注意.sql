/*
    在sqlmap中需要额外定制的部分主要是三个自幼单据的回执部分

    1、移库单  仓位关系
    2、盘盈单 自有仓位剥离
    3、盘亏单 自有仓位剥离
*/

--<![CDATA[<]]><![CDATA[>]]>
--旧的移库单回执
    SELECT distinct t.num outer_bill_no ,t.flstupdtime bill_date from TMOVEINV t,wms_taobao_bill_history h where 
    t.stat=100 and  h.type=3  and 
    t.flstupdtime>=h.update_time
    and t.flstupdtime>sysdate-7
    and t.num>#wmsNum#
     and t.ftype  <> '门店退货'
    ORDER BY t.num


--上海移库单
 select distinct tm.num  outer_bill_no, tm.flstupdtime  bill_date
  from tmoveinv tm
  left join tmoveinvdtl tmd on tm.num = tmd.num
 where  tmd.ffrompsn like #string1# 
    and tmd.fdestpsn like #string1# 
   and tm.num not in
       (select l.num
          from ll_move_ok l
         where l.type = 1
           and l.time >= to_date('20170713', 'yyyymmdd'))
   and tm.flstupdtime >= to_date('20170713', 'yyyymmdd')
   and tm.ftype <> '门店退货'
   and tm.stat = 100
 order by tm.flstupdtime



 --北京移库单
 select distinct tm.num outer_bill_no, tm.flstupdtime bill_date
  from tmoveinv tm
  left join tmoveinvdtl tmd on tm.num = tmd.num
 where ((tmd.ffrompsn like '11%' and tmd.fdestpsn like '93%') or
       (tmd.ffrompsn like '11%' and tmd.fdestpsn like '94%') or
       (tmd.ffrompsn like '93%' and tmd.fdestpsn like '94%') or
       (tmd.ffrompsn like '93%' and tmd.fdestpsn like '11%') or
       (tmd.ffrompsn like '94%' and tmd.fdestpsn like '11%') or
       (tmd.ffrompsn like '94%' and tmd.fdestpsn like '93%'))
   and tm.num not in
       (select l.num
          from ll_move_ok l
         where l.type = 1
           and l.time >= to_date('20170713', 'yyyymmdd'))
   and tm.flstupdtime >= to_date('20170713', 'yyyymmdd')
   and tm.ftype <> '门店退货'
   and tm.stat = 100
 order by tm.flstupdtime





 --北京新的溢余单查询方法
 --需要排除虚拟分仓98的影响
SELECT distinct t.num outer_bill_no, t.flstupdtime bill_date
  from TINCINV t
  left join tincinvdtl td on td.num = t.num
 where t.stat = 100
   and substr(td.fpsn, 1, 2) not in (98)
   and t.num not in
       (select ll_move_ok.num from ll_move_ok where ll_move_ok.type = 2)
   and t.FLSTUPDTIME > sysdate - 20
 ORDER BY t.num desc;