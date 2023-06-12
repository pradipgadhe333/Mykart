
<%@page import="com.learn.mycart.entities.OrderStatus"%>
<%@page import="com.learn.mycart.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.OrderDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Orders</title>
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
            User user = (User) session.getAttribute("current-user");
            int uId=user.getUserId();
            
            OrderDao orderDao=new OrderDao(FactoryProvider.getFactory());
            
            List<Order> list=orderDao.getAllOrdersByUserId(uId);
 
        %>
        
        <!--show orders-->
        <div class="container">
            <h3 class="mt-2">My Orders</h3>
            
            <%
                for(Order o:list)
                {
            %>
            <div class="card mb-4">
                <div class="card-body">
                    
                    <div class="container">
                        <h5>
                        <span style="display:inline-block">Order ID : <%= o.getOrderId() %></span>
                        <span style="display:inline-block; float: right">Ordered By : <%= o.getUser().getUserName() %></span>
                        </h5>
                    </div>
                    
                        <table class="table table-bordered all-table " style="background-color: white">
                        <tbody>
                            
                            <tr>
                                <td>Billing Name</td>
                                <td><%= o.getShippingDetails().getBillingName() %></td> 
                            </tr>
                            <tr>
                                <td>Billing Phone</td>
                                <td><%= o.getShippingDetails().getBillingPhone() %></td> 
                            </tr>
                            <tr>
                                <td>Shipping Address</td>
                                <td><%= o.getShippingDetails().getShippingAddress() %></td> 
                            </tr>
                            <tr>
                                <td>Ordered date</td>
                                <td><%= o.getOrderDate() %></td> 
                            </tr>
                            <tr>
                                <td>Order Status</td>
                                <td style="color:<%= o.getOrderStatuses().get(o.getOrderStatuses().size()-1).getStatusName().toString().equals("Delivered") ? "green" : o.getOrderStatuses().get(o.getOrderStatuses().size()-1).getStatusName().toString().equals("Cancelled") ? "red" : "black" %>"><%= o.getOrderStatuses().get(o.getOrderStatuses().size()-1).getStatusName() %> <span class="text-muted"> on <%= o.getOrderStatuses().get(o.getOrderStatuses().size()-1).getStatusDate() %> </span> </td>

                            </tr>
                            <tr>
                                <td>Order Amount</td>
                                <td>&#8377; <%= o.getTotalAmount() %></td> 
                            </tr>
                            <tr>
                                <td>Payment Option</td>
                                <td><%= o.getPaymentOption() %></td> 
                            </tr>
                            
                        </tbody>
                    </table>
                    
                    <div class="text-center">
                        
                       <a href="get_ordered_items.jsp?orderId= <%= o.getOrderId() %> " class="btn btn-primary">View Ordered Items</a>
                       
                       <% if(o.getOrderStatuses().get(o.getOrderStatuses().size()-1).getStatusName().equals("Delivered") || o.getOrderStatuses().get(o.getOrderStatuses().size()-1).getStatusName().toString().equals("Cancelled")) { %>
                            <button class="btn btn-danger" disabled>Cancel Order</button>
                        <% } else { %>
                            <a href="UpdateOrderServlet?order_id=<%= o.getOrderId() %>&operation=cancelorder" class="btn btn-danger">Cancel Order</a>
                        <% } %>
                        
                    </div>
                            
                </div>
                
            </div>
            <%
                }

                if(list.size()== 0)
                {
                    out.println("<h3 style='color:red'>Sorry !! You dont placed any order yet...</h3>");
                }
            %>
            
        </div>
      
        
        <!--cart modal-->
        <%@include file="components/common_modal.jsp" %> 
        
        
    </body>
</html>
