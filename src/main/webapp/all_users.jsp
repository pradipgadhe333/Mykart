

<%@page import="com.learn.mycart.dao.UserDao"%>
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View All Users Page</title>
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
            UserDao dao=new UserDao(FactoryProvider.getFactory());
            List<User> users=dao.getAllUsers();
        %>
        
        <!--show users-->
        <div class="container-fluid">
            <h3 class="text-center mt-2">All users are here</h3>
            
            <div class="row">
                
                <!--first column side menu-->
                <div class="col-md-3">
                    
                    <div class="list-group mt-2 " style="width:300px">
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
                        for(User u1:users)
                        {
                    %>
                    <div class="card mb-3">
                        <div class="card-body">
                            
                            <div class="row">
                                
                                <!--first col-->
                                <div class="col-md-2">
                                    
                                    <div class="conatiner text-center">
                                        <img src="img/user_profile/<%= u1.getUserPic() %>" class="card-img-top p-2" style="max-height:100px; max-width: 100%; width: auto" alt="profile-pic">
                                     </div>
                
                                </div>

                                <!--second col-->
                                <div class="col-md-10">
                                    <a href="#"><u><%= u1.getUserName() %></u> </a>
                                    <br>
                                    <%= u1.getUserEmail() %> 
                                    <br>
                                    Role <%= u1.getUserType() %>
                                </div>
                                
                            </div>
                            
                        </div>
                    </div>
                    <%
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
