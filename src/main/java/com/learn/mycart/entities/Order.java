
package com.learn.mycart.entities;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;                                                 
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "orders")
public class Order {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long orderId;

    @Column(name = "order_date")
    private String orderDate;
    
    @Column(name = "total_amount")
    private int totalAmount;
    
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL,orphanRemoval = true)
    private List<OrderStatus> orderStatuses=new ArrayList<>();
    
    @Embedded
    private ShippingDetails shippingDetails;
    
    @Column(name = "payment_option")
    private String paymentOption;
 
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
    
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderedItem> orderedItems = new ArrayList<>();
   
//    Constructors

    public Order() {
    }

    public Order(String orderDate, int totalAmount, List<OrderStatus> orderStatuses, ShippingDetails shippingDetails, String paymentOption, User user) {
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.orderStatuses=orderStatuses;
        this.shippingDetails = shippingDetails;
        this.paymentOption = paymentOption;
        this.user = user;
    }

   
    //Getters and Setters

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<OrderStatus> getOrderStatuses() {
        return orderStatuses;
    }

    public void setOrderStatuses(List<OrderStatus> orderStatuses) {
        this.orderStatuses = orderStatuses;
        
    }

    
    public ShippingDetails getShippingDetails() {
        return shippingDetails;
    }

    public void setShippingDetails(ShippingDetails shippingDetails) {
        this.shippingDetails = shippingDetails;
    }

    public String getPaymentOption() {
        return paymentOption;
    }

    public void setPaymentOption(String paymentOption) {
        this.paymentOption = paymentOption;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<OrderedItem> getOrderedItems() {
        return orderedItems;
    }

    public void setOrderedItems(List<OrderedItem> orderedItems) {
        this.orderedItems = orderedItems;
    }

     @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", user=" + user +
                ", shippingDetails=" + shippingDetails +
                ", orderDate=" + orderDate +
                ", orderStatus=" + orderStatuses.get(0).getStatusName() +
                ", totalAmount=" + totalAmount +
                ", paymentOption='" + paymentOption + '\'' +
                '}';
    }
    
}
