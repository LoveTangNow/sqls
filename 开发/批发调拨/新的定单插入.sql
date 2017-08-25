
/* 
  主单据信息插入
    插入的主要信息有：
      单号、单据种类、供应商
      到货日期、到效日期
      更新时间、生成日期、件数、接收时间、状态
      系统用户号、来源单号
*/  
insert into tord(
  NUM,FTYPE,FVENDOR,FEXPECTEDDATE,FEXPIREDATE,
  FLSTUPDTIME,FCREATEDATE,FQTYSTR,FRECEIVETIME,
  STAT,FSRC,FSRCNUM,FREALTOTAL,FMEMO,FOWNER,FINWRH)
values(
  '00011708000001',4,10000221,
  to_date('28-08-2017 12:00:00', 'dd-mm-yyyy hh24:mi:ss'),
  to_date('29-08-2017 23:59:59', 'dd-mm-yyyy hh24:mi:ss'),
  sysdate,sysdate,'100.0',sysdate,0,
  'WDKH','HPO51170727300001',1230.0000,
  'balabala', 100081,'YN');

--insertOrdBillMainData
insert into tord(
  NUM,FTYPE,FVENDOR,FEXPECTEDDATE,FEXPIREDATE,
  FLSTUPDTIME,FCREATEDATE,FQTYSTR,FRECEIVETIME,
  STAT,FSRC,FSRCNUM,FREALTOTAL,FMEMO,FOWNER,FINWRH)
values(
  #wmsbill#,#bizType#,#fromSupplierCode#,
  #planArrivalDate#,
  #invalidDate#,
  sysdate,sysdate,#alnumber#,sysdate,0,
  #systemusercode#,#outBizCode#,#allprice#,
  #remark#, #owner#,'YN')


--插入定单子单据
insert into torddtl(
  NUM,LINE,FARTICLE,FMUNIT,FQPCSTR,FQTYSTR,FQPC,FQTY,FPRICE,
  FRECEIVEDQTY,FPREVQTY,FVDRPRICE,FREALPRICE,FCHECKEDPRICE,
  FVENDOR,FOWNER,FPRODUCEDATE)
values(
  '00011708000001',2,10956863,'瓶','1*1','100',1.0000,100.0000,0.0000,
  0.0000,0.0000,0.0000,0.0000,0,
  null,100081,null);


insert into torddtl(
  NUM,LINE,FARTICLE,FMUNIT,FQPCSTR,FQTYSTR,FQPC,FQTY,FPRICE,
  FRECEIVEDQTY,FPREVQTY,FVDRPRICE,FREALPRICE,FCHECKEDPRICE,
  FVENDOR,FOWNER,FPRODUCEDATE)
(select '00011708000001' num,NVL(( select max(too.line)+1 from torddtl too where too.num = '00011708000001'),1) line ,
      t.fgid ,taq.fmunit ,t.fspec ,'100' FQTYSTR ,taq.fqpc ,100.0000 FQTY ,0.0000 FPRICE ,
      0.0000 FRECEIVEDQTY ,0.0000 FPREVQTY ,0.0000 FVDRPRICE ,0.0000 FREALPRICE,0 FCHECKEDPRICE ,
      null FVENDOR ,t.fowner ,null FPRODUCEDATE
    from tarticle t 
    left join TARTICLEQPC taq on taq.farticle = t.fgid
  where t.fcode = '010100209249'  )


insert into torddtl(
  NUM,LINE,FARTICLE,FMUNIT,FQPCSTR,FQTYSTR,FQPC,FQTY,FPRICE,
  FRECEIVEDQTY,FPREVQTY,FVDRPRICE,FREALPRICE,FCHECKEDPRICE,
  FVENDOR,FOWNER,FPRODUCEDATE)
(select #wmsnum# num,
      NVL(( select max(too.line)+1 from torddtl too where too.num = #wmsnum#),1) line ,
      t.fgid ,taq.fmunit ,t.fspec ,#planCount# /taq.fqpc FQTYSTR ,
      taq.fqpc ,#planCount# FQTY ,#unitPrice# FPRICE ,
      0.0000 FRECEIVEDQTY ,0.0000 FPREVQTY ,0.0000 FVDRPRICE ,0.0000 FREALPRICE,0 FCHECKEDPRICE ,
      null FVENDOR ,t.fowner ,null FPRODUCEDATE
    from tarticle t 
    left join TARTICLEQPC taq on taq.farticle = t.fgid
  where t.fcode = #itemCode# )

insert into torddtl(
    NUM,LINE,
    FARTICLE,FMUNIT,FQPCSTR,FQTYSTR,
    FQPC,FQTY,FPRICE,
    FVENDOR,FOWNER)
(select #wmsnum# num,
      NVL(( select max(too.line)+1 from torddtl too where too.num = #wmsnum#),1) line ,
      t.fgid ,taq.fmunit ,t.fspec ,#planCount# /taq.fqpc FQTYSTR ,
      taq.fqpc ,#planCount# FQTY ,#unitPrice# FPRICE ,
      null FVENDOR ,t.fowner 
    from tarticle t 
    left join TARTICLEQPC taq on taq.farticle = t.fgid
  where t.fcode = #itemCode# )
