-- Create table
create table LTRANSACTIONLOGS
(
  FID      VARCHAR2(10) not null,  --事务编号
  FTIME    DATE default sysdate,   --事务时间
  FSTATE   VARCHAR2(4),            --事务状态
  FMESSAGE VARCHAR2(200)           --事务描述
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