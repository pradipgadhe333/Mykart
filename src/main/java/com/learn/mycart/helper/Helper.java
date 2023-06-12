
package com.learn.mycart.helper;

import java.util.HashMap;
import java.util.Map;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class Helper {
    
    public static String get10Words(String desc)
    {
        String[] strs=desc.split(" ");
        
        if(strs.length>10)
        {
            String res="";
            for(int i=0;i<10;i++)
            {
                res=res+strs[i] + " ";
            }
            return(res + "...");
        }else{
            
            return(desc + "...");
            
        }
            
    }
    
    //count number of users and products 
    public static Map<String,Long> getCounts(SessionFactory factory)
    {
        Session session = factory.openSession();
        String q1="Select count(*) from User";
        String q2="Select count(*) from Product";
        String q3="Select count(*) from Order";
        
        Query query1 = session.createQuery(q1);
        Query query2 = session.createQuery(q2);
        Query query3 = session.createQuery(q3);
        
        Long userCount =(Long) query1.list().get(0);
        Long productCount =(Long) query2.list().get(0);
        Long orderCount =(Long) query3.list().get(0);
        
        Map<String,Long> map= new HashMap();
        map.put("userCount", userCount);
        map.put("productCount", productCount);
        map.put("orderCount", orderCount);
        
                
        session.close();
        return map;
    }
    
}
