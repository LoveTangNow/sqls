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
                to_date(d.flot, 'yyyy-mm-dd') PRODUCTIONDATE,
                d.itemno,
                d.num
  from TPICKUPDTLDTL d
  left join TPICKUPDTL p on p.line = d.line
  left join tarticle a on p.farticle = a.fgid
  left join wms_taobao_outinsales o on p.falcntc = o.wms_num
  left join wms_taobao_outinsalesitems i on i.bill_no = o.bill_no
 where d.num = p.num
   and p.falcntc = '00011704000160'
   and i.wms_num = p.falcntc
   and i.bill_no = 'HSOHOMS170515031254'
   and i.wms_num = p.falcntc
   and o.bill_type = 1
   and o.status = 0
   and o.flag = 2
   and o.wms_num = p.falcntc
   and a.fcode = '110300100070';


select *
  from TPICKUPDTLDTL d
 where d.num = '00011704000147'
   and d.line = 7;


select * from tpickupdtldtl t where t.fqtystr like '%+%' and t.num in ('00011706004583');

select * from ll_miss_ok l where l.num in ('HSOHOMS170615039964','HSOHOMS170616040235','HSOHOMS170616040239');


update TPICKUPDTLDTL d
   set d.fqtystr = 3, d.fqty = '36.0000'
 where d.num = '00011704000147'
   and d.line = 7
   and d.itemno = 1;
update TPICKUPDTLDTL d
   set d.fqtystr = 2, d.fqty = '24.0000'
 where d.num = '00011704000147'
   and d.line = 7
   and d.itemno = 2;
commit;


