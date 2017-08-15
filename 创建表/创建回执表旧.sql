-- 创建商家的回执表
-- Create table
create table LRETURNBILLO
(
  FNUM     VARCHAR2(30) not null, -- 单号
  FTIME    DATE default SYSDATE,  -- 时间
  FTYPE    VARCHAR2(5) not null,  -- 种类
  FSTATE   VARCHAR2(2) default 0, -- 状态（0 初始状态,1 对账完成状态）
  FMESSAGE VARCHAR2(200)          -- 信息
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
comment on table LRETURNBILLO
  is '回执表';
-- Add comments to the columns 
comment on column LRETURNBILLO.FNUM
  is '单号';
comment on column LRETURNBILLO.FTIME
  is '回执时间';
comment on column LRETURNBILLO.FTYPE
  is '单据种类：CK,RK,GT,MT,PY,PK,YK';
comment on column LRETURNBILLO.FSTATE
  is '状态：0初始状态，1已经对账';
comment on column LRETURNBILLO.FMESSAGE
  is '描述';
-- Create/Recreate primary, unique and foreign key constraints 
alter table LRETURNBILLO
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