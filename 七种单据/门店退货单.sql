-- 门店退货单 旧的总单据拉取语句
    select distinct i.bill_no,
                    i.bill_type,
                    i.erp_from,
                    i.remark reason,
                    i.store_id,
                    i.suppliers_no,
                    i.wms_num outer_bill_no,
                    o.FLSTUPDTIME bill_date
      from WMS_TAOBAO_OUTINSALES i
      left join TSTORERTNNTC o on i.WMS_NUM = o.NUM
     WHERE i.bill_type = #queryType#
       and i.flag = #flag#
       and i.status = 0
       and o.stat = 7000
       and i.WMS_NUM = o.NUM
       and i.bill_no = o.FSRCNUM
       and o.FLSTUPDTIME > sysdate - 15
     ORDER BY i.WMS_NUM

 --新的总单据拉取语句 （已经更新到上海库 北京还没有更新）
  select distinct i.bill_no,
        i.bill_type,
        i.erp_from,
        i.remark reason,
        i.store_id,
        i.suppliers_no,
        i.wms_num outer_bill_no,
        o.FLSTUPDTIME bill_date
   from TSTORERTN s
   left join WMS_TAOBAO_OUTINSALES i on i.wms_num = s.frtnntcnum
   left join TSTORERTNNTC o on i.bill_no = o.FSRCNUM
  where i.status = 0
    and s.stat = 100
    and o.stat = 7000
    and s.FLSTUPDTIME > sysdate - 15



-- 门店退货单 详情查询语句 （已部署）
 select distinct i.id,
                i.OPERATE_NUMBER operateNumber,
                i.SKU_ID skuId,
                i.cargo_area,
                i.operate_piece,
                i.PRODUCT_DATE PRODUCTIONDATE,
                i.TOTAL_PRICE totalprice
  from wms_taobao_outinsalesitems i
 where i.bill_no = #billNo#
   and i.wms_num = #outerBillNo#


-- 门店退货单 单货品详情查询语句 （已部署）
   select distinct s.line line,
                s.frealqty anumber,
                a.fcode sku,
                i.cargo_area area,
                i.operate_piece piece,
                (NVL(s.fproducedate,
                     to_date(to_char(sysdate - 2, 'yyyyMMdd'), 'yyyyMMdd'))) adate,
                a.fprice * s.frealqty totolprice
  from TSTORERTNDTL s
  left join tarticle a on s.farticle = a.fgid
  left join wms_taobao_outinsales o on s.FRTNNTCNUM = o.wms_num
  left join wms_taobao_outinsalesitems i on i.bill_no = o.bill_no
 where a.fcode = #reason#
   and i.bill_no = #billNo#
   and s.FRTNNTCNUM = #outerBillNo#
