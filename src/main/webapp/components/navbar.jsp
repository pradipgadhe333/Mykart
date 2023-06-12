
<%@page import="com.learn.mycart.entities.User"%>
<%
    User u=(User)session.getAttribute("current-user");  
%>

<nav class="navbar sticky-top navbar-expand-lg navbar-dark  bg-custom">
  <a class="navbar-brand" href="index.jsp"><span class="fa fa-shopping-cart fa-lg"> Mykart</span> </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
      
    <ul class="navbar-nav mr-auto">
        
        <li class="nav-item active">
            <a class="nav-link" href="index.jsp"><span class="fa fa-home fa-lg"> Home</span>  </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="contact_us.jsp"><span class="fa fa-envelope fa-lg"> Contact Us</span> </a>
        </li>
      
    </ul>
      
    <form action="index.jsp" method="GET" class="form-inline my-2 my-lg-0">
        <input class="form-control mr-2" type="search" name="keyword" placeholder="Search products..." style="width: 300px" aria-label="Search" <% if(request.getParameter("keyword") != null && !request.getParameter("keyword").isEmpty()) { %> value="<%= request.getParameter("keyword") %>" <% } %> >
        <button class="btn btn-success my-2 my-sm-0" type="submit">Search</button>
    </form>  
      
    <ul class="navbar-nav ml-auto">
        
        <li class="nav-item">
            <a class="nav-link" href="#" data-toggle="modal" data-target="#cart" > <i class="fa fa-cart-plus fa-lg"> Cart</i> <span class="cart-items"> (0)</span> </a>
        </li>
        
        <!--conditional rendering-->
        <%
            if(u == null)
            {
        %>
                <li class="nav-item ">
                    <a class="nav-link" href="login.jsp"><span class="fa fa-sign-in fa-lg"> Login</span> </a>
                </li>
        
                <li class="nav-item ">
                    <a class="nav-link" href="register.jsp"><span class="fa fa-user-plus fa-lg">  Register here</span> </a>
                </li>
        <%
            }else if(u.getUserType().equals("admin")){
                
        %>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <span class="fa fa-user fa-lg"> My Account</span>
                    </a>
                    
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <a class="dropdown-item" href="<%= u.getUserType().equals("admin")?"admin.jsp":"normal.jsp" %>" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user fa-lg"> Hello, <%= u.getUserName() %></span></a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="myorder.jsp"><span class="fa fa-list-alt fa-lg"> My Orders</span> </a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="LogoutServlet"><span class="fa fa-power-off fa-lg"> Logout</span></a>
                    </div>
                </li>
                
                <li class="nav-item ">
                    <a class="nav-link" href="admin.jsp"><span class="fa fa-user-circle fa-lg"> Admin Dashboard</span> </a>
                </li>

        <%
            }else{
        %>
                
                <li class="nav-item">
                    <a class="nav-link" href="myorder.jsp"><span class="fa fa-list-alt fa-lg"> My Orders</span> </a>
                </li>
        
                <li class="nav-item">
                    <a class="nav-link" href="<%= u.getUserType().equals("admin")?"admin.jsp":"normal.jsp" %>" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user fa-lg"> <%= u.getUserName() %></span>  </a>
                </li>
        
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-power-off fa-lg"> Logout</span> </a>
                </li>
        <%
            }
        %>
        
                
    </ul>
      
     <!-- 
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
      -->
  </div>
</nav>