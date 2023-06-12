
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        <%@include file="components/common_css_js.jsp" %>
        
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        
        <div class="container-fluid">
            <div class="row mt-3">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header bg-custom text-white text-center">
                            <span class="fa fa-user-plus fa-2x"></span>
                            <h5 class="">Sign up here</h5>
                        </div>
                        <div class="card-body">

                            <%@include file="components/message.jsp" %>
                            <hr>
                            
                            <form action="RegisterServlet" method="post">
                                <div class="form-group">
                                  <label>User Name</label>
                                  <input type="text" name="user_name" class="form-control" placeholder="Enter your name">
                                </div>
                                <div class="form-group">
                                  <label>Email Id</label>
                                  <input type="email" name="email" class="form-control" placeholder="Enter your email">
                                </div>
                                <div class="form-group">
                                  <label>Password</label>
                                  <input type="password" name="password" class="form-control" placeholder="Enter your password">
                                </div>
                                <div class="form-group">
                                  <label>Phone Number</label>
                                  <input type="number" name="phone" class="form-control" placeholder="Enter your phone number">
                                </div>
                                <div class="form-group">
                                  <label>Address</label>
                                  <textarea  name="address" class="form-control" rows="3" placeholder="Enter your address"></textarea>
                                </div>

                                <div class="container text-center">
                                    <button class="btn btn-outline-success mb-2">Register</button>
                                    <button type="reset" class="btn btn-outline-warning mb-2">Reset</button>
                                    <br>
                                    <a href="login.jsp">Existing User? Login here...</a>
                                </div>

                            </form>

                        </div>
                    </div>
                </div>

            </div>
        </div>
                            
        <!--cart model-->                    
        <%@include file="components/common_modal.jsp" %> 
                            
    </body>
</html>
