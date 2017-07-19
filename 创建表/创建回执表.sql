-- 创建商家的回执表
-- Create table
create table LRETURNBILL
(
  FNUM    VARCHAR2(30) not null,  --单号
  FTIME   DATE default SYSDATE,   --回执时间
  FTYPE   VARCHAR2(5),            --单据种类：CK,RK,GT,MT,PY,PK,YK
  FSTATE VARCHAR2(2) default 0,   --状态：0初始状态，1已经对账
  FMESSAGE VARCHAR2(200)          --描述
)
tablespace HDAPP

  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table LRETURNBILL
  is '成功移库单表';