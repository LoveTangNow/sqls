create or replace package PWM_DEF is

  staUnAuditedId       constant integer := 0;
  staUnAuditedName     constant varchar2(50) := '未审核';
  staAuditedId         constant integer := 100;
  staAuditedName       constant varchar2(50) := '已审核';
  staBlankAuditedId    constant integer := 110;
  staBlankAuditedName  constant varchar2(50) := '审核后已作废';
  staBallanceId        constant integer := 120;
  staBallanceName      constant varchar2(50) := '审核后冲单(负单)';
  staReviseMendId      constant integer := 130;
  staReviseMendName    constant varchar2(50) := '审核后被修正';
  staReviseId          constant integer := 134;
  staReviseName        constant varchar2(50) := '审核后修正';
  staReviseOutId       constant integer := 140;
  staReviseOutName     constant varchar2(50) := '审核后修正单(负单)';
  staConfirmedId       constant integer := 5200;
  staConfirmedName     constant varchar2(50) := '已批准';
  staBlankOutedId      constant integer := 5210;
  staBlankOutedName    constant varchar2(50) := '作废';
  staInitialId         constant integer := 5300;
  staInitialName       constant varchar2(50) := '初始';
  staCheckedId         constant integer := 5400;
  staCheckedName       constant varchar2(50) := '已盘入';
  staUnCheckedId       constant integer := 5500;
  staUnCheckedName     constant varchar2(50) := '不盘入';
  staAuditedMendId     constant integer := 5530;
  staAuditedMendName   constant varchar2(50) := '审核已被修正';
  staPlanedId          constant integer := 6000;
  staPlanedName        constant varchar2(50) := '已计划';
  staBookedId          constant integer := 6100;
  staBookedName        constant varchar2(50) := '已预约';
  staRunningId         constant integer := 6200;
  staRunningName       constant varchar2(50) := '进行中';
  staPlanCaredRunningId       constant integer := 6300;
  staPlanCaredRunningName     constant varchar2(50) := '排车进行中';
  staPlanCaredId       constant integer := 6400;
  staPlanCaredName     constant varchar2(50) := '已排车';
  staFinishedId        constant integer := 6500;
  staFinishedName      constant varchar2(50) := '完成';
  staSentId            constant integer := 6600;
  staSentName          constant varchar2(50) := '已送达';
  staRecOverId         constant integer := 6700;
  staRecOverName       constant varchar2(50) := '已验货';
  staPrevExamId        constant integer := 6800;
  staPrevExamName      constant varchar2(50) := '已预检';
  staUsedId            constant integer := 7000;
  staUsedName          constant varchar2(50) := '已使用';
  staStopedId          constant integer := 1400;
  staStopedName        constant varchar2(50) := '已终止';
  staEndedId           constant integer := 1500;
  staEndedName         constant varchar2(50) := '已结束';

  --bin state
  staBinIdleID                 constant TBin.stat%type := 0;
  staBinIdleName               constant varchar2(50) := '空闲';
  staBinInUseWithPalletID      constant TBin.stat%type := 1;
  staBinInUseWithPalletName    constant varchar2(50) := '使用中';
  staBinErrorLockID            constant TBin.stat%type := 2;
  staBinErrorLockName          constant varchar2(50) := '异常锁定';
  staBinPickLockID             constant TBin.stat%type := 3;
  staBinPickLockName           constant varchar2(50) := '拣货锁定';
  staBinMoveLockID             constant TBin.stat%type := 4;
  staBinMoveLockName           constant varchar2(50) := '移库锁定';
  --Bin PutAway state
  staNotPutAwayLockID          constant TBin.Fputawaystat%type := 0;
  staNotPutAwayLockName        constant varchar2(50) := '未上架锁定';
  staPutAwayLockID             constant TBin.Fputawaystat%type := 1;
  staPutAwayLockName           constant varchar2(50) := '上架锁定';

  staNotSetBinLockID           constant TBin.Fsetbinlock%type := 0;
  staSetBinLockID              constant TBin.Fsetbinlock%type := 1;

  --Bin.Usage
  BinUsageEntireStoreName      constant varchar2(50) := '存储位';
  BinUsageMixedStoreName       constant varchar2(50) := '拣货存储位';
  BinUsagePickName             constant varchar2(50) := '拣货位';
  BinUsageScatteredPickName    constant varchar2(50) := '拆零拣货位';
  BinUsageStorePickBinName     constant varchar2(50) := '门店集货位';
  BinUsageVendorRtnBinName     constant varchar2(50) := '供应商退货位';
  BinUsageVendorTemp           constant varchar2(50) := '临时货位';
  BinUsageBigBinName           constant varchar2(50) := '大型货位';
  BinUsageCrossBinName         constant varchar2(50) := '中转货位';
  BinUsageQuickPickName        constant varchar2(50) := '直分拣货位';
  BinUsageQuickSeedName        constant varchar2(50) := '直分播种位';
  BinUsageQuickStoreName       constant varchar2(50) := '直分存储位';
  BinUageVendorRtnStoreName    constant varchar2(50) := '供应商退存位';
  BinUageSampleStoreName       constant varchar2(50) := '样品存储位';
  BinUageQuaInspStoreName      constant varchar2(50) := '质检存储位';

  ---TempBin  -- add for mrwms.
  TempBinRec                   constant varchar2(8) := '00000000';  --收货临时位
  TempBinRtn                   constant varchar2(8) := '00000002';  --退货临时位
  TempBinNone                  constant varchar2(8) := '00000001';  --无主货位
  TempBinApart                 constant Varchar2(8) := '00000004';  --分货货位
  TempBinHomeDispatch          constant Varchar2(8) := '00000005';  --宅配客户集货位
  --TOrd.Ftype
  typeNormalID                 constant TOrd.Ftype%type := 0;
  typeNormalName               constant varchar2(50) := '入库定单';
  typeCrossID                  constant TOrd.Ftype%type := 1;
  typeCrossName                constant varchar2(50) := '越库定单';
  typeExgGoodsID               constant TOrd.Ftype%type := 2;
  typeExgGoodsName             constant varchar2(50) := '换货定单';
  typeDISCHGID                 constant TOrd.Ftype%type := 3;
  typeDISCHGName               constant varchar2(50) := '抵扣定单';
  typeWMSXFID                  constant TOrd.Ftype%type := 4;
  typeWMSXFName                constant varchar2(50) := '物流调拨';
  typeDirAlcID                 constant TOrd.Ftype%type := 5;
  typeDirAlcName               constant varchar2(50) := '直配';

  --TPutAway.Fcls
  typeStkInName                constant varchar2(50) := '收货上架单';
  typeRtnName                  constant varchar2(50) := '退货上架单';
  typewsRtnName                constant varchar2(50) := '批发退货';
  --tPickUp.Fcategory
  categoryWholePalletName      constant varchar2(50) := '整托盘';
  categoryWholeSplitName       constant varchar2(50) := '整散件';
  categoryBreakName            constant varchar2(50) := '拆零';

  --tStoreRtnDtl.Ftype
  typeStoreRtnDtlGoodID        constant TBin.stat%type := 0;
  typeStoreRtnDtlGoodName      constant varchar2(50) := '好退';
  typeStoreRtnDtlWareDecID     constant TBin.stat%type := 1;
  typeStoreRtnDtlWareDecName   constant varchar2(50) := '仓库报损';
  typeStoreRtnDtlPriceDecID    constant TBin.stat%type := 2;
  typeStoreRtnDtlPriceDecName  constant varchar2(50) := '折价报损';
  typeStoreRtnDtlStoreDecID    constant TBin.stat%type := 3;
  typeStoreRtnDtlStoreDecName  constant varchar2(50) := '门店报损';
  typeStoreRtnDtlRefuseID      constant TBin.stat%type := 4;
  typeStoreRtnDtlRefuseName    constant varchar2(50) := '拒退';
  typeStoreRtnDtlVendorID      constant TBin.stat%type := 5;
  typeStoreRtnDtlVendorName    constant varchar2(50) := '退供应商';
  typeStoreRtnDtlAlcDiffID     constant TBin.stat%type := 6;
  typeStoreRtnDtlAlcDiffName   constant varchar2(50) := '配货差异';   --处理同"好退"
  typeStoreRtnAlcSteRtnID      constant TBin.stat%type := 7;
  typeStoreRtnAlcSteRtnName    constant varchar2(50) := '红冲退货';

  --TMoveInv.Ftype
  typeMoveInvStoreName         constant varchar2(50) := '门店退货';
  typeMoveInvInsideName        constant varchar2(50) := '内部移库';
  typeMoveInvWsName            constant varchar2(50) := '批发退货';
  typeMoveInvAdjBinName        constant varchar2(50) := '拣货位调整';
  typeMoveInvQuickName 	       constant varchar2(50) := '直分移库';
  typeMoveInvAlcDiffName       constant varchar2(50) := '配货差异';
  typeMoveInvRtnPutAwayName    constant varchar2(50) := '退货移库';
  typeMoveInvProcTaskRawOut    constant varchar2(50) := '加工领料';
  typeMoveInvProcTaskProdIn    constant varchar2(50) := '加工入库';
  typeMoveInvSealWRH           constant varchar2(50) := '封仓移库';
  typeMoveInvAlcMove           constant varchar2(50) := '配货移库';
  typeMoveInvQuaInsp           constant varchar2(50) := '质检移库';
  typeMoveInvRtnMove           constant varchar2(50) := '好退移库';
  typeMoveInvMoveNtc           constant varchar2(50) := '通知移库';

  --some special value
  defaultStkInNum              constant varchar2(50) := '-';          --缺省收货单号
  defaultPsn                   constant varchar2(50) := '00000001';   --缺省位置= 无主货位
  defaultEmpGid                constant integer := -1;                 --缺省员工GID
  UnknownVendor                 constant integer := 1;

  ArtCatScatteredName          constant TArticle.Fcategory%type := '拆零';
  ArtCatPackedName             constant TArticle.Fcategory%type := '整件';

  --tDecInv.Ftype
  typeDecInvPriceName          constant varchar2(50) := '折价报损';
  typeDecInvNormalName         constant varchar2(50) := '普通报损';

  --tDecInv.Fsource
  sourceDecInvStockTakeName        constant varchar2(50) := '盘点报损';
  sourceDecInvStoreRtnName         constant varchar2(50) := '门店退货';
  sourceDecInvwsRtnName            constant varchar2(50) := '批发退货';
  sourceDecInvWareHouseName        constant varchar2(50) := '仓库报损';
  sourceDecInvApartName            constant varchar2(50) := '分货';
  sourceDecInvStoreDecName         constant varchar2(50) := '门店报损';
  sourceDecInvAlcDiffName          constant varchar2(50) := '配货差异报损';
  sourceDecInvQuaInspName          constant varchar2(50) := '质检报损';


  --tDecInvDtl.Freason
  reasonDecInvExpiracyName         constant varchar2(50) := '到期';
  reasonDecInvBadName              constant varchar2(50) := '坏货';
  reasonDecInvLackName             constant varchar2(50) := '缺货';

  --tIncInv.Fsource
  sourceIncInvStockTakeName        constant varchar2(50) := '盘点报溢';
  sourceIncInvWareHouseName        constant varchar2(50) := '仓库报溢';
  sourceIncInvApartName            constant varchar2(50) := '分货报溢';
  sourceIncInvStoreRtnName         constant varchar2(50) := '门店退货';

  --tIncInv.Ftype
  typeIncInvNormalName             constant varchar2(50) := '普通报溢';

  --TRtnPick.Ftype
  typeRtnPickSelfName              constant varchar2(50) := '自行退货';
  typeRtnPickNtcName               constant varchar2(50) := '通知退货';

  --TVdrRtn.Ftype
  typeVdrNormalRtn                constant varchar2(10) := '正常退货';
  typeVdrChangeRtn                constant varchar2(10) := '换货退货';

  --tStockTakeDir.Fgensnapoption
  optionSnapOverrideID             constant tStockTakeDir.Fgensnapoption%type := 0;
  optionSnapLeaveID                constant tStockTakeDir.Fgensnapoption%type := 1;

  --TBillType
  typeBillStkInId              constant TSnapMend.Ftype%type := 1;
  typeBillStkInName            constant varchar2(50) := '收货单';
  typeBillPickUpId             constant TSnapMend.Ftype%type := 2;
  typeBillPickUpName           constant varchar2(50) := '拣货单';
  typeBillRplId                constant TSnapMend.Ftype%type := 3;
  typeBillRplName              constant varchar2(50) := '补货单';
  typeBillTranName             constant varchar2(50) := '转运单';
  typeBillRedeliverName        constant varchar2(50) := '重送单';
  typeBillAlcName              constant varchar2(50) := '配货单';
  typeBillCrossPickUpName      constant varchar2(50) := '播种拣货单';
  typeBillSeedPickUpName       constant varchar2(50) := '播种单';
  typeBillStockTakeName        constant varchar2(50) := '盘点单';

  --操作常量--
  optCreateJob             constant varchar2(20) := '生成配货作业';
  optGetAcQty              constant varchar2(20) := '取可用库存';
  optGetPickBin            constant varchar2(20) := '取货品拣货位';
  optGetQpcStr             constant varchar2(20) := '取货品包装规格';

  JobidForApart            constant varchar2(20) := '0000000001';
  ApartToShelf             constant varchar2(20) := '分货上架';

  --收货方式
  staStkInModeBillID        constant integer := 0;
  staStkInModeBillName      constant varchar2(20) := '单据收货';
  staStkInModeRFID          constant integer := 1;
  staStkInModeRFName        constant varchar2(20) := 'RF收货';
  staStkInModeChgOwnerID    constant integer := 2;
  staStkInModeChgOwnerName  constant varchar2(20) := '转货主收货';

  --托盘状态
  staPalletIdle           constant  integer      := 0;
  staPalletIdleName       constant  varchar(20)  := '空闲';      --空闲
  staPalletStkIning       constant  integer      := 1;
  staPalletStkIningName   constant  varchar2(20) := '收货中';    --收货中
  staPalletStkined        constant  integer      := 2;
  staPalletStkinedName    constant  varchar2(20) := '收货完成'; --收货完成, 可上架或到拆零码头
  staPalletOnBin          constant  integer      := 3;
  staPalletOnBinName      constant  varchar2(20) := '在存储/拣货位上';  --在存储/拣货位上,待拣货
  staPalletPicking        constant  integer      := 4;
  staPalletPickingName    constant  varchar2(20) := '拣货中';
  staPalletPicked         constant  integer      := 5;
  staPalletPickedName     constant  varchar2(20) := '拣货完成'; --拣货完成，可以集货
  staPalletOnClt          constant  integer      := 6;
  staPalletOnCltName      constant  varchar2(20) := '在集货位上';

  --周转箱复查标记
  staChestNoChkID           constant integer := 0;
  staChestNoChkName         constant varchar2(20) := '无需复查';
  staChestNeedChkID         constant integer := 1;
  staChestNeedChkName       constant varchar2(20) := '需要复查';
  staChestRunChkID          constant integer := 2;
  staChestRunChkName        constant varchar2(20) := '复查中';
  staChestEndChkID          constant integer := 3;
  staChestEndChkName        constant varchar2(20) := '复查结束';

  --拣货方法
  staPickMethodBillID       constant integer := 0;
  staPickMethodBillName     constant varchar2(20) := '手工单据';
  staPickMethodLabelID      constant integer := 1;
  staPickMethodLabelName    constant varchar2(20) := '打印标签';
  staPickMethodCapsID       constant integer := 2;
  staPickMethodCapsName     constant varchar2(20) := '电子标签';
  staPickMethodRFID         constant integer := 3;
  staPickMethodRFName       constant varchar2(20) := '手持终端';
  staPickMethodBreakChkID   constant integer := 4;
  staPickMethodBreakChkName constant varchar2(20) := '拆零复查';
  --补货途径
  staRPLWayBillID           constant integer := 0;
  staRPLWayBillName         constant varchar2(20) := '手工单据';
  staRPLWayLabelID          constant integer := 1;
  staRPLWayLabelName        constant varchar2(20) := '打印标签';
  staRPLWayCapsID           constant integer := 2;
  staRPLWayCapsName         constant varchar2(20) := '电子标签';
  staRPLWayRFID             constant integer := 3;
  staRPLWayRFName           constant varchar2(20) := '手持终端';

  --报表科目
  typeRPTStkin              constant varchar2(10) := '收货入库';
  typeRPTStkinBck           constant varchar2(10) := '退货出库';
  typeRPTPickOut            constant varchar2(10) := '拣货出库';
  typeRPTStoreRtn           constant varchar2(10) := '门店退货';
  typeRPTWsRtn              constant varchar2(10) := '批发退货';
  typeRPTDecInv             constant varchar2(10) := '库存损耗';
  typeRPTIncInv             constant varchar2(10) := '库存溢余';
  typeRPTMoveOut            constant varchar2(10) := '移库出';
  typeRPTMoveIn             constant varchar2(10) := '移库入';
  typeRPTArtMerge           constant varchar2(10) := '货品合并';
  typeRPTCollect            constant varchar2(10) := '集货上位';
  typeRPTShipOut            constant varchar2(10) := '装车出库';
  typeRPTStockTake          constant varchar2(10) := '盘点盈亏';
  typeRPTChangeLotOut       constant varchar2(10) := '批号变更出';
  typeRPTChangeLotIn        constant varchar2(10) := '批号变更入';
  typeRPTAlcDiff            constant varchar2(10) := '配货差异';
  typeRPTProcTaskOut        constant varchar2(10) := '加工出库';
  typeRPTProcTaskin         constant varchar2(10) := '加工入库';
  typeRPTFreRtnIn           constant varchar2(10) := '生鲜退货入';
  typeRPTFreRtnOut          constant varchar2(10) := '生鲜退货出';
  typeRPTFreOrdIn           constant varchar2(10) := '生鲜采购入';
  typeRPTQuaInspOut         constant varchar2(10) := '质检出库';

  --业务调整原因
  typeStockAdjLessStkin     constant varchar2(20) := '少收';
  typeStockAdjMorePick      constant varchar2(20) := '多拣';
  typeStockAdjLessPick      constant varchar2(20) := '少拣';
  typeStockAdjVdrLessRtn    constant varchar2(20) := '供应商少退';
  typeStockAdjStoreLessRtn  constant varchar2(20) := '门店少退';
  --直分作业收货货位分配 收货标记
  typeStkInInitialId        constant integer      := 0;   --'未收货'
  typeStkInRunningId        constant integer      := 1;   -- '收货中'
  typeAdjStkInFinishedId    constant integer      := 2;   --'收货完成(调整)'
  typeNormStkInFinishedId   constant integer      := 3;   --收货完成(正常)
  --排车单 排车类型
  typeShipTypeNormal        constant varchar2(20) := '正常排车';
  typeShipTypeAbnormal      constant varchar2(20) := '非正常排车';
  typeShipTypeAbnormalShip  constant varchar2(20) := '非正常出车';
  typeShipPlanStkOut        constant varchar2(20) := '排车出货';
  typeShipPlanByBill        constant varchar2(20) := '单据排车';
  --转运单 转运类型
  typeTranStkin             constant varchar2(20) := '转运收货';
  typeTranShipReDeliver     constant varchar2(20) := '装车重送';
  --配货差异调整方法
  typeWarehouseLoss         constant varchar2(20) := '少配-仓库报损';
  typeRtnVendor             constant varchar2(20) := '少配-退供应商';
  typeRtnNormal             constant varchar2(20) := '少配-好退';
  typeLogisticsDrawBack     constant varchar2(20) := '多配-仓库收回';
  typeStoreOwn              constant varchar2(20) := '多配-门店保留';
  typeNormalAlc             constant varchar2(20) := '没有差异';
  --工种
  typeDriverName            constant varchar2(20) := '司机';
  typeShipperName           constant varchar2(20) := '装车员';
  --默认邮编
  const_DefZip              constant varchar2(20) := '000000';
  --线路体系类型
  typeSerial_Store          constant varchar2(20) := '门店';
  typeSerial_Zip            constant varchar2(20) := '邮政编码';
  --默认的仓卡号
  const_DefWRHCard          constant varchar2(14) := '0';

  --常量
  const_Goods               constant varchar2(10) := '货品';
  const_Store               constant varchar2(10) := '门店';

  --逆向收货单的前缀，以示区分是哪种单据
  typeStkinBillIncInv       constant varchar2(10) := 'INCV';  --溢余单
  typeStkinBillProcTask     constant varchar2(10) := 'PROC';  --加工任务单
  typeStkinBillSTERTN       constant varchar2(10) := 'STER';  --门店退货单

  --外部资料来源的几种方式
  const_ImportByHand        constant varchar2(20) := '界面录入';
  const_ImportFromFile      constant varchar2(20) := '文件导入';
  const_ImportFromMis       constant varchar2(20) := 'mis导入';

  --跨仓位移库业务类型
  TypeWrhMoveByMoveInvID    constant TALLOWWRH.FType%type := 0;
  TypeWrhMoveByMoveInvName  constant varchar2(50) := '移库';
  TypeWrhMoveByPickBinID    constant TALLOWWRH.FType%type := 1;
  TypeWrhMoveByPickBinName  constant varchar2(50) := '拣货位调整';
  TypeWrhMoveByPutAwayID    constant TALLOWWRH.FType%type := 2;
  TypeWrhMoveByPutAwayName  constant varchar2(50) := '上架调整';

  --默认托盘码
  Const_DefPalletCode       constant varchar2(50):= '-';

  --消息订阅常量定义
  const_BinArtExpiracyID          constant TSYSTEMMSCBPARAM.FUID%type := 1;
  const_BinArtExpiracyName        constant TSYSTEMMSCBPARAM.FMSCBNAME%type := '货品到效期提醒';
  const_OrdExpireDateID           constant TSYSTEMMSCBPARAM.FUID%type := 2;
  const_OrdExpireDateName         constant TSYSTEMMSCBPARAM.FMSCBNAME%type := '定单失效日期提醒';
  const_UnSealWrhBySpecDateID     constant TSYSTEMMSCBPARAM.FUID%type := 3;
  const_UnSealWrhBySpecDateName   constant TSYSTEMMSCBPARAM.FMSCBNAME%type := '指定日期解仓提醒';

  -- 新增两个常量，用于定于拣货次序’-‘和-1 dsj 2009-7-27 增加
  const_DefPickOrder       constant varchar2(5) := '-';
  const_DefSeedPickOrder   constant integer    := -1;

  --通用游标
  type CursorRef IS REF CURSOR;

   type TArticleItem is record
  (
    Article TBinArticles.Farticle%type,
    Munit TBinArticles.Fmunit%type,
    QpcStr TBinArticles.Fqpcstr%type,
    QtyStr TBinArticles.Fqtystr%type,
    Qpc TBinArticles.fqpc%type,
    Qty TBinArticles.fqty%type,
    DateReceived TBinArticles.Fdatereceived%type,
    Expiracy TBinArticles.Fexpiracy%type,
    Lot TBinArticles.Flot%type,
    StkInNum TBinArticles.Fstkinnum%type,
    Weight TBinArticles.FWeight%type,
    Cls VARCHAR2(10),
    Vendor TBinArticles.FVendor%type,
    Owner TBinArticles.FOwner%type,
    WrhCard Tbinarticles.Fwrhcard%type,
    InPrice TBINARTICLES.FINPRICE%TYPE,
    Stat TBinArticles.Stat%Type,
    ProduceDate TBinArticles.FProduceDate%type,
    Pallet TPallet.FBarCode%Type
  );
  type TArticleItems is table of TArticleItem index by binary_integer;

   type TClientItem is record
  (
    Client TStore.FCode%type,
    ClientName TStore.Fname%type,
    Position TStore.FPosition%type,
    Zip TStore.Fzip%type,
    Phone TStore.FPhone%type,
    Mobile TStore.Fmobile%type,
    SrcCode TStore.Fsrccode%type,
    PayType TStore.Fpaytype%type,
    Memo TStore.Fmemo%type
  );

  type TQpcItem is record
  (
    QpcStr TARTICLEQPC.FQPCSTR%type,
    Qpc TARTICLEQPC.FQPC%type,
    Munit TARTICLEQPC.FMUNIT%type,
    Length TARTICLEQPC.FLENGTH%type,
    Width TARTICLEQPC.FWIDTH%type,
    Height TARTICLEQPC.FHEIGHT%type,
    Weight TARTICLEQPC.FWEIGHT%type,
    PAQ TARTICLEQPC.FPAQ%type,
    PAQStandard TARTICLEQPC.FPAQSTANDARD%type
  );
  type TQpcItems is table of TQpcItem index by binary_integer;

  type TPickItem is record
  (
    PickWay integer,
    QpcStr TBINARTICLES.FQPCSTR%type,
    Qpc TBINARTICLES.FQPC%type,
    PickArea TPICKAREA.FCODE%type,
    PickMethod TPICKAREA.FPICKMETHOD%type,
    PickBin TBIN.FCODE%type,
    Qty TBINARTICLES.FQTY%type
  );
  type TPickItems is table of TPickItem index by binary_integer;

  type TBinItem is record
  ( BinCode TBin.Fcode%type,
    Article TBinArticles.Farticle%type,
    Munit TBinArticles.Fmunit%type,
    QpcStr TBinArticles.Fqpcstr%type,
    QtyStr TBinArticles.Fqtystr%type,
    Qpc TBinArticles.fqpc%type,
    Qty TBinArticles.fqty%type,
    DateReceived TBinArticles.Fdatereceived%type,
    Expiracy TBinArticles.Fexpiracy%type,
    Lot TBinArticles.Flot%type,
    StkInNum TBinArticles.Fstkinnum%type,
    Weight TBinArticles.FWeight%type,
    Vendor TBinArticles.FVendor%type,
    Owner TBINARTICLES.FOWNER%TYPE,
    WRHCard TBINARTICLES.FWRHCARD%TYPE,
    ProduceDate TBinArticles.FProduceDate%type
  );
  type TBinItems is table of TBinItem index by binary_integer;
  type TRplNum is table of varchar2(14) index by binary_integer;
  type TArray is table of varchar2(14) index by binary_integer;
  type TArrayInt is table of number index by binary_integer;
  syscode varchar2(4);
  sysSortALength Integer;
  sysSortBLength Integer;
  sysSortCLength Integer;
  sysSortDLength Integer;

  --为兼容客户端的程序而建立的一个空的存储过程
  FUNCTION NONECHK (
	  PINUM	    IN	TYPEDEF.TBILLNUM%TYPE,
	  PIOPER	  IN	TYPEDEF.TOPER%TYPE,
	  PITOSTAT  IN	TYPEDEF.TSTAT%TYPE,
	  POERR_MSG OUT	TYPEDEF.TMSG%TYPE
  ) RETURN INT;

end PWM_DEF;