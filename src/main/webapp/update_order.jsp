
<%@page import="com.learn.mycart.entities.OrderStatus"%>
<%@page import="com.learn.mycart.entities.Order"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.OrderDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <title>Update order Page</title>
        <%@include file="components/common_css_js.jsp" %>
        
    </head>
    <body style="background:white">
        <%@include file="components/navbar.jsp" %>
        
        <%@include file="components/message.jsp" %>
        <!--profile update modal-->
        <%@include file="components/profile_update_modal.jsp" %>
        <!--profile-update js-->
        <script src="js/profile_update.js"></script> 
        
        <% 
            long orderId=Long.parseLong(request.getParameter("orderId").trim());
            OrderDao dao=new OrderDao(FactoryProvider.getFactory());
            Order order=dao.getOrderById(orderId);
        %>
        
         <div class="container mt-2">
            <h3>Update order details here</h3>
            <hr>
            
            <form action="UpdateOrderServlet" method="post">
                
                <input type="hidden" name="operation" value="updateorder">
                <input type="hidden" class="form-control" name="order_id" value="<%= order.getOrderId() %>">
             
                <div class="form-group">
                    <label>Billing Name</label>
                    <input type="text" class="form-control" name="billing_name" value="<%= order.getShippingDetails().getBillingName() %>">
                </div>
                <div class="form-group">
                    <label>Billing Phone</label>
                    <input type="text" class="form-control" name="billing_phone" value="<%= order.getShippingDetails().getBillingPhone() %>">
                </div>
                <div class="form-group">
                    <label>Shipping Address</label>
                    <textarea class="form-control" rows="3" name="address" ><%= order.getShippingDetails().getShippingAddress() %></textarea>
                </div>
                
                <div class="form-group">
                    <label>Order Status</label>
                    <select name="order_status" class="form-control">
                        
                        <option disabled>--- Select Order Status ---</option>
                           
                        <% String[] statusOptions = {"Order Placed", "Pending", "Processing", "Shipped", "Out for Delivery", "Delivered", "Cancelled", "On Hold"}; %>
                        <% for(String status : statusOptions) { %>
                               <option value="<%= status %>" <%= status.equals(order.getOrderStatus().get(order.getOrderStatus().size()-1).getStatusName()) ? "selected" : "" %>><%= status %></option>
                        <% } %>
                        
                    </select>
                </div>
             
                <div class="text-center my-4">
                    <button type="submit" class="btn btn-success">SAVE CHANGES</button>
                    <a href="allorders.jsp" class="btn btn-secondary ml-3">BACK</a>
                </div> 
                
            </form>
            
         </div>
        
        <!--cart modal-->
        <%@include file="components/common_modal.jsp" %> 
       
    </body>
</html>
