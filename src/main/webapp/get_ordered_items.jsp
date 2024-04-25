
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.learn.mycart.entities.OrderStatus"%>
<%@page import="com.learn.mycart.dao.OrderedItemDao"%>
<%@page import="com.learn.mycart.entities.OrderedItem"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <title>Ordered Items Page</title>
        <%@include file="components/common_css_js.jsp" %>
        
    </head>
    <body style="background: white">
        
        <%@include file="components/navbar.jsp" %>
        
        <%@include file="components/message.jsp" %>
        <!--profile update modal-->
        <%@include file="components/profile_update_modal.jsp" %>
        <!--profile-update js-->
        <script src="js/profile_update.js"></script> 
        
        
        <%
            long orderId = Long.parseLong(request.getParameter("orderId").trim());
            OrderedItemDao itemDao=new OrderedItemDao(FactoryProvider.getFactory());
            List<OrderedItem> orderedItems = itemDao.getOrderedItemsByOrderId(orderId);
       
             User user = (User) session.getAttribute("current-user");
        %>

        <!--show Ordered Items-->
        <div class="container-fluid">
            <h3 class=" mt-2">Order Items</h3>
            
            <% for(OrderedItem item : orderedItems) { %>
                
            <div class="card all-table ">
                <div class="card-body">
                    
                    <div class="row">
                        
                        <!--first col-->
                        <div class="col-md-2">
                            <img src="img/products/<%= item.getProduct().getpPhoto() %>" class="card-img-top p-2" style="max-height:100px; max-width: 100%; width: auto" alt="product-photo">
                            
                        </div>
                        <!--second col-->
                        <div class="col-md-4">
                            <p> <%= item.getItemName() %> </p>
                        </div>
                        <!--third col-->
                        <div class="col-md-2">
                            <p>Quantity: <%= item.getQuantity() %> </p>
                        </div>
                        <!--fourth col-->
                        <div class="col-md-2">
                            <p>Price: &#8377; <%= item.getPrice() %> </p>
                        </div>
                       
                    </div>
                    
                    <!--second row-->
                    <div class="row">
                        
                        <div class="col-md-2">
                            
                        </div>
                        
                        <div class="col-md-10">
                            <p><b>Order Status History:</b></p>
                            
                            <div class="status-container d-flex">
                                <% List<OrderStatus> orderStatuses = item.getOrder().getOrderStatus(); %>
                                <% for(OrderStatus status : orderStatuses) { %>
                                    <div class="status-item">
                                        <p style="color:<%= status.getStatusName().equals("Delivered") ? "green" : status.getStatusName().equals("Cancelled") ? "red" : "black" %>">
                                            <%= status.getStatusName() %>
                                        </p>
                                        <p class="text-muted" style="margin-right: 20px">
                                            <%= status.getStatusDate() %>
                                        </p>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                            
                    </div>
                    
                </div>
            </div>
            
            <% } %>
            
            <% if(user.getUserType().equalsIgnoreCase("admin")){  %> 
                <div class="text-center my-4">
                    <a href="allorders.jsp" class="btn btn-primary">Go Back</a>
                </div>
            <%}else{%>
                <div class="text-center my-4">
                    <a href="myorder.jsp" class="btn btn-primary">Go Back</a>
                </div>
                
            <%}%>
        </div>
            
            
                 
        
         <!--cart modal-->
        <%@include file="components/common_modal.jsp" %> 
        
          
    </body>
</html>
