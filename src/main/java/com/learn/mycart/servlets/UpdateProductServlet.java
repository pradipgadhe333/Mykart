
package com.learn.mycart.servlets;

import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;


public class UpdateProductServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            //fetching updated product details from update_product form
            
            int productId=Integer.parseInt(request.getParameter("pId"));
           
            String pName = request.getParameter("pName");
            String pDesc = request.getParameter("pDesc");
            int pQuantity = Integer.parseInt(request.getParameter("quantity"));
            int pPrice = Integer.parseInt(request.getParameter("price"));
            int pDiscount = Integer.parseInt(request.getParameter("discount"));
            int catId = Integer.parseInt(request.getParameter("catId"));
            
            Session s = FactoryProvider.getFactory().openSession();
            Transaction tx = s.beginTransaction();
           
            //loading product object
            Product p = s.get(Product.class, productId);
            //updating fields
            p.setpName(pName);
            p.setpDesc(pDesc);
            p.setpQuantity(pQuantity);
            p.setpPrice(pPrice);
            p.setpDiscount(pDiscount);

            
            //get category by id
            CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
            Category category = categoryDao.getCategoryById(catId);
            p.setCategory(category);    
            
            tx.commit();
            s.close();
             
            HttpSession session = request.getSession();
            session.setAttribute("message", "Product details has been updated successfully...");
            response.sendRedirect("manage_products.jsp");
            return;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
