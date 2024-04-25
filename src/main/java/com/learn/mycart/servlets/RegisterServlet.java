
package com.learn.mycart.servlets;

import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import com.learn.mycart.helper.GEmailSender;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;


public class RegisterServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            //fetching user data 
            String userName = request.getParameter("user_name"); 
            String userEmail = request.getParameter("email");
            String userPassword = request.getParameter("password");
            String userPhone = request.getParameter("phone");
            String userAddress = request.getParameter("address");
              
            //server side validations  
            if(userName.isEmpty())
            {
                out.println("Name is blank");
                return;
            }
            
            int userId=-1;            

            try{
                
                //creating user object to store data
                User user=new User(userName, userEmail, userPassword, userPhone, "default.png", userAddress, "normal");
              
//                Session hibernateSession=FactoryProvider.getFactory().openSession();
//                Transaction tx = hibernateSession.beginTransaction();
//              
//                int userId =(int) hibernateSession.save(user);
//              
//                tx.commit();
//                hibernateSession.close();
                
                // Hibernate operations
                try (Session hibernateSession = FactoryProvider.getFactory().openSession()) {
                    Transaction tx = hibernateSession.beginTransaction();

                    userId = (int) hibernateSession.save(user);

                    tx.commit();
                }
              
                //out.println("user saved");
                //out.println("<br>User id is "+userId);
             
                // Send email notification to the user
                sendRegistrationEmail(user);
             
                //message on screen
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "User registered successfully !! User id is: "+userId);
                response.sendRedirect("register.jsp");
                return;
             
            } catch (Exception e) {
                if (e.getCause() instanceof ConstraintViolationException) {
                    out.println("User with the provided email already exists.");
                    handleDuplicateEmail(request, response);
                } else {
                    e.printStackTrace();
                    out.println("An unexpected error occurred.");

                    // Additional logic for handling email sending failure
                    if (userId != -1) {
                        // Clear the misleading message if user registration was successful
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("message", null);
                    }
                }
            }


        }
    }
    
    //send email method
    private void sendRegistrationEmail(User user) {
       
        GEmailSender emailSender = new GEmailSender();
        
        String to = user.getUserEmail();
        String from = "mykart333@gmail.com";
        String subject = "Registration Successful...";
        String text = "Dear " + user.getUserName() + ",\n\n" +
                "Welcome to Our Online Store! \n" +
                "Thank you for registering with Mykart. \n\n" +
                "Your Email Id is: " + user.getUserEmail() + "\n" +
                "Your password is: " + user.getUserPassword() + "\n\n" +
                "Happy shopping! \n\n\n " +
                "Regards,\n" +
                "MyKart Team";

        boolean result = emailSender.sendEmail(to, from, subject, text);
        if (result) {
            System.out.println("Email sent successfully.");
        } else {
            System.out.println("Failed to send email.");
        }
    }
    
    private void handleDuplicateEmail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("message", "User already exists. Please try with a different email.");
        response.sendRedirect("register.jsp");
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
