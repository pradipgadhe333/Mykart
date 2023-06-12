<%@page import="com.learn.mycart.entities.User"%>
<%
    User user=(User)session.getAttribute("current-user");  
%>

<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        
        <%@include file="components/common_css_js.jsp" %>
        
        <link rel="stylesheet" href="css/owl.carousel.min.css"/>
        <link rel="stylesheet" href="css/owl.theme.default.css"/>
        
    </head>
    <body style="background: white">
        
        <%@include file="components/navbar.jsp" %>
        
        <!--profile update modal-->
        <%
            if(user !=null)
            {
        %>
           
           <div class="container mt-3"><%@include file="components/message.jsp" %></div>

           <%@include file="components/profile_update_modal.jsp" %>
           <!--profile-update js-->
           <script src="js/profile_update.js"></script>   
        <%
            }
        %>
        
        <!--carousel-->
        <div class="container mt-2">
            <!-- Set up your HTML -->
            <div class="owl-carousel owl-theme">
                
                <!-- Carousel items -->
                
                <div>
                    <div class="card text-center">
                        <div class="card-body">
                            <div style="position: relative;">
                                <span class="badge badge-danger" style="position: absolute; top: 0; right: 25px;">New</span>
                                <img src="img/slider/one plus tv.png" alt="product pic" class="img-fluid mx-auto" style="max-height: 100px; max-width: 100%; width: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                
                <div>
                    <div class="card text-center">
                        <div class="card-body">
                            <div style="position: relative;">
                                <span class="badge badge-success" style="position: absolute; top: 0; right: 25px;">10% Off</span>
                                <img src="img/slider/Apple iphone 14.png" alt="product pic" class="img-fluid mx-auto" style="max-height: 100px; max-width: 100%; width: auto;" />
                            </div>
                        </div>
                    </div>
                </div>

                
                <div>
                    <div class="card text-center">
                        <div class="card-body">
                            <div style="position: relative;">
                                <span class="badge badge-success" style="position: absolute; top: 0; right: 5px;">Best Seller</span>
                                <img src="img/slider/Mi 32 inch LED TV.png" alt="product pic" class="img-fluid mx-auto" style="max-height: 100px; max-width: 100%; width: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                
                <div>
                    <div class="card text-center">
                        <div class="card-body">
                            <div style="position: relative;">
                                <span class="badge badge-primary" style="position: absolute; top: 0; right: 0;">OnePlus 2T 5G </span>
                                <img src="img/slider/one plus 2T.png" alt="product pic" class="img-fluid mx-auto" style="max-height: 100px; max-width: 100%; width: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                
                <div>
                    <div class="card text-center">
                        <div class="card-body">
                            <div style="position: relative;">
                                <span class="badge badge-dark" style="position: absolute; top: 0; right: 0;">Lenevo IdeaPad </span>
                                <img src="img/slider/Lenevo IdeaPad Slim3.png" alt="product pic" class="img-fluid mx-auto" style="max-height: 100px; max-width: 100%; width: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                
                 <div>
                    <div class="card text-center">
                        <div class="card-body">
                            <div style="position: relative;">
                                <span class="badge badge-danger" style="position: absolute; top: 0; right: 10px;">Launching </span>
                                <img src="img/slider/fire-boltt.png" alt="product pic" class="img-fluid mx-auto" style="max-height: 100px; max-width: 100%; width: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                
                <div>
                    <div class="card text-center">
                        <div class="card-body">
                            <div style="position: relative;">
                                <span class="badge badge-success" style="position: absolute; top: 0; right: 0;">Newly Launched </span>
                                <img src="img/slider/vivo-v27-pro.png" alt="product pic" class="img-fluid mx-auto" style="max-height: 100px; max-width: 100%; width: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            
        </div>
        <!--End of Carousel-->
        
        <div class="container-fluid">
            
            <div class="row  mx-2">

                <%

                    String cat = request.getParameter("category");
                    //out.println(cat);
                    
                    String keyword=request.getParameter("keyword");

                    ProductDao pdao= new ProductDao(FactoryProvider.getFactory());
                    List<Product> list = null;
                    
                    if(cat==null || cat.trim().equals("all"))
                    {
                        if(keyword == null || keyword.trim().isEmpty())
                        {
                            list= pdao.getAllProducts();
                        }else{
                            list=pdao.searchProducts(keyword);
                        }
                        
                    }else{

                        int cid = Integer.parseInt(cat.trim());
                        list = pdao.getAllProductsByCatId(cid);

                        // Filter the products by keyword when a category is selected
                        if (keyword != null && !keyword.trim().isEmpty()) {
                            list = pdao.searchProducts(keyword);
                        }
                        
                    }
                    
                %>

                <%
                    CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getCategories();
                %>

                <!--show categories-->
                <div class="col-md-2">

                    <div class="list-group mt-3">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                           All Products
                        </a>

                    <%
                        for(Category c:clist)
                        {
                    %>
                            <!-- url rewriting -->
                            <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action"><%= c.getCategoryTitle() %></a>
                    <%        
                        }
                    %>

                    </div>
                </div>

                <!--show products-->
                <div class="col-md-10">

                    <div class="row mt-3">

                        <div class="col-md-12">

                            <div class="card-columns">

                                <!--traversing products-->

                                <%
                                    for(Product p:list)
                                    {
                                %>
                                        <!--product card-->
                                        <div class="card">

                                            <div class="conatiner text-center">
                                                <img class="card-img-top p-2" src="img/products/<%= p.getpPhoto() %>" style="max-height:150px; max-width: 100%; width: auto" alt="Card image cap">
                                            </div>

                                            <div class="card-body">
                                                <h5 class="card-title"><%= p.getpName() %></h5>
                                                <p class="card-text"><%= Helper.get10Words(p.getpDesc()) %></p>

                                                <%
                                                    if(p.getpQuantity()>=5)
                                                    {
                                                %>
                                                         <p class="instock-label">In Stock</p>

                                                <%
                                                    }else if(p.getpQuantity()<5 && p.getpQuantity()>0){
                                                %>
                                                         <p class="outofstock-label">Only few left</p>
                                                <%
                                                    }else{
                                                %>
                                                         <p class="outofstock-label">Out of Stock</p>

                                                <%
                                                    }
                                                %>

                                                <p class="alert alert-success"> <span class="off-label"><%= p.getpDiscount() %>% off</span> &nbsp; <span class="text-secondary price-label"> &#8377;<%= p.getpPrice() %> </span> &nbsp; <span class="discount-label"> &#8377;<%= p.getPriceAfterApplyingDiscount() %></span> </p>

                                            </div>

                                            <div class="card-footer text-center">

                                                <%
                                                    if(p.getpQuantity() == 0){
                                                %>
                                                    <button class="btn btn-primary" disabled>ADD TO CART</button>
                                                    <button class="btn btn-warning" style="background:#fb641b;color:white" disabled="">BUY NOW</button>
                                                <%
                                                    } else {
                                                %>
                                                    <button class="btn btn-primary" onclick="add_to_cart(<%= p.getpId() %> , '<%= p.getpName() %>' , <%= p.getPriceAfterApplyingDiscount() %> ,<%= p.getpQuantity() %> )">ADD TO CART</button>
                                                    <button class="btn btn-warning " style="background:#fb641b;color:white" onclick="add_to_cart(<%= p.getpId() %> , '<%= p.getpName() %>' , <%= p.getPriceAfterApplyingDiscount() %>),goToCheckoout()" >BUY NOW</button>  
                                                <%
                                                    }
                                                %>

                                            </div>

                                        </div>

                                <%    
                                    }
                                %>
                                

                            </div>

                        </div>

                    </div>

                    <%
                        if(list.size()== 0)
                        {
                    %>
                            <div class='alert alert-danger' role='alert'>
                                <h3>No Products found with this keyword !!</h3>
                            </div>
                    <%
                        }
                    %>
                                
                </div>

            </div>
        </div>    
       
        <!--cart model-->                    
        <%@include file="components/common_modal.jsp" %> 
        
        <script src="js/owl.carousel.min.js"></script>
        
        <script>
            $(document).ready(function () {
              $(".owl-carousel").owlCarousel({
                loop: true,
                margin: 10,
                responsiveClass: true,
                autoplay: true,
                autoplayTimeout: 4000,
                autoplayHoverPause: true,
                rewind: true,
                dots: false,

                responsive: {
                  0: {
                    items: 1,
                    nav: true,
                  },
                  600: {
                    items: 3,
                    nav: false,
                  },
                  1000: {
                    items: 3,
                    nav: true,
                    loop: false,
                  },
                },
              });
            });
        </script>
        
    </body>
</html>
