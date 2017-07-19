--出库  查询的是配货通知单
select distinct i.bill_no,
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
   and (select sum(TD.Fplanqty) from Talcntcdtl TD where TD.num = a.num) <> 0
 ORDER BY i.WMS_NUM DESC;




--配货出库 关联的是拣货单明细的明细。
select distinct case
                  when p.fpalletcode is not null then
                   p.fpalletcode
                  else
                   p.fchestnum
                end FPALLETCODE,
                p.FCHESTNUM,
                d.line,
                a.fcode skuId,
                i.cargo_area,
                d.FQTY operateNumber,
                a.fprice * d.fqty totalprice,
                i.operate_piece,
                d.flot,
                --to_date(d.flot, 'yyyy-mm-dd') PRODUCTIONDATE,
                d.itemno,
                d.num
  from TPICKUPDTLDTL d
  left join TPICKUPDTL p on p.line = d.line
  left join tarticle a on p.farticle = a.fgid
  left join wms_taobao_outinsales o on p.falcntc = o.wms_num
  left join wms_taobao_outinsalesitems i on i.bill_no = o.bill_no
 where d.num = p.num
   and p.falcntc = '00011706000242'
   and i.wms_num = p.falcntc
   and i.bill_no = 'HSOHOMS170608038083'
   and i.wms_num = '00011706000242'
   and o.bill_type = 1
   --and o.status = 0
   and o.flag = 2
   and o.wms_num = '00011706000242';

   
select * from tpickupdtldtl t where t.num = '00011706000238';-- for update


--单号，行号，子行号，批号，规格，箱数，包装，数量，生产日期。

