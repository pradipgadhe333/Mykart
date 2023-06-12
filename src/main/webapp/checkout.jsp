
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in !! Login first to checkout...");
        response.sendRedirect("login.jsp");
        return;
    } 
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
        <%@include file="components/common_css_js.jsp" %>
       
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container-fluid">
            <div class="row mt-3">

                <div class="col-md-7">
                    <!--card-->
                    <div class="card">
                        <div class="card-header">
                            <h4>Order Details</h4>
                        </div>
                        <div class="card-body">
                            <div class="cart-body">

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <!--form details-->
                    <!--card-->
                    <div class="card">
                        <div class="card-header">
                            <h4>Delivery Address Details</h4>
                        </div>
                        <div class="card-body">
                            
                            <form id="checkout-form" action="OrderServlet" method="post" onsubmit="deleteAllItemsFromCart()" >
                                
                                <%@include file="components/message.jsp" %>
                                <!--<hr>-->
                                
                                <div class="form-group">
                                    <label>Billing Name</label>
                                    <input type="text" name="billing_name" class="form-control" value="<%= user.getUserName() %>" required>
                                </div>
                                
                                <div class="form-group">
                                    <label>Phone number</label>
                                    <input type="text" name="billing_phone" class="form-control" value="<%= user.getUserPhone() %>" required>
                                </div>
                                
                                <div class="form-group">
                                    <label>Shipping address</label>
                                    <textarea class="form-control" rows="3" name="shipping_address" placeholder="Enter your address" required><%= user.getUserAddress() %></textarea>
                                </div>
                                
                                <label>Payment Options:</label>
                                <div class="form-check">
                                    <input type="radio" name="payment_option" class="form-check-input" id="paytm" value="Paytm" required>
                                    <label>Paytm</label>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                     
                                    <input type="radio" name="payment_option" class="form-check-input" id="cashOnDelivery" value="Cash on delivery">
                                    <label>Cash on Delivery</label>
                                </div>
                                
                                <input type="hidden" name="orderedItems" id="ordered-items">
                                
                                <div class="container text-center">
                                    <button id="placeorder-btn" class="btn btn-outline-success">Place Order</button>
                                    <a href="index.jsp" class="btn btn-outline-primary">Continue Shopping</a>
                                </div>
                                
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--cart model-->
        <%@include file="components/common_modal.jsp" %> 
        
        <!--profile update modal-->
        <%@include file="components/profile_update_modal.jsp" %>
        <!--profile-update js-->
        <script src="js/profile_update.js"></script> 
        
        <script>
            
            // Retrieve the ordered items from local storage
            let orderedItems = JSON.parse(localStorage.getItem("cart"));
            
            // Store the ordered items in a JSON array
            let itemsArray = [];
            for (let i = 0; i < orderedItems.length; i++) {
              let item = orderedItems[i];
              let itemObject = {
                productId: item.productId,
                itemName: item.productName,
                quantity: item.productQuantity,
                price: item.productPrice
              };
              itemsArray.push(itemObject);
            }
            
            // Update the value of the hidden input field with the JSON array
            document.getElementById("ordered-items").value = JSON.stringify(itemsArray);

        </script>    
        
        
    </body>
</html>
