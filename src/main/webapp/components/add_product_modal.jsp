 
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>

<%
    CategoryDao categoryDao= new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = categoryDao.getCategories();
%>

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
