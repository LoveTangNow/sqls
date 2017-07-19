--移库单后台回执
select * from tmoveinv t where t.num in ('00011706000080');
select * from tmoveinvdtl t where t.num in ('00011706000080');


update tmoveinvdtl td
   set td.frealqtystr = td.fqtystr, td.frealqty = td.fqty
 where td.num in ('00011706000080');

update tmoveinv t
   set t.stat = 100, t.flstupdtime = sysdate
 where t.num in ('00011706000080');


SELECT distinct t.num outer_bill_no, t.flstupdtime bill_date
    from TMOVEINV t, wms_taobao_bill_history h
  where t.stat = 100
    and h.type = 3
    and t.flstupdtime >= h.update_time
    and t.flstupdtime > sysdate - 7
    and t.ftype <> '门店退货'
  ORDER BY t.num





--盘盈单后台回执
update tincinv t
   set t.stat = 100
 where t.num in ('00011707000002', '00011707000003');

 update tincinvdtl t
   set t.flot         = '20170701',
       t.fproducedate = to_date('20170701', 'yyyyMMdd')
 where t.num in ('00011707000002', '00011707000003')
   and t.flot = '-';  


 SELECT distinct t.num outer_bill_no, t.flstupdtime bill_date
  from TINCINV t
 where t.stat = 100
   and t.num not in
       (select ll_move_ok.num from ll_move_ok where ll_move_ok.type = 2)
   and t.FLSTUPDTIME > sysdate - 20
 ORDER BY t.num;
