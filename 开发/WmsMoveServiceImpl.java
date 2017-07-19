package com.taobao.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.taobao.api.request.WdkChainBillNoticeRequest;
import com.taobao.api.request.WdkChainBillNoticeRequest.OutStockDetailBo;
import com.taobao.api.request.WdkChainBillNoticeRequest.PalletBO;
import com.taobao.checkmodel.BillBack;
import com.taobao.dao.WdkChainBillDao;
import com.taobao.dao.WmsCheckDao;
import com.taobao.service.WmsMoveService;
import com.taobao.tbvo.TBBillHistory;
import com.taobao.tbvo.TBOutStockDetailBo;
import com.taobao.util.TBConstant;
import com.taobao.util.TaoBaoAPI;
import com.wms.util.Configer;
import com.wms.util.WmsTool;

/**
 * 2016-08-21 移库单回执
 * 
 * @author haosi
 *         510101对应我们的20和21开头的货位或者说货区，510104对应我们91开头的货位，510102对应我们92开头的货位，在盒马的仓位定义范围内
 *         ， 20开头的货位移动到21，21移动到20，这2种情况下的移库单我们就不需要回传给对方，其余的才需要回传
 * 
 */
public class WmsMoveServiceImpl implements WmsMoveService {
  protected static Logger log = Logger.getLogger(WmsMoveServiceImpl.class.getName());
  
  @Resource
  WdkChainBillDao wdkChainBillDao;
  

  /**
   * 移库单回执
   */
  public void writeWmsMoveBillNotice() {
    log.info("****移库单回执 job start...");
    int totalSize = 0;
    String moveWmsWrhCodes = Configer.getString("tb_move_wrh");
    String[] wmsWrhCodeArr = moveWmsWrhCodes.split(",");
    //List<WdkChainBillNoticeRequest> wdkChainBillNoticeList = new ArrayList();
    for (int i = 0; i < wmsWrhCodeArr.length; i++) {
      String fromTo = wmsWrhCodeArr[i];
      String[] fromToArr = fromTo.split("-");
      int size = getMoveBill(fromToArr[0], fromToArr[1]);
      totalSize = totalSize + size;
      log.info("totalSize:"+totalSize);
    }
    if (totalSize > 0) {
      freshflag();
    }

    log.info("****移库单回执 job end.");

  }
  
  
  private void freshflag(){
    TBBillHistory tbBillHistory = new TBBillHistory();
    //tbBillHistory.setUpdateTime(date);
    tbBillHistory.setType(3);
    tbBillHistory.setWmsNum("-");
    try {
      wdkChainBillDao.updateBillHistory(tbBillHistory);
    } catch (Exception e) {
      e.printStackTrace();

    }
  }
  
  public void BackMoveBill(String fromWrh, String toWrh) {
    WdkChainBillNoticeRequest request = new WdkChainBillNoticeRequest();
  }

