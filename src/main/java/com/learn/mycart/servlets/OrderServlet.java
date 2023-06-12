
package com.learn.mycart.servlets;

import com.learn.mycart.dao.OrderDao;
import com.learn.mycart.dao.OrderStatusDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Order;
import com.learn.mycart.entities.OrderStatus;
import com.learn.mycart.entities.OrderedItem;
import com.learn.mycart.entities.Product;
import com.learn.mycart.entities.ShippingDetails;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
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

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            
            // Create a new LocalDateTime object to get the current date and time
            LocalDateTime orderDate = LocalDateTime.now();
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy, hh:mm a");  // Create a DateTimeFormatter object with the desired format
            String formattedOrderDate = orderDate.format(dateFormat); // Use the DateTimeFormatter object to format the date as a string
            
            // Retrieve the order information from the request
            String paymentOption = request.getParameter("payment_option");
            
            //shipping details
            String billingName = request.getParameter("billing_name");
            String billingPhone = request.getParameter("billing_phone");
            String shippingAddress = request.getParameter("shipping_address");
            ShippingDetails shippingDetails=new ShippingDetails(billingName,billingPhone,shippingAddress);
            
            // Get the current user
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("current-user");
            
            // Create a new Order object and set the properties
            Order order = new Order();
            
            order.setOrderDate(formattedOrderDate); 
            order.setShippingDetails(shippingDetails);
            order.setPaymentOption(paymentOption);
            order.setUser(user);
            
                
            // Retrieve the ordered items from local storage
            String itemsJson = request.getParameter("orderedItems");
            List<OrderedItem> orderedItems = new ArrayList<>();
            
            //crating object of ProductDao to update product in db
            ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
            
            if (itemsJson != null && !itemsJson.isEmpty()) {
                
                JSONArray itemsArray = new JSONArray(itemsJson);
                
                for (int i = 0; i < itemsArray.length(); i++) {
                    
                    JSONObject itemObject = itemsArray.getJSONObject(i);
                    OrderedItem item = new OrderedItem();
                    
                    // Retrieve the corresponding product from the database
                    Product product = productDao.getProductById(itemObject.getInt("productId"));
                    
                    item.setItemName(itemObject.getString("itemName"));
                    item.setQuantity(itemObject.getInt("quantity"));
                    item.setPrice(itemObject.getInt("price"));
                    
                    item.setProduct(product);
                    item.setOrder(order);
                    
                    orderedItems.add(item);
                    
                    // Decrease the product quantity by the ordered quantity
                    int currentQuantity = product.getpQuantity();
                    int orderedQuantity = item.getQuantity();
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
            order.setOrderStatuses(orderStatuses);
            
            // Associate the order with the order statuses
            orderDao.updateOrder(order);
            
            session.setAttribute("message", "Your order placed successfully!! Thank you for shopping with us...");
            response.sendRedirect("checkout.jsp");
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
