
package com.learn.mycart.dao;

import com.learn.mycart.entities.Order;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class OrderDao {
    
    private SessionFactory sessionFactory;

    public OrderDao(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    public long saveOrder(Order order)
    {
        Session session = this.sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        long orderId=(long)session.save(order);
        
        tx.commit();
        session.close();
        return orderId;
    }
    
    public List<Order> getAllOrders()
    {
        Session session = this.sessionFactory.openSession();
        Query<Order> query = session.createQuery("from Order order by orderId desc", Order.class);
        List<Order> orders = query.list();
        return orders;
    }
    
    //get order by its id
    public Order getOrderById(long orderId)
    {
        Session s = this.sessionFactory.openSession();
        Order order=null;
        order = (Order)s.get(Order.class, orderId );
        return order;
    }
    
    //get order by its user id
    public List<Order> getAllOrdersByUserId(int uId)
    {
        Session s = this.sessionFactory.openSession();
        Query q = s.createQuery("from Order as o where o.user.userId =: id order by o.id desc");
        q.setParameter("id", uId);
        List<Order> orders =q.list();
       
        return orders;
        
    }
    
    public void updateOrder(Order order)
    {
        Session s = this.sessionFactory.openSession();
        Transaction tx = s.beginTransaction();
        s.update(order);
        tx.commit();
        s.close();
    }
    
    public void deleteOrder(long orderId)
    {
        Session s = this.sessionFactory.openSession();
        Transaction tx = s.beginTransaction();
        Order order = s.get(Order.class, orderId);
        s.delete(order);
        
        tx.commit();
        s.close();
    }
}