
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
         <%@include file="components/common_css_js.jsp" %>
        
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        
        <div class="container">
            <div class="row mt-3">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header bg-custom text-white text-center">
                            <span class="fa fa-user-circle fa-2x"></span>
                            <h5 class="">Login here</h5>
                        </div>
                        <div class="card-body">
                            
                            <%@include file="components/message.jsp" %>
                            
                            <hr>
                            <form action="LoginServlet" method="post">
                                
                                <div class="form-group">
                                  <label>Email Id</label>
                                  <input type="email" name="email" class="form-control" placeholder="Enter your email">
                                </div>
                                <div class="form-group">
                                  <label>Password</label>
                                  <input type="password" name="password" class="form-control" placeholder="Enter your password">
                                </div>
                                
                                <div class="conatiner text-center">
                                    <input type="submit" class="btn btn-outline-primary mb-2" value="Login">
                                    <input type="reset"  class="btn btn-outline-danger mb-2" value="Clear">
                                    <br>
                                    <a href="register.jsp">New User? Register here...</a>
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
