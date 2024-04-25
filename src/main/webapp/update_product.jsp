

<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Product details</title>
        <%@include file="components/common_css_js.jsp" %>
       
    </head>
    <body style="background:white">
        <%@include file="components/navbar.jsp" %>
        
        <%@include file="components/message.jsp" %>
        <!--profile update modal-->
        <%@include file="components/profile_update_modal.jsp" %>
        <!--profile-update js-->
        <script src="js/profile_update.js"></script> 
        
        <%
            int productId=Integer.parseInt(request.getParameter("pId"));
            ProductDao pdao=new ProductDao(FactoryProvider.getFactory());
            Product p=pdao.getProductById(productId);
            
            CategoryDao categoryDao= new CategoryDao(FactoryProvider.getFactory());
            List<Category> list = categoryDao.getCategories();
        %>
        
        <div class="container mt-2">
            <h3>Update product details here</h3>
            <hr>
            
            <form action="UpdateProductServlet" method="post">
                
                <div class="conatiner text-center">
                    <img class="card-img-top p-2" src="img/products/<%= p.getpPhoto() %>" style="max-height:150px; max-width: 100%; width: auto" alt="Card image cap">
                </div>
                
                <div class="form-group">
                    <input type="hidden" class="form-control" name="pId" value="<%= p.getpId() %>">
                </div>
                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text" class="form-control" name="pName" value="<%= p.getpName() %>">
                </div>
                <div class="form-group">
                    <label>Product description</label>
                    <textarea class="form-control" name="pDesc" style="height: 150px" ><%= p.getpDesc() %></textarea>
                </div>
                <div class="form-group">
                    <label>Quantity</label>
                    <input type="text" class="form-control" name="quantity" value="<%= p.getpQuantity() %>">
                </div>
                <div class="form-group">
                    <label>Product Price</label>
                    <input type="text" class="form-control" name="price" value="<%= p.getpPrice() %>">
                </div>
                <div class="form-group">
                    <label>Discount on Product (%)</label>
                    <input type="text" class="form-control" name="discount" value="<%= p.getpDiscount() %>">
                </div>
                
                <!-- getting product categories from db -->
                            
                <div class="form-group">
                    <label>Product category:</label>
                    <select name="catId" class="form-control" id="">
                        <option disabled>--- Select Category ---</option>
                        <
                            <%
                                for(Category c:list)
                                {
                            %>    
                                    <option value="<%= c.getCategoryId() %>" <%= c.getCategoryId() == p.getCategory().getCategoryId() ? "selected" : "" %>>
                                        <%= c.getCategoryTitle() %>
                                    </option>
                            <%
                                }
                            %>
                                    
                    </select>
                </div>
                            
                <div class="form-group">
                    <label>Update product image:</label>
                    <input type="file" name="pPhoto" class="form-control-file />
                           
                    <small class="form-text text-muted">
                        Current image: <%= p.getpPhoto() %>
                    </small>
                </div>
                            
                <div class="text-center my-4">
                    <button type="submit" class="btn btn-success btn-lg">Update details</button>
                    <a href="manage_products.jsp" class="btn btn-secondary btn-lg">Back</a>
                </div>           
                
            </form>
            
        </div>
        
        
        
        <!--cart modal-->
        <%@include file="components/common_modal.jsp" %> 
       
        
    </body>
</html>
