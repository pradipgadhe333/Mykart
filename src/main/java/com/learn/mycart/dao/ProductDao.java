
package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;

public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    // Method to save a new product to db
    public boolean saveProduct(Product product)
    {
        boolean f=false;
        try{
            
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            
            session.save(product);
            
            tx.commit();
            session.close();
            f=true;
            
        }catch(Exception e)
        {
            e.printStackTrace();
            f=false;
        }
        return f;
    }
   
    //update product
    public void updateProduct(Product product) 
    {
        Session s = this.factory.openSession();
        Transaction tx = s.beginTransaction();
        s.update(product);
        tx.commit();
        s.close();
    }
        
    // Method to delete an existing product
    public void deleteProductById(int productId)
    {
        Session s = this.factory.openSession();
        Transaction tx = s.beginTransaction();
        
        // Get the product entity object by its id
        Product product = s.get(Product.class, productId);
       
         if (product == null) {
            throw new IllegalArgumentException("Product with id " + productId + " not found");
        }

        // Delete the product entity object
        s.delete(product);
        
        tx.commit();
        s.close();
        
    }
  
    
    //get all products
    public List<Product> getAllProducts()
    {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from Product");
        List<Product> products = q.list();
        s.close();
        return products;
    }
    
    // Method to get a product by its ID
    public Product getProductById(int productId)
    {
        Session s = this.factory.openSession();
        Product product = null;
        product = (Product) s.get(Product.class, productId);
        s.close();
        return product;
    }
    
    //get all products of given category
    public List<Product> getAllProductsByCatId(int cid)
    {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from Product as p where p.category.categoryId =: id");
        q.setParameter("id", cid);
        List<Product> list =q.list();
        s.close();
        return list;
    }
    
    //search products by keyword
    public List<Product> searchProducts(String keyword)
    {
        Session s = this.factory.openSession();
        Criteria c = s.createCriteria(Product.class);
   
        if (keyword != null) {
            String[] searchTerms = keyword.split("\\s+"); // Split the keyword into individual search terms

            c.createAlias("category", "cat"); // Create an alias for the category association

            Disjunction disjunction = Restrictions.disjunction();
            
            for (String term : searchTerms) {
                disjunction.add(Restrictions.ilike("pName", "%" + term + "%"));
                disjunction.add(Restrictions.ilike("cat.categoryTitle", "%" + term + "%"));
            }

            c.add(disjunction);
        }
        
        List<Product> products=c.list();
        s.close();
        return products;
    }
}
