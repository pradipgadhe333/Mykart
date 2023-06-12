
package com.learn.mycart.servlets;

import com.learn.mycart.entities.Order;
import com.learn.mycart.entities.OrderStatus;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;


public class UpdateOrderServlet extends HttpServlet {

  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            //servlet for
            //update order 
            //cancel order
            
            String op=request.getParameter("operation");
            
            if(op.trim().equals("updateorder"))
            {
                // Retrieve the order ID and selected status from the request
                long orderId = Long.parseLong(request.getParameter("order_id"));
                String order_status = request.getParameter("order_status");
      
                Session s = FactoryProvider.getFactory().openSession();
                Transaction tx = s.beginTransaction();

                //loading order object
                Order order=s.get(Order.class, orderId);

                // Create an instance of OrderStatus and set its value 
                OrderStatus orderStatus=new OrderStatus();
                orderStatus.setStatusName(order_status);
                
                LocalDateTime statusDate = LocalDateTime.now();
                DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy, hh:mm a"); // Create a DateTimeFormatter object with the desired format
                String statusUpdatedDate = statusDate.format(dateFormat); // Use the DateTimeFormatter object to format the date as a string
                
                orderStatus.setStatusDate(statusUpdatedDate);
                orderStatus.setOrder(order);
                
                
                // Add the orderStatus to the existing list of orderStatuses
                order.getOrderStatuses().add(orderStatus);
                
                s.save(orderStatus); // Save the OrderStatus entity
               
                tx.commit();
                s.close();


                HttpSession session = request.getSession();
                session.setAttribute("message", "Order Status has been updated successfully...");
                response.sendRedirect("allorders.jsp");
                return;
            
            }else if(op.trim().equals("cancelorder")){
                
                //cancel order
                long orderId = Long.parseLong(request.getParameter("order_id").trim());
                
                String order_status="Cancelled";
                
                Session s = FactoryProvider.getFactory().openSession();
                Transaction tx = s.beginTransaction();

                //loading order object
                Order order=s.get(Order.class, orderId);

                // Create an instance of OrderStatus and set its value 
                OrderStatus orderStatus=new OrderStatus();
                orderStatus.setStatusName(order_status);
                
                LocalDateTime statusDate = LocalDateTime.now();
                DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy, hh:mm a");
                String statusUpdatedDate = statusDate.format(dateFormat);
                
                orderStatus.setStatusDate(statusUpdatedDate);
                orderStatus.setOrder(order);
                
                
                // Add the orderStatus to the existing list of orderStatuses
                order.getOrderStatuses().add(orderStatus);
                
                s.save(orderStatus); // Save the OrderStatus entity
               
                tx.commit();
                s.close();


                HttpSession session = request.getSession();
                session.setAttribute("message", "Your order has been cancelled !!");
                response.sendRedirect("myorder.jsp");
                return;
                
            }
            
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
