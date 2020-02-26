package com.keji09.erp.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 账单
 */
@Entity
@Table(name = "pdd_Bill")
public class BillEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GenericGenerator(name = "uuidhex", strategy = "uuid.hex")
    @GeneratedValue(generator = "uuidhex")
    @Column(name = "id", length = 32)
    private String id;

    @Column(name = "_money")
    private Integer money = 0 ;

    /**
     * 新增时间
     */
    @Column(name = "_add_time")
    private Date addTime = new Date();

    /**
     * 1.红包派充值
     * 6.创建优惠券
     */
    @Column(name = "_type")
    private Integer type;

    /**
     * 充值类型 1.充值 2.消费
     */
    @Column(name = "_form")
    private Integer form;

    @Column(name = "_member_id")
    private String memberId;

    @Column(name = "_activity_id")
    private String activityId;

    public Integer getForm() {
        return form;
    }

    public void setForm(Integer form) {
        this.form = form;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getMoney() {
        return money;
    }

    public void setMoney(Integer money) {
        this.money = money;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
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
}
