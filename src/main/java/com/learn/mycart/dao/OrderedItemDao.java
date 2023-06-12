
package com.learn.mycart.dao;

import com.learn.mycart.entities.OrderedItem;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class OrderedItemDao {
    
    private SessionFactory sessionFactory;

    public OrderedItemDao(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    //get OrderItems by order id
    public List<OrderedItem> getOrderedItemsByOrderId(long orderId)
    {
        Session s = this.sessionFactory.openSession();
        Query q = s.createQuery("from OrderedItem as i where i.order.orderId =: id");
        q.setParameter("id", orderId);
        List<OrderedItem> items = q.list();
        return items;
    }
    
}