  /**
   * 移库单detail
   */
  public int getMoveBill(String fromWrh, String toWrh) {
    int size = 0;
    //boolean flag = true;
    String wmsNum = "0";
    try {
      //while (flag) {
        List<WdkChainBillNoticeRequest> wdkChainBillNoticeList = wdkChainBillDao
            .selectWMSTMOVEINV(wmsNum);

        log.info("fromWrh:" + fromWrh + ",toWrh:" + toWrh + ",移库单Size="
            + wdkChainBillNoticeList.size());
        if (CollectionUtils.isNotEmpty(wdkChainBillNoticeList)) {
          
          for (WdkChainBillNoticeRequest wdkChainBillNoticeRequest : wdkChainBillNoticeList) {
            log.info("bill-num:"+wdkChainBillNoticeRequest.getOuterBillNo());
          }
          
          for (WdkChainBillNoticeRequest wdkChainBillNoticeRequest : wdkChainBillNoticeList) {
            
            log.info("---移库单之一回执开始---");
            // TODO
            wmsNum = wdkChainBillNoticeRequest.getOuterBillNo();
            log.info("wmsNum："+wmsNum);
            
            wdkChainBillNoticeRequest.setReason("正常调整");
            wdkChainBillNoticeRequest.setBillType(5L);
            wdkChainBillNoticeRequest.setStoreId(TBConstant.DC_NO);
            wdkChainBillNoticeRequest.setSuppliersNo(TBConstant.DC_NO);
            wdkChainBillNoticeRequest.setBillNo(fromWrh + toWrh
                + wdkChainBillNoticeRequest.getOuterBillNo());
            TBOutStockDetailBo tmpbo = new TBOutStockDetailBo();
            tmpbo.setWmsNum(wdkChainBillNoticeRequest.getOuterBillNo());
            tmpbo.setOutCargoArea(fromWrh);
            tmpbo.setInCargoArea(toWrh);
            List<TBOutStockDetailBo> tbdetailList = wdkChainBillDao.selectWMSTMOVEINVDetail(tmpbo);
            
            List<OutStockDetailBo> detailList = new ArrayList<OutStockDetailBo>();
            
            if (tbdetailList != null && tbdetailList.size() > 0) {
              
              log.info("---移库单详单组装开始---");
              
              //size = tbdetailList.size();
              //List<OutStockDetailBo> detailList = new ArrayList();
              for (TBOutStockDetailBo tbOutStockDetailBo : tbdetailList) {

                OutStockDetailBo outStockDetailBo = new OutStockDetailBo();
                outStockDetailBo.setOperateNumber(tbOutStockDetailBo.getOperateNumber());
                outStockDetailBo.setSkuId(tbOutStockDetailBo.getSkuId());
                if (tbOutStockDetailBo.getOutCargoArea() != null
                    && tbOutStockDetailBo.getOutCargoArea().length() > 2) {
                  outStockDetailBo.setOutCargoArea(Configer.getString("tb_sy_"
                      + tbOutStockDetailBo.getOutCargoArea().substring(0, 2)));
                }
                if (tbOutStockDetailBo.getInCargoArea() != null
                    && tbOutStockDetailBo.getInCargoArea().length() > 2) {
                  outStockDetailBo.setInCargoArea(Configer.getString("tb_sy_"
                      + tbOutStockDetailBo.getInCargoArea().substring(0, 2)));
                }
                List<PalletBO> palletBOList = new ArrayList<PalletBO>();
                PalletBO tjson = new PalletBO();
                tjson.setOperateNumber(tbOutStockDetailBo.getOperateNumber());
                tjson.setProductionDate(tbOutStockDetailBo.getWmsProductionDate());
                if (tbOutStockDetailBo.getWmsProductionDate() != null)
                  tjson.setBatchCode(WmsTool.dateFromat2String(
                      tbOutStockDetailBo.getWmsProductionDate(), "yyyyMMdd"));
                palletBOList.add(tjson);
                outStockDetailBo.setPalletList(palletBOList);

                detailList.add(outStockDetailBo);

              }
              wdkChainBillNoticeRequest.setStockItemList(detailList);
              size += tbdetailList.size();//作为标识 当有数据的时候我们才会更新时间。
              log.info("---移库单详单组装结束---");
            }
            
            
            //组装完成之后 我们开始回执
            if (tbdetailList != null && tbdetailList.size() > 0) {

              // 移库单:回执时在单号前增加前缀：51YK、52YK
              wdkChainBillNoticeRequest.setOuterBillNo(TBConstant.DC_NO + "YK"
                  + wdkChainBillNoticeRequest.getOuterBillNo());
              
              log.info(wdkChainBillNoticeRequest.getOuterBillNo());

              boolean resp = TaoBaoAPI.writeWdkChainBillNotice(wdkChainBillNoticeRequest);

              wdkChainBillNoticeRequest.setOuterBillNo(wdkChainBillNoticeRequest.getOuterBillNo()
                  .substring(4));

              if (!resp) {
                
                log.error("移库单回执异常*****移库单回执信息:" + JSONObject.toJSONString(wdkChainBillNoticeRequest)); 
                log.info("移库单回执 resp=" + resp + ",wmsNo="+ wmsNum);
                
              }else {
                
                log.info("移库单回执成功*****移库单回执信息:" + JSONObject.toJSONString(wdkChainBillNoticeRequest));
                log.info("移库单回执 resp=" + resp + ",wmsNo="+ wmsNum);
                
                BillBack billBack = new BillBack();
                billBack.setNum(wdkChainBillNoticeRequest.getOuterBillNo());
                billBack.setType("1");
                wdkChainBillDao.RecordBills(billBack);
                
              }
            }
            log.info("---移库单之一回执结束---");
          }
        } //else {
          //flag = false;
         // break;
       // }
     // }
    } catch (Exception e) {
      e.printStackTrace();
      log.info("fromWrh:" + fromWrh + ",toWrh:" + toWrh + ",get 移库单detail error." + e.getMessage());

    }
    return size;
  }

  public WdkChainBillDao getWdkChainBillDao() {
    log.info("getWdkChainBillDao");
    return wdkChainBillDao;
  }

  public void setWdkChainBillDao(WdkChainBillDao wdkChainBillDao) {
    log.info("setWdkChainBillDao");
    this.wdkChainBillDao = wdkChainBillDao;
  }

}
