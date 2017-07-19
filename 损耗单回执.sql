
--损耗单列表拉取（上海，排除掉虚拟仓影响）
SELECT distinct t.num outer_bill_no, t.flstupdtime bill_date
  from TDECINV t, TDECINVDTL d
 where t.stat = 100
   and t.num not in
       (select ll_move_ok.num from ll_move_ok where ll_move_ok.type = 3)
   and t.num not in
       (select d.num from TDECINVDTL d where d.fpsn like '18%')
   and t.flstupdtime > sysdate - 20
 ORDER BY t.num


--损耗单列表拉取（北京，排除掉虚拟仓影响）
 SELECT distinct t.num outer_bill_no, t.flstupdtime bill_date
  from TDECINV t, TDECINVDTL d
 where t.stat = 100
   and t.num not in
       (select ll_move_ok.num from ll_move_ok where ll_move_ok.type = 3)
   and t.num not in
       (select d.num from TDECINVDTL d where d.fpsn like '18%')
   and t.flstupdtime > sysdate - 20
 ORDER BY t.num


--损耗单详情获取 排除掉0的影响
select distinct d.line,
                d.freason REASON,
                d.fqty operateNumber,
                a.fcode skuId,
                d.fpsn cargo_area,
                a.fprice * d.fqty totalprice,
                d.FPRODUCEDATE PRODUCTIONDATE
  from TDECINVDTL d
  left join tarticle a on d.farticle = a.fgid
 where d.fqty > 0
   and d.num = #outerBillNo#
