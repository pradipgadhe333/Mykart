
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <title>View and Manage Products </title>
        <%@include file="components/common_css_js.jsp" %>
        <style>
           
            .table th, .table td {
                 width: auto;
            }

        </style>
         
    </head>
    <body style="background: white">
        
        <%@include file="components/navbar.jsp" %>
        
        <%@include file="components/message.jsp" %>
        <!--profile update modal-->
        <%@include file="components/profile_update_modal.jsp" %>
        <!--profile-update js-->
        <script src="js/profile_update.js"></script> 
        
        
        <%
            ProductDao pDao=new ProductDao(FactoryProvider.getFactory());
            List<Product> products=pDao.getAllProducts();
        %>
      
        <!--show all products-->
        <div class="container-fluid">
            <h3 class="text-center mt-2">All products are here</h3>
            
            <div class="row">
                
                <!--first col-->
                <div class="col-md-3 col-sm-12">
                    
                    <div class="list-group mt-2" >
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
                <div class="col-md-9 col-sm-12">
                    
                    <form class="my-3">
                        <div class="row">
                            <div class="col-md-7">
                                <input class="form-control" type="search" placeholder="Search Products..." aria-label="Search">
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-outline-success " type="submit">Search</button>
                            </div>
                        </div>
                    </form>

                    
                    <div class="table-responsive">
                        <table class="table table-bordered all-table">
                            <thead style="background: lightgray">
                                <th>pId</th>
                                <th style="white-space:nowrap">Product Name</th>
                                <th>Quantity</th>
                                <th>MRP</th>
                                <th>Discount</th>
                                <th style="white-space:nowrap">After Discount</th>
                                <th>Category</th>
                                <th>Action</th>
                            </thead>
                            <tbody>
                                <% 
                                    for(Product p:products)
                                    {
                                %>
                                <tr>
                                    <td><%= p.getpId() %></td>

                                    <td style="width: 400px"><%= p.getpName() %></td>

                                    <%
                                        if(p.getpQuantity()>0)
                                        {
                                    %>
                                            <td style="width: 50px;color: green; font-weight: 700;"><%= p.getpQuantity() %></td>
                                    <%
                                        } else{
                                    %>
                                         <td style="width: 50px;color: red; font-weight: 700;"><%= p.getpQuantity() %></td>
                                    <%}%>

                                    <td style="white-space:nowrap">&#8377; <%= p.getpPrice() %></td>

                                    <td class="table-data" ><%= p.getpDiscount() %>%</td>

                                    <td class="table-data">&#8377; <%= p.getPriceAfterApplyingDiscount() %></td>

                                    <td><%= p.getCategory().getCategoryTitle().toString() %></td>

                                    <td style="white-space:nowrap"> 
                                        <a href="DeleteProductServlet?pId=<%= p.getpId() %>" data-toggle="tooltip" data-placement="bottom" title="Delete this product"><i class="fa fa-trash fa-2x" style="color:red"></i></a>

                                        <a href="update_product.jsp?pId=<%= p.getpId() %>"  data-toggle="tooltip" data-placement="bottom" title="Update product details"><i class="fa fa-pencil-square fa-2x"></i></a>

                                    </td>

                                </tr>
                                <% 
                                    }
                                %>

                            </tbody>
                        </table>
                    </div>
                    
                   
                </div>
                
            </div>
               
        
        
        
        
        
        <!--category modal-->
        <%@include file="components/add_category_modal.jsp" %>

        <!--add product modal-->
        <%@include file="components/add_product_modal.jsp" %>

         
        <!--cart modal-->
        <%@include file="components/common_modal.jsp" %> 
        
        <script>
            $(document).ready(function (){
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>
        
       
    </body>
</html>
