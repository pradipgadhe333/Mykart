
package com.learn.mycart.dao;

import com.learn.mycart.entities.OrderStatus;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class OrderStatusDao {
 
    private final SessionFactory factory;

    public OrderStatusDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    //save the order status to the database
    public void saveOrderStatus(OrderStatus orderStatus) {
        Session session = this.factory.openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            session.save(orderStatus);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    // Update the order status in the database
    public void updateOrderStatus(OrderStatus orderStatus) {
        Session session = this.factory.openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            session.update(orderStatus);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
    
}
