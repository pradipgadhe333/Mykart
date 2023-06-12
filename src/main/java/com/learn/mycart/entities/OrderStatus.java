
package com.learn.mycart.entities;

import java.time.LocalDateTime;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "order_status")
public class OrderStatus {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) 
    private int id;
   
    @Column(name = "status_name")
    private String statusName;
   
    @Column(name = "status_date")
    private String statusDate;
   
    @ManyToOne(fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JoinColumn(name = "order_id")
    private Order order;
   
   
    // Constructors, getters, and setters
    public OrderStatus() {
        // Default constructor
    }

    public OrderStatus(String statusName, String statusDate, Order order) {
        this.statusName = statusName;
        this.statusDate = statusDate;
        this.order = order;
    }
    
    // Getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getStatusDate() {
        return statusDate;
    }

    public void setStatusDate(String statusDate) {
        this.statusDate = statusDate;
    }

    
    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    @Override
    public String toString() {
        return "OrderStatus{" + "id=" + id + ", statusName=" + statusName + ", statusDate=" + statusDate + ", order=" + order + '}';
    }

   
   
}
