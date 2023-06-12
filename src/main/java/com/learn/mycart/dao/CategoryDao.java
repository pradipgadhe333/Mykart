
package com.learn.mycart.dao;

import com.learn.mycart.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao {
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    //save the category to db
    public int saveCategory(Category cat)
    {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId =(int) session.save(cat);
        
        tx.commit();
        session.close();
        return catId;
    }
    
    //get all categories from db
    public List<Category> getCategories()
    {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from Category");
        List<Category> list = q.list();
        return list;
    }
    
    //get category by id
    public Category getCategoryById(int cid)
    {
        Category cat = null;
        try{
            
            Session s = this.factory.openSession();
            cat = s.get(Category.class, cid);
            s.close();
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return cat;
    }
    
}
