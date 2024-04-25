
<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>

<!--securing admin page from normal users-->
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

<%
    CategoryDao categoryDao= new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = categoryDao.getCategories();
    
    //getting count of users and products
   Map<String,Long> m = Helper.getCounts(FactoryProvider.getFactory());
    
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         
        <title>Admin Page</title>
        <%@include file="components/common_css_js.jsp" %>
         
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        
        <!--profile update modal-->
        <%@include file="components/profile_update_modal.jsp" %>
        <!--profile-update js-->
        <script src="js/profile_update.js"></script>  
       
        <div class="container-fluid admin">

            <div class="container mt-3">
                <%@include file="components/message.jsp" %>
            </div>
            <h3 class="text-center">Welcome to Admin Dashboard </h3>
            
            <div class="row mt-2">
                
                <!--side menu-->
                <div class="col-md-3">
                    <div class="list-group mt-3">
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

                <!--for showing all card-->
                <div class="col-md-8">

                    <!--first row-->
                    <div class="row mt-3">

                        <!--first col-->
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body text-center">
                                    <div class="container">
                                        <img class="img-fluid rounded-circle" style="max-width: 100px;" src="img/list.png" alt="category_icon"/>
                                    </div>
                                    <h2><%= list.size() %> +</h2>
                                    <h2 class="text-muted">Number of Categories</h2>
                                </div>
                            </div>

                        </div>

                        <!--second col-->
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body text-center">
                                    <div class="container">
                                        <img class="img-fluid" style="max-width: 100px;" src="img/product.png" alt="product_icon"/>
                                    </div>
                                    <h2><%= m.get("productCount") %> +</h2>
                                    <h2 class="text-muted">Number of Products</h2>
                                </div>
                            </div>

                        </div>

                    </div>

                    <!--Second row-->
                    <div class="row mt-3">

                        <!--first col-->
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body text-center">

                                    <div class="container">
                                        <img class="img-fluid rounded-circle" style="max-width: 100px;" src="img/users.png" alt="user_icon"/>
                                    </div>

                                    <h2><%= m.get("userCount") %> +</h2>
                                    <h2 class="text-muted">Number of Users</h2>
                                </div>
                            </div>
                        </div>

                        <!--second col-->
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body text-center">

                                    <div class="container">
                                        <img class="img-fluid " style="max-width: 100px;" src="img/order.png" alt="user_icon"/>
                                    </div>

                                    <h2><%= m.get("orderCount") %> +</h2>
                                    <h2 class="text-muted">Number of Orders</h2>
                                </div>
                            </div>
                        </div>

                    </div>     


                    <!--Third row-->
                    <div class="row mt-3 mb-4">

                        <!--first col-->
                        <div class="col-md-6">
                            <div class="card" data-toggle="modal" data-target="#add-category-modal">
                                <div class="card-body text-center">
                                    <div class="container">
                                        <img class="img-fluid rounded-circle" style="max-width: 100px;" src="img/add category.png" alt="user_icon"/>
                                    </div>
                                    <p>Click here to add category</p>
                                    <h2 class="text-uppercase text-muted">Add Category</h2>
                                </div>
                            </div>
                        </div>

                        <!--second col-->
                        <div class="col-md-6">
                            <div class="card" data-toggle="modal" data-target="#product-modal">
                                <div class="card-body text-center">
                                    <div class="container">
                                        <img class="img-fluid rounded-circle" style="max-width: 100px;" src="img/add product.png" alt="user_icon"/>
                                    </div>
                                    <p>Click here to add new product</p>
                                    <h2 class="text-uppercase text-muted">Add Product</h2>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

            </div>

        </div>
                
        <!--add category modal-->


        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-custom text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">

                            <input type="hidden" name="operation" value="addcategory">

                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" name="catDescription" style="height: 150px" placeholder="Enter category description"></textarea>
                            </div>

                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="reset" class="btn btn-outline-warning">Reset</button>
                            </div>

                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                    </div>
                </div>
            </div>
        </div>

        <!--End of add category modal-->

        <!-- ---------------------------------------------------------------------------------- -->

        <!--add product modal-->

        <!-- Modal -->
        <div class="modal fade" id="product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-custom text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Product details</h5>
                        <button type="button" class="close" style="color:red" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                            <input type="hidden" name="operation" value="addproduct"/>
                            
                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter title of product" required/>
                            </div>

                            <div class="form-group">
                                <textarea class="form-control" name="pDesc" style="height: 100px" placeholder="Enter product description" ></textarea>
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter price of product" required/>
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter discount on product in %" required/>
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter product quantity" required/>
                            </div>

                            <!-- getting product categories from db -->
                            
                            
                            <div class="form-group">
                                <label>Choose a product category:</label>

                                <select name="catId" class="form-control" id="">
                                    
                                    <option disabled selected>---Select Category---</option>
                                    
                                    <%
                                        for(Category c:list)
                                        {
                                    %>    
                                            <option value="<%= c.getCategoryId() %>"><%= c.getCategoryTitle() %></option>
                                    <%
                                        }
                                    %>
                                    
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Add product image:</label>
                                <input type="file" name="pPhoto" class="form-control-file">
                            </div>
                            
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add product</button>
                                <button type="reset" class="btn btn-outline-warning">Clear</button>
                            </div>

                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!--End of add product modal-->

        <!--cart model-->
        <%@include file="components/common_modal.jsp" %>
        
        
        
    </body>
</html>
