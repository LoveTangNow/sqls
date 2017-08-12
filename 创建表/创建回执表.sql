-- 创建商家的回执表
-- Create table
create table LRETURNBILL
(
  FNUM     VARCHAR2(30) not null,
  FTIME    DATE default SYSDATE,
  FTYPE    VARCHAR2(5) not null,
  FSTATE   VARCHAR2(2) default 0,
  FMESSAGE VARCHAR2(200)
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
  is '回执表';
-- Add comments to the columns 
comment on column LRETURNBILL.FNUM
  is '单号';
comment on column LRETURNBILL.FTIME
  is '回执时间';
comment on column LRETURNBILL.FTYPE
  is '单据种类：CK,RK,GT,MT,PY,PK,YK';
comment on column LRETURNBILL.FSTATE
  is '状态：0初始状态，1已经对账';
comment on column LRETURNBILL.FMESSAGE
  is '描述';
-- Create/Recreate primary, unique and foreign key constraints 
alter table LRETURNBILL
  add constraint PRIMARYKEY primary key (FNUM, FTYPE)
  using index 
  tablespace HDAPP
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );