
package com.learn.mycart.servlets;

import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

@MultipartConfig
public class ProfileEditServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
           
            try{
                
                //fetch user data
                
                String userName = request.getParameter("user_name");
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");
                String userPhone = request.getParameter("user_phone");
                String userAddress = request.getParameter("user_address");
                
                //get the user from the session...
                
                HttpSession s = request.getSession();
                User user = (User) s.getAttribute("current-user");
                
                user.setUserName(userName);
                user.setUserEmail(userEmail);
                user.setUserPassword(userPassword);
                user.setUserPhone(userPhone);
                user.setUserAddress(userAddress);
                
                //update to database...
                
                Session hibernateSession=FactoryProvider.getFactory().openSession();
                Transaction tx = hibernateSession.beginTransaction();
              
                hibernateSession.update(user);
              
                tx.commit();
                hibernateSession.close();
              
                //out.println("<h1>Profile successfully updated...</h1>");
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Profile details updated successfully...");
               
                if(user.getUserType().equals("admin"))
                {
                    response.sendRedirect("admin.jsp");
                }else{
                    response.sendRedirect("index.jsp");
                }
                return;
                
                
            }catch(Exception e){
                e.printStackTrace();
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
