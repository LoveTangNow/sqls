--补全缺少批次的供应商退货单（废弃掉了）
update TVENDORRTNDTL d
   set d.flot         = '20170701',
       d.fproducedate = to_date('01-07-2017', 'dd-mm-yyyy')
 where d.num = '00011707000073'
   and d.flot = '-';


--检索未回执的 供应商退货单的查询语句
select *
  from (select distinct i.bill_no,
                        i.bill_type,
                        i.erp_from,
                        i.remark reason,
                        i.store_id,
                        i.suppliers_no,
                        i.wms_num outer_bill_no,
                        req.FLSTUPDTIME bill_date
          from WMS_TAOBAO_OUTINSALES i
          left join TVENDORRTN n on i.wms_num = n.frtnreqnum
          left join TVENDORRTNREQ req on req.num = n.frtnreqnum
         where i.bill_type = 2
           and i.flag = 1
           and i.STATUS = 0
           and n.stat = 100
           and req.stat = 6500
           and req.flstupdtime > sysdate - 7
         ORDER BY i.WMS_NUM)
 WHERE rownum <= 15;



---新的 加了日期不全的 供应商退货单详情查询语句
--#outerBillNo#
--#billNo#

select distinct d.line,
              d.FREALQTY operateNumber,
              a.fcode skuId,
              i.cargo_area,
              a.fprice * d.frealqty totalprice,
              i.operate_piece,
              (NVL(d.fproducedate,
                 to_date(to_char(sysdate - 2, 'yyyyMMdd'), 'yyyyMMdd'))) PRODUCTIONDATE
  from TVENDORRTNDTL d
  left join tarticle a on a.fgid = d.farticle
  left join wms_taobao_outinsales o on o.wms_num = d.frtnreqnum
  left join wms_taobao_outinsalesitems i on i.bill_no = o.bill_no
  left join TVENDORRTN t on t.num = d.num
where d.frtnreqnum = '00011707000007'
   and o.bill_no = 'HPR5220170706300018'
   and o.bill_type = 2
   and o.status = 0
   and o.flag = 1
   and t.stat = 100
ORDER BY d.frtnreqnum DESC