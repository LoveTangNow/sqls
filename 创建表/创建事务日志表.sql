-- Create table
create table LTRANSACTIONLOGS
(
  FID      VARCHAR2(10) not null,
  FTIME    DATE default sysdate,
  FSTATE   VARCHAR2(4),
  FMESSAGE VARCHAR2(200),
  FBILL    VARCHAR2(100)
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
comment on table LTRANSACTIONLOGS
  is '事务日志表';
-- Add comments to the columns 
comment on column LTRANSACTIONLOGS.FID
  is '序号';
comment on column LTRANSACTIONLOGS.FTIME
  is '时间';
comment on column LTRANSACTIONLOGS.FSTATE
  is '状态';
comment on column LTRANSACTIONLOGS.FMESSAGE
  is '信息';
comment on column LTRANSACTIONLOGS.FBILL
  is '单号';
-- Create/Recreate primary, unique and foreign key constraints 
alter table LTRANSACTIONLOGS
  add constraint FID primary key (FID)
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