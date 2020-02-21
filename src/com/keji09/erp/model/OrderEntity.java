package com.keji09.erp.model;

import com.pdd.pop.sdk.http.api.response.PddDdkOrderListIncrementGetResponse;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "inv_order")
public class OrderEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
    @GeneratedValue(generator = "uuidhex")
    @Column(name = "id", length = 32)
    private String id;
    /**
     * 推广订单编号
     */
    @Column(name = "_order_sn")
    private String orderSn;
    /**
     * 拼多多id
     */
    @Column(name = "_goods_id")
    private Long goodsId;

    /**
     * 商品名称
     */
    @Column(name = "_goods_name")
    private String goodsName;
    /**
     * 商品缩略图
     */
    @Column(name = "_goods_thumbnail_url")
    private String goodsThumbnailUrl;

    /**
     *购买商品的数量
     */
    @Column(name = "_goods_quantity")
    private Long goodsQuantity;

    /**
     *订单中sku的单件价格，单位为分
     */
    @Column(name = "_goods_price")
    private Long goodsPrice;

    /**
     * 实际支付金额，单位为分
     */
    @Column(name = "_order_amount")
    private Long orderAmount;

    /**
     * 推广位id
     */
    @Column(name = "_p_id")
    private String pId;

    /**
     * 佣金比例，千分比
     */
    @Column(name = "_promotion_rate")
    private Long promotionRate;

    /**
     * 佣金金额，单位为分
     */
    @Column(name = "_promotion_amount")
    private Long promotionAmount;


    /**
     * 订单状态： -1 未支付; 0-已支付；1-已成团；2-确认收货；3-审核成功；4-审核失败（不可提现）；5-已经结算；8-非多多进宝商品（无佣金订单）
     */
    @Column(name = "_order_status")
    private Integer orderStatus;

    /**
     * 订单状态描述
     */
    @Column(name = "_order_status_desc")
    private String orderStatusDesc;

    /**
     * 订单生成时间，UNIX时间戳
     */
    @Column(name = "_order_create_time")
    private Long orderCreateTime;

    /**
     * 订单支付时间
     */
    @Column(name = "_order_pay_time")
    private Long orderPayTime;

    /**
     *成团时间
     */
    @Column(name = "_order_group_success_time")
    private Long orderGroupSuccessTime;

     /**
     *审核时间
     */
    @Column(name = "_order_verify_time")
    private Long orderVerifyTime;
     /**
     *最后更新时间
     */
    @Column(name = "_order_modify_at")
    private Long orderModifyAt;
     /**
     * 自定义参数
     */
    @Column(name = "_custom_parameters")
    private String customParameters;
     /**
     *是否是 cpa 新用户，1表示是，0表示否
     */
    @Column(name = "_cpa_new")
    private Integer cpaNew;
     /**
     *订单推广类型
     */
    @Column(name = "_type")
    private Integer type;
     /**
     *结算时间
     */
    @Column(name = "_order_settle_time")
    private Long orderSettleTime;
     /**
     *多多客工具id
     */
    @Column(name = "_auth_duo_id")
    private Long authDuoId;
     /**
     *结算批次号
     */
    @Column(name = "_batch_no")
    private String batchNo;
     /**
     *确认收货时间
     */
    @Column(name = "_order_receive_time")
    private Long orderReceiveTime;
     /**
     *成团编号
     */
    @Column(name = "_group_id")
    private Long groupId;
     /**
     *审核失败原因
     */
    @Column(name = "_fail_reason")
    private String failReason;
     /**
     *订单ID
     */
    @Column(name = "_order_id")
    private String orderId;
     /**
     *招商多多客id
     */
    @Column(name = "_zs_duo_id")
    private Long zsDuoId;

    /**
     * 用户id
     */
    @Column(name = "_member_id")
    private String memberId;

    /**
     * 商家id
     */
    @Column(name = "_activity_id")
    private String activityId;

    /**
     * 站点
     */
    @Column(name = "_tep_id")
    private String tepId;

    /**
     * 修改订单数据
     */
    public void setO(PddDdkOrderListIncrementGetResponse.OrderListGetResponseOrderListItem o ){
        this.orderSn=o.getOrderSn();
        this.goodsId=o.getGoodsId();
        this.goodsName=o.getGoodsName();
        this.goodsThumbnailUrl=o.getGoodsThumbnailUrl();
        this.goodsQuantity=o.getGoodsQuantity();
        this.goodsPrice=o.getGoodsPrice();
        this.orderAmount=o.getOrderAmount();
        this.pId=o.getPId();
        this.promotionRate=o.getPromotionRate();
        this.promotionAmount=o.getPromotionAmount();
        this.orderStatus=o.getOrderStatus();
        this.orderStatusDesc=o.getOrderStatusDesc();
        this.orderCreateTime=o.getOrderCreateTime();
        this.orderPayTime=o.getOrderPayTime();
        this.orderGroupSuccessTime=o.getOrderGroupSuccessTime();
        this.orderVerifyTime=o.getOrderVerifyTime();
        this.orderModifyAt=o.getOrderModifyAt();
        this.customParameters=o.getCustomParameters();
        this.cpaNew=o.getCpaNew();
        this.type=o.getType();
        this.orderSettleTime=o.getOrderSettleTime();
        this.authDuoId=o.getAuthDuoId();
        this.batchNo=o.getBatchNo();
        this.orderReceiveTime=o.getOrderReceiveTime();
        this.groupId=o.getGroupId();
        this.failReason=o.getFailReason();
        this.orderId=o.getOrderId();
        this.zsDuoId=o.getZsDuoId();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrderSn() {
        return orderSn;
    }

    public void setOrderSn(String orderSn) {
        this.orderSn = orderSn;
    }

    public Long getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Long goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsThumbnailUrl() {
        return goodsThumbnailUrl;
    }

    public void setGoodsThumbnailUrl(String goodsThumbnailUrl) {
        this.goodsThumbnailUrl = goodsThumbnailUrl;
    }

    public Long getGoodsQuantity() {
        return goodsQuantity;
    }

    public void setGoodsQuantity(Long goodsQuantity) {
        this.goodsQuantity = goodsQuantity;
    }

    public Long getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(Long goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public Long getOrderAmount() {
        return orderAmount;
    }

    public void setOrderAmount(Long orderAmount) {
        this.orderAmount = orderAmount;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public Long getPromotionRate() {
        return promotionRate;
    }

    public void setPromotionRate(Long promotionRate) {
        this.promotionRate = promotionRate;
    }

    public Long getPromotionAmount() {
        return promotionAmount;
    }

    public void setPromotionAmount(Long promotionAmount) {
        this.promotionAmount = promotionAmount;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOrderStatusDesc() {
        return orderStatusDesc;
    }

    public void setOrderStatusDesc(String orderStatusDesc) {
        this.orderStatusDesc = orderStatusDesc;
    }

    public Long getOrderCreateTime() {
        return orderCreateTime;
    }

    public void setOrderCreateTime(Long orderCreateTime) {
        this.orderCreateTime = orderCreateTime;
    }

    public Long getOrderPayTime() {
        return orderPayTime;
    }

    public void setOrderPayTime(Long orderPayTime) {
        this.orderPayTime = orderPayTime;
    }

    public Long getOrderGroupSuccessTime() {
        return orderGroupSuccessTime;
    }

    public void setOrderGroupSuccessTime(Long orderGroupSuccessTime) {
        this.orderGroupSuccessTime = orderGroupSuccessTime;
    }

    public Long getOrderVerifyTime() {
        return orderVerifyTime;
    }

    public void setOrderVerifyTime(Long orderVerifyTime) {
        this.orderVerifyTime = orderVerifyTime;
    }

    public Long getOrderModifyAt() {
        return orderModifyAt;
    }

    public void setOrderModifyAt(Long orderModifyAt) {
        this.orderModifyAt = orderModifyAt;
    }

    public String getCustomParameters() {
        return customParameters;
    }

    public void setCustomParameters(String customParameters) {
        this.customParameters = customParameters;
    }

    public Integer getCpaNew() {
        return cpaNew;
    }

    public void setCpaNew(Integer cpaNew) {
        this.cpaNew = cpaNew;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Long getOrderSettleTime() {
        return orderSettleTime;
    }

    public void setOrderSettleTime(Long orderSettleTime) {
        this.orderSettleTime = orderSettleTime;
    }

    public Long getAuthDuoId() {
        return authDuoId;
    }

    public void setAuthDuoId(Long authDuoId) {
        this.authDuoId = authDuoId;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public Long getOrderReceiveTime() {
        return orderReceiveTime;
    }

    public void setOrderReceiveTime(Long orderReceiveTime) {
        this.orderReceiveTime = orderReceiveTime;
    }

    public Long getGroupId() {
        return groupId;
    }

    public void setGroupId(Long groupId) {
        this.groupId = groupId;
    }

    public String getFailReason() {
        return failReason;
    }

    public void setFailReason(String failReason) {
        this.failReason = failReason;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Long getZsDuoId() {
        return zsDuoId;
    }

    public void setZsDuoId(Long zsDuoId) {
        this.zsDuoId = zsDuoId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }

    public String getTepId() {
        return tepId;
    }

    public void setTepId(String tepId) {
        this.tepId = tepId;
    }
}
