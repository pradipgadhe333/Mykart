
package com.learn.mycart.entities;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class PaymentInformation {
    
    @Column(name = "payment_id")
    private String paymentId;
    
    @Column(name = "payment_status")
    private String paymentStatus;
    
    @Column(name = "payment_Method")
    private String paymentMethod;
    
    //Constructors
    public PaymentInformation() {
    }
    
    public PaymentInformation(String paymentId, String paymentStatus, String paymentMethod) {
        this.paymentId = paymentId;
        this.paymentStatus = paymentStatus;
        this.paymentMethod = paymentMethod;
    }
    
    //Getters and Setters

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @Override
    public String toString() {
        return "PaymentInformation{" + "paymentId=" + paymentId + ", paymentStatus=" + paymentStatus + ", paymentMethod=" + paymentMethod + '}';
    }
    
    
    
}
