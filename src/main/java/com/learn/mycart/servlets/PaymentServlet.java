
package com.learn.mycart.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

public class PaymentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        
         try {
            
            // Read JSON data from the request body using 
            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(request.getReader(), JsonObject.class);
           
            int amount = jsonObject.get("amount").getAsInt();
            System.out.println(amount);
            
            // Set up your Razorpay API key and secret
            RazorpayClient razorpay = new RazorpayClient("rzp_test_vjlOCp32nRhvco", "6Y1gSS8FqSGPY4uw2hvjqPyb");

            // Create a payment order
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amount * 100); // Amount is in paise
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "order_rcptid_" + System.currentTimeMillis());
           
            Order order = razorpay.orders.create(orderRequest);
            System.out.println(order);
            
            //if you want you can save this payment order to your database 
            
            
            // Convert the Order object to a JSON string
            String orderJson = order.toJson().toString();

            // Send the JSON response to the client
            PrintWriter out = response.getWriter();
            out.print(orderJson);
            out.flush();

        
        } catch (RazorpayException e) {
            // Handle Razorpay-specific exceptions
            System.out.println(e.getMessage());
           
        } catch (Exception e) {
            // Handle other exceptions
           e.printStackTrace();
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
