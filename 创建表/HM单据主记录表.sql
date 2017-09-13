-- Create table
create table LHMBILLS
(
  FID                  NUMBER not null,
  FUUID                VARCHAR2(50) not null,
  FBILL                VARCHAR2(30) not null,
  FBILLTYPE            VARCHAR2(5) not null,
  FTIME                DATE default sysdate not null,
  FSYSTEMCODE          VARCHAR2(10),
  FWAREHOUSECODE       VARCHAR2(10),
  FMAINDEPTCODE        VARCHAR2(10),
  FREMARK              VARCHAR2(50),
  FTOWAREHOUSECODE     VARCHAR2(20),
  FTODEPTCODE          VARCHAR2(20),
  FCUSTOMERCODE        VARCHAR2(20),
  FCUSTOMERNAME        VARCHAR2(20),
  FCUSTOMERADDR        VARCHAR2(50),
  FISPALLETINPUT       VARCHAR2(2),
  FPLANARRIVALDATE     DATE,
  FINVALIDDATE         DATE,
  FSUBBIZTYPE          NUMBER,
  FFROMWAREHOUSECODE   VARCHAR2(10),
  FFROMDEPTCODE        VARCHAR2(10),
  FFROMSUPPLIERCODE    VARCHAR2(10),
  FFROMSUPPLIERNAME    VARCHAR2(10),
  FFROMSUPPLIERCONTACT VARCHAR2(20),
  FWMSBILL             VARCHAR2(30) not null
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
comment on table LHMBILLS
  is 'HM单据主记录表';
-- Add comments to the columns 
comment on column LHMBILLS.FID
  is '序号';
comment on column LHMBILLS.FUUID
  is '盒马UUID';
comment on column LHMBILLS.FBILL
  is '盒马单号';
comment on column LHMBILLS.FBILLTYPE
  is '单据类型：101 采购入，102 配货入，103 调拨入，104 退仓入，201 配货出，202 批发出，203 退仓出，205 退供出，206 调拨出；';
comment on column LHMBILLS.FTIME
  is '单据到达时间';
comment on column LHMBILLS.FSYSTEMCODE
  is '调用方身份标识';
comment on column LHMBILLS.FWAREHOUSECODE
  is '仓库号';
comment on column LHMBILLS.FMAINDEPTCODE
  is '主单部门编码';
comment on column LHMBILLS.FREMARK
  is '备注';
comment on column LHMBILLS.FTOWAREHOUSECODE
  is '调入仓库编码';
comment on column LHMBILLS.FTODEPTCODE
  is '调入仓库部门code';
comment on column LHMBILLS.FCUSTOMERCODE
  is '批发出库销售客户编码';
comment on column LHMBILLS.FCUSTOMERNAME
  is '批发出库销售客户姓名';
comment on column LHMBILLS.FCUSTOMERADDR
  is '批发出库销售客户地址';
comment on column LHMBILLS.FISPALLETINPUT
  is '是否容器入库';
comment on column LHMBILLS.FPLANARRIVALDATE
  is '到货日期';
comment on column LHMBILLS.FINVALIDDATE
  is '失效日期';
comment on column LHMBILLS.FSUBBIZTYPE
  is '二级业务类型:对于采购，就有：1, "越库订货";2, "正常订货"';
comment on column LHMBILLS.FFROMWAREHOUSECODE
  is '发出仓库编码';
comment on column LHMBILLS.FFROMDEPTCODE
  is '发出仓库部门code';
comment on column LHMBILLS.FFROMSUPPLIERCODE
  is '供应商编码';
comment on column LHMBILLS.FFROMSUPPLIERNAME
  is '供应商姓名';
comment on column LHMBILLS.FFROMSUPPLIERCONTACT
  is '供应商联系方式';
comment on column LHMBILLS.FWMSBILL
  is 'WMS单号';
-- Create/Recreate primary, unique and foreign key constraints 
alter table LHMBILLS
  add constraint LHMBILLSP primary key (FBILL)
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