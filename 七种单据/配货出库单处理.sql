
/*未部署  新加0配货剔除条件*/
select *
  from (select distinct i.bill_no,
                        i.bill_type,
                        i.erp_from,
                        i.remark reason,
                        i.store_id,
                        i.suppliers_no,
                        i.wms_num outer_bill_no,
                        A.FLSTUPDTIME bill_date
          from WMS_TAOBAO_OUTINSALES i
          left join TALCNTC A on i.WMS_NUM = A.NUM
         WHERE i.bill_type = 1
           and i.status = 0
           and i.flag = 2
           and i.WMS_NUM = A.NUM
           and i.bill_no = A.FSRCNUM
           and A.STAT = 7000
           and A.FSEND = 1
           and A.FLSTUPDTIME > sysdate - 7
           and (select sum(TD.Fplanqty)
                  from Talcntcdtl TD
                 where TD.num = a.num) <> 0
           and (select sum(tpd.frealqty)
                  from tpickupdtl tpd
                 where tpd.falcntc = a.num) <> 0
         ORDER BY i.WMS_NUM DESC)
 WHERE rownum <= 10


 /*自己查询使用版本*/
 select distinct i.bill_no      来源单号,
                i.store_id     门店序号,
                i.suppliers_no 仓库编码,
                i.wms_num      配货通知单号,
                A.FLSTUPDTIME  完成时间
  from WMS_TAOBAO_OUTINSALES i
  left join TALCNTC A on (i.WMS_NUM = A.NUM and i.bill_no = A.FSRCNUM)
 WHERE i.status = 0
   and A.STAT = 7000
   and A.FLSTUPDTIME > sysdate - 7
   and (select sum(TD.Fplanqty) from Talcntcdtl TD where TD.num = a.num) <> 0
   and (select sum(tpd.frealqty)from tpickupdtl tpd where tpd.falcntc = a.num) <> 0
ORDER BY i.WMS_NUM DESC


/*
    新的配货出库单详情拉取语句
    主要数据包括
        容器、单号、行号、商品代码、仓、数量、批号
*/
select distinct case
                  when p.fpalletcode is not null then
                   p.fpalletcode
                  else
                   p.fchestnum
                end FPALLETCODE,
                d.num,
                d.line,
                a.fcode skuId,
                i.cargo_area,
                d.FQTY operateNumber,
                to_date(d.flot, 'yyyy-mm-dd') PRODUCTIONDATE
  from TPICKUPDTLDTL d
  left join TPICKUPDTL p on (p.line = d.line and d.num = p.num)
  left join tarticle a on p.farticle = a.fgid
  left join wms_taobao_outinsales o on p.falcntc = o.wms_num
  left join wms_taobao_outinsalesitems i on i.bill_no = o.bill_no
 where p.falcntc = '00011707006081' --配货通知单号
   and i.bill_no = 'HSOHOMS170731056354' --来源单号
   and a.fcode = '110300100070'--商品
order by d.num, d.line

