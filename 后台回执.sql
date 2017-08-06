--移库单后台回执
select * from tmoveinv t where t.num in ('00011706000080');
select * from tmoveinvdtl t where t.num in ('00011706000080');


update tmoveinvdtl td
   set td.frealqtystr = td.fqtystr, td.frealqty = td.fqty
 where td.num in ('00011706000080'); --替换为相应的单号
update tmoveinv t
   set t.stat = 100, t.flstupdtime = sysdate
 where t.num in ('00011706000080'); --替换为相应的单号
 commit;
 --以上数据执行完成之后过15分钟查看有没有回执成功

select * from ll_move_ok l where l.type = 1 and l.num = '00011706000080'--替换为相应的单号
--有数据表明回执成功，没有数据表明没有回执成功


select *
  from (select distinct tm.num outer_bill_no, tm.flstupdtime bill_date
          from tmoveinv tm
          left join tmoveinvdtl tmd on tm.num = tmd.num
         where ((tmd.ffrompsn like '2%' and tmd.fdestpsn like '9%') or
               (tmd.ffrompsn like '91%' and tmd.fdestpsn like '92%') or
               (tmd.ffrompsn like '9%' and tmd.fdestpsn like '2%') or
               (tmd.ffrompsn like '92%' and tmd.fdestpsn like '91%'))
           and tm.num not in
               (select l.num
                  from ll_move_ok l
                 where l.type = 1
                   and l.time >= to_date('20170713', 'yyyymmdd'))
           and tm.flstupdtime >= to_date('20170713', 'yyyymmdd')
           and tm.ftype <> '门店退货'
           and tm.stat = 100
         order by tm.flstupdtime)
 WHERE rownum <= 1

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
