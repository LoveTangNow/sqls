
--清理中间数据
--查询中间数据
select *
  from Tbinartbill ba
 where ba.farticle in
       (select a.fgid from Tarticle a where a.fcode in ('110101300040'));



--删除中间数据
delete from Tbinartbill ba
 where ba.farticle in
       (select a.fgid
          from Tarticle a
         where a.fcode in ('110101300040'));
commit;
