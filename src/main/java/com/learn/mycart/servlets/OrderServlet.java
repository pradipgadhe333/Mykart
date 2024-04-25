
package com.learn.mycart.servlets;

import com.learn.mycart.dao.OrderDao;
import com.learn.mycart.dao.OrderStatusDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Order;
import com.learn.mycart.entities.OrderStatus;
import com.learn.mycart.entities.OrderedItem;
import com.learn.mycart.entities.PaymentInformation;
import com.learn.mycart.entities.Product;
import com.learn.mycart.entities.ShippingDetails;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import com.learn.mycart.helper.GEmailSender;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

public class OrderServlet extends HttpServlet {

    // craeting a DateTimeFormatter object with the desired format
    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy, hh:mm a");  
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
         
            
            // Create a new LocalDateTime object to get the current date and time
            LocalDateTime orderDate = LocalDateTime.now();
            String formattedOrderDate = orderDate.format(dateFormat); // Use the DateTimeFormatter object to format the date as a string
            
            //getting form details 
            String billingName = request.getParameter("billing_name");
            String billingPhone = request.getParameter("billing_phone");
            String shippingAddress = request.getParameter("shipping_address");
            
            String paymentMethod = request.getParameter("payment_method");
            
            System.out.println(billingName);
            
            ShippingDetails shippingDetails=new ShippingDetails(billingName,billingPhone,shippingAddress);
            
        
            //setting payment info 
            PaymentInformation paymentInfo;
            paymentInfo = new PaymentInformation(null,"Unpaid",paymentMethod);
            
            
            // Get the current user
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("current-user");
            
            
            if(paymentMethod.equals("Online Payment")) {
              
                String paymentStatus = request.getParameter("payment_status");
                String paymentId = request.getParameter("payment_id");
                
                //set paymentInfo after online payment
                paymentInfo = new PaymentInformation(paymentId,paymentStatus,paymentMethod);
    
                if (paymentStatus.equals("paid")) {
                     
                    //processing order after payment success
                    processOrder(request, response, out, formattedOrderDate, shippingDetails, paymentInfo, user, session);
                    session.setAttribute("message", "Your order placed successfully!! Thank you for shopping with us...");
                    response.sendRedirect("checkout.jsp");
                     
                }else{
                    session.setAttribute("message", "Failed to place your order!!");
                    response.sendRedirect("checkout.jsp"); 
                }
                
               
            //processing order
            }else if (paymentMethod.equals("Cash On Delivery")) {
                    
                processOrder(request, response, out, formattedOrderDate, shippingDetails, paymentInfo, user, session);
                session.setAttribute("message", "Your order placed successfully!! Thank you for shopping with us...");
                response.sendRedirect("checkout.jsp");
                
            }
                  
            
        }
    }
    
    
    private void processOrder(HttpServletRequest request, HttpServletResponse response, PrintWriter out,
                            String formattedOrderDate, ShippingDetails shippingDetails,
                            PaymentInformation paymentInfo, User user, HttpSession session) throws IOException {

        // Create a new Order object and set the properties
        Order order = new Order();
        order.setOrderDate(formattedOrderDate);
        order.setShippingDetails(shippingDetails);
        order.setPaymentInformation(paymentInfo);
        order.setUser(user);

        // Retrieve the ordered items from local storage
        String itemsJson = request.getParameter("orderedItems");
        List<OrderedItem> orderedItems = new ArrayList<>();

        // Create a new ProductDao to update products in the database
        ProductDao productDao = new ProductDao(FactoryProvider.getFactory());

        if (itemsJson != null && !itemsJson.isEmpty()) {
            JSONArray itemsArray = new JSONArray(itemsJson);

            for (int i = 0; i < itemsArray.length(); i++) {
                JSONObject itemObject = itemsArray.getJSONObject(i);
                OrderedItem item = new OrderedItem();

                // Retrieve the corresponding product from the database
                Product product = productDao.getProductById(itemObject.getInt("productId"));

                int orderedQuantity = itemObject.getInt("quantity");
                int currentQuantity = product.getpQuantity();

                // Check if the ordered quantity is greater than the available quantity
                if (orderedQuantity > currentQuantity) {
                    // Handle insufficient quantity
                    session.setAttribute("message", "Insufficient quantity for the product: " + product.getpName() +
                            ". We have only " + product.getpQuantity() + " units available.");

                    response.sendRedirect("checkout.jsp");
                    return;
                }

                // Continue with order processing if the quantity is available
                item.setItemName(itemObject.getString("itemName"));
                item.setQuantity(itemObject.getInt("quantity"));
                item.setPrice(itemObject.getInt("price"));

                item.setProduct(product);
                item.setOrder(order);

                orderedItems.add(item);

                // Decrease the product quantity by the ordered quantity
                int newQuantity = currentQuantity - orderedQuantity;
                product.setpQuantity(newQuantity);

                // Update the product in the database
                productDao.updateProduct(product);
            }
        }

        // Add the ordered items to the order
        order.setOrderedItems(orderedItems);

        int totalAmount = 0;
        for (OrderedItem item : orderedItems) {
            totalAmount += item.getPrice() * item.getQuantity();
        }
        order.setTotalAmount(totalAmount);

        // Save the order to the database using Hibernate
        OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
        orderDao.saveOrder(order);

        // Set the order status
        LocalDateTime statusDate = LocalDateTime.now();
        String formattedStatusDate = statusDate.format(dateFormat);

        OrderStatus orderStatus = new OrderStatus("Order Placed", formattedStatusDate, order);
        OrderStatusDao orderStatusDao = new OrderStatusDao(FactoryProvider.getFactory());
        orderStatusDao.saveOrderStatus(orderStatus);

        // Update the order with the new order status
        List<OrderStatus> orderStatuses = new ArrayList<>();
        orderStatuses.add(orderStatus);
        order.setOrderStatus(orderStatuses);

        // Associate the order with the order statuses
        orderDao.updateOrder(order);

        // Send email notification
        sendOrderConfirmationEmail(order);

//        session.setAttribute("message", "Your order placed successfully!! Thank you for shopping with us...");
//        response.sendRedirect("checkout.jsp");
    }
    
    //send email
    private void sendOrderConfirmationEmail(Order order) {
        GEmailSender emailSender = new GEmailSender();
        String to = order.getUser().getUserEmail();
        String from = "mykartservice@gmail.com";
        String subject = "Your Order Confirmation - Order #" + order.getOrderId();

        //email body
        StringBuilder orderSummary = new StringBuilder();
        for (OrderedItem item : order.getOrderedItems()) {
            orderSummary.append("Product: ").append(item.getItemName()).append("\n")
                    .append("Price: Rs. ").append(item.getPrice()).append("\n")
                    .append("Quantity: ").append(item.getQuantity()).append("\n")
                    .append("------------------------------------------------------\n");
        }

        StringBuilder textBuilder = new StringBuilder();
        textBuilder.append("Dear ").append(order.getUser().getUserName()).append(",\n\n")
                .append("Congratulations! Your order has been successfully placed. \n\n")
                .append("Order Id: #").append(order.getOrderId()).append("\n")
                .append("Order Date: ").append(order.getOrderDate()).append("\n")
                .append("Shipping Address: ").append(order.getUser().getUserAddress()).append("\n\n\n")
                .append("Order Summary: \n\n")
                .append(orderSummary.toString())
                .append("Shipping Charges: Free Shipping \n\n")
                .append("Total Amount: Rs. ").append(order.getTotalAmount()).append("\n\n")
                .append("Payment Method:").append(order.getPaymentInformation().getPaymentMethod()).append("\n\n")
                .append("Please keep this email as confirmation of your order. We will notify you separately via email when your order has been shipped. If you have any questions or need assistance, feel free to reach out to our customer support team. \n\n")
                .append("Thank you for choosing Mykart. We look forward to delivering your order and providing you with a delightful shopping experience. Your satisfaction is our top priority. \n\n\n")
                .append("Best regards,\n\n")
                .append("Mykart Team \n")
                .append("Contact Information: Phone Number:+919860146205, Email:mykartservice@gmail.com \n");

        boolean result = emailSender.sendEmail(to, from, subject, textBuilder.toString());
        if (result) {
            System.out.println("Email sent successfully.");
        } else {
            System.out.println("Failed to send email.");
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
