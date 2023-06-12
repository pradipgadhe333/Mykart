
<%@page import="com.learn.mycart.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.OrderDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--securing all orders page from normal users-->
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in !! Login first");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {

            session.setAttribute("message", "You are not admin !!So this page is not accessible to you..");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Orders Page</title>
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
//            User user = (User) session.getAttribute("current-user");
            int uId=user.getUserId();
            
            OrderDao orderDao=new OrderDao(FactoryProvider.getFactory());
            
            List<Order> orders=null;
            if(user.getUserType().equalsIgnoreCase("admin"))
            {
                orders=orderDao.getAllOrders();
            }else{
                orders=orderDao.getAllOrdersByUserId(uId);
            }
        %>
        
        <!--show orders-->
        <div class="container-fluid">
            <h3 class="text-center mt-2">All users order are here</h3>
            
            <div class="row">
                
                <!--first column side menu-->
                <div class="col-md-3">
                    
                    <div class="list-group mt-2 position-fixed " style="width:300px">
                        <a href="#" class="list-group-item list-group-item-action active"><i class="fa fa-navicon fa-lg"> Menu</i> </a>
                        <a href="#" class="list-group-item list-group-item-action" data-toggle="modal" data-target="#add-category-modal"><i class="fa fa-plus-circle fa-lg"> Add Category</i> </a>
                        <a href="#" class="list-group-item list-group-item-action"><i class="fa fa-th-large fa-lg"> View Categories</i> </a>
                        <a href="#" class="list-group-item list-group-item-action" data-toggle="modal" data-target="#product-modal"><i class="fa fa-plus-square fa-lg"> Add Product</i> </a>
                        <a href="manage_products.jsp" class="list-group-item list-group-item-action "><i class="fa fa-gift fa-lg"> View Products</i> </a>
                        <a href="allorders.jsp" class="list-group-item list-group-item-action "><i class="fa fa-shopping-cart fa-lg"> View All Orders</i> </a>
                        <a href="all_users.jsp" class="list-group-item list-group-item-action "><i class="fa fa-users fa-lg"> View All Users</i> </a>
                        <a href="LogoutServlet" class="list-group-item list-group-item-action "><i class="fa fa-power-off fa-lg"> Logout</i> </a>
                        
                    </div>
                    
                </div>
                
                <!--second col-->
                <div class="col-md-9 mt-2">
                    
                    <%
                    for(Order o:orders)
                    {
                    %>
                    <div class="card mb-4">
                        <div class="card-body">

                            <div class="container">
                                <h5>
                                <span style="display:inline-block">Order ID:<%= o.getOrderId() %></span>
                                <span style="display:inline-block; float: right">Ordered By:<%= o.getUser().getUserName() %></span>
                                </h5>
                            </div>

                                <table class="table table-bordered all-table ">
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
                                        <td>Ordered Date</td>
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
                                <% if (user.getUserType().equalsIgnoreCase("admin")) { %>
                                
                                    <a href="get_ordered_items.jsp?orderId= <%= o.getOrderId() %> " class="btn btn-primary">View Ordered Items</a>
                                    <a href="update_order.jsp?orderId= <%=o.getOrderId() %>" class="btn btn-warning">Update Order</a>
                                    
                                <% } else { %>
                                    <button class="btn btn-primary">View Ordered Items</button>
                                <% } %>
                            </div>

                        </div>

                    </div>
                    <%
                    }

                    if(orders.size()== 0)
                    {
                        out.println("<h3 style='color:red'>Sorry !! You dont have any order yet...</h3>");
                    }
                    %>

                    
                </div>
                
            </div>
            
        </div>
      
        
        
        
        <!--category modal-->
        <%@include file="components/add_category_modal.jsp" %>

        <!--product modal-->
        <%@include file="components/add_product_modal.jsp" %>

       
        
        <!--cart modal-->
        <%@include file="components/common_modal.jsp" %> 
        
    </body>
</html>
