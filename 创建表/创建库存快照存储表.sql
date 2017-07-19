--创建库存快照 存储表
--谁的货  在哪个位置 什么货 什么批次 有多少箱子
-- Create table
create table LINVENTORYSNAPSHOT
(
  FOWNER  VARCHAR2(6), -- 货主
  FTYPE   VARCHAR2(8), -- 货位
  FCODE   VARCHAR2(14),-- 商品代码
  FLOT    VARCHAR2(8), -- 批号
  FQTYSTR VARCHAR2(8), -- 箱数
  FQTY    NUMBER(24),  -- 数量
  FQPC    NUMBER(24),  -- 包装件数
  FTIME   DATE default sysdate,
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
comment on table LINVENTORYSNAPSHOT
  is '库存快照表';