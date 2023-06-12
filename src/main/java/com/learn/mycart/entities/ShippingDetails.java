
package com.learn.mycart.entities;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ShippingDetails {
    
   @Column(name = "billing_name")
   private String billingName;
   
   @Column(name = "billing_phone")
   private String billingPhone;

   @Column(name = "shipping_address")
   private String shippingAddress;
    
   //Constructors
    public ShippingDetails() {
    }

    public ShippingDetails(String billingName, String billingPhone, String shippingAddress) {
        this.billingName = billingName;
        this.billingPhone = billingPhone;
        this.shippingAddress = shippingAddress;
    }
   
    
   //Getters and setters
    public String getBillingName() {
        return billingName;
    }

    public void setBillingName(String billingName) {
        this.billingName = billingName;
    }

    public String getBillingPhone() {
        return billingPhone;
    }

    public void setBillingPhone(String billingPhone) {
        this.billingPhone = billingPhone;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    @Override
    public String toString() {
        return "ShippingDetails{" + "billingName=" + billingName + ", billingPhone=" + billingPhone + ", shippingAddress=" + shippingAddress + '}';
    }
   
    
}
