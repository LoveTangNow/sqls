--查询一个表结构

select *
  from collateitem
 where collateitem.collateno =
       (select collate.no
          from collate
         where collate.tablename = 'TVENDORRTNREQ');