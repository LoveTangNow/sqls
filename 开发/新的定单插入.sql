insert into tord
  (NUM,             --单号    √
   FTYPE,           --类型 (0=入库定单, 1=越库定单, 2=换货定单, 3=抵扣定单, 4-物流调拨, 5-直配)   √
   FVENDOR,         --供应商           查一下   √
   FEXPECTEDDATE,   --到货日期       有         √
   FEXPIREDATE,     --失效日期       有         √
   FLSTUPDTIME,     --更新时间       sysdate
   FCREATEDATE,     --生成日期       sysdate
   FQTYSTR,         --件数                有    √
   FRECEIVETIME,    --接收时间      sysdate
   STAT,            --状态                0     
   FBOOKTIME,       --预约开始时间          null
   FBOOKENDTIME,    --预约结束时间          null
   FBOOKER,         --预约人               null
   FRECEIVER,       --收货人               null
   FSTARTTIME,      --收货开始时间        sysdate ? null
   FENDTIME,        --收货结束时间        sysdate ? null
   FSRC,            --系统用户号         查询出来                 √
   FSRCNUM,         --来源单号          "HPO51170727300001"       √
   FJOBID,          --作业号           ""
   FCHECKED,        --选中       0
   FVOL,            --货品体积   null
   FDISAMOUNT,      --抵扣金额 0.000
   WMSEXCHANGETIME, --交换时间  null  
   FAPART,          --分货标志   0
   FPRINTTIME,      --打印时间      null
   FRTNINFO,        --退货信息     “”
   FTOTAL,          --定货金额    null
   FREALTOTAL,      --收货金额    PEICE 求和                    √
   FMEMO,           --备注        BALABALA                     √
   FOWNER,          --货主       OUNER
   FINWRH,          --收货仓位    "YN"
   FXFTIME,         --调拨更新时间 sysdate
   FLICENSE,        --对方车牌号  “”
   FBOXNO,          --对方柜号    “”        
   FDIRALCINFO)     --直配信息    “”
values
  ('00011707000016',
   1,
   10000221,
   to_date('28-07-2017 12:00:00', 'dd-mm-yyyy hh24:mi:ss'),
   to_date('29-07-2017 23:59:59', 'dd-mm-yyyy hh24:mi:ss'),
   to_date('28-07-2017 00:00:02', 'dd-mm-yyyy hh24:mi:ss'),
   to_date('27-07-2017 14:48:00', 'dd-mm-yyyy hh24:mi:ss'),
   '100.0',
   to_date('27-07-2017 14:48:00', 'dd-mm-yyyy hh24:mi:ss'),
   6500,
   null,
   null,
   null,
   1001640,
   to_date('27-07-2017 17:08:26', 'dd-mm-yyyy hh24:mi:ss'),
   to_date('27-07-2017 17:39:58', 'dd-mm-yyyy hh24:mi:ss'),
   'WDKH',
   'HPO51170727300001',
   '',
   0,
   null,
   0.0000,
   null,
   0,
   null,
   '',              --退货信息
   null,             
   0.0000,
   '',               --备注
   100081,
   'YN',
   null,
   '',
   '',
   '');


/* 
  主单据信息插入
    插入的主要信息有：
      单号、单据种类、供应商
      到货日期、到效日期
      更新时间、生成日期、件数、接收时间、状态
      系统用户号、来源单号
*/  
insert into tord
  (NUM,FTYPE,FVENDOR,FEXPECTEDDATE,FEXPIREDATE,
   FLSTUPDTIME,FCREATEDATE,FQTYSTR,FRECEIVETIME,
   STAT,FSRC,FSRCNUM,FREALTOTAL,FMEMO,FOWNER,FINWRH
   )
values
  ('00011708000001',4,10000221,
   to_date('28-08-2017 12:00:00', 'dd-mm-yyyy hh24:mi:ss'),
   to_date('29-08-2017 23:59:59', 'dd-mm-yyyy hh24:mi:ss'),
   sysdate,sysdate,'100.0',sysdate,0,
   'WDKH','HPO51170727300001',1230.0000,
   'balabala', 100081,'YN');