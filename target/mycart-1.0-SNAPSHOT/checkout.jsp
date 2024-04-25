
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <title>Checkout Page</title>
        <%@include file="components/common_css_js.jsp" %>
       
        <!-- Include Razorpay JavaScript SDK -->
        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js" ></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        
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
                            <div class="cart-body table-responsive">

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
                            
                            <form id="checkout-form" action="OrderServlet" method="post" >
                                
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
                                
                                <label>Payment Method:</label>
                                <div class="form-check">
                                    <input type="radio" name="payment_method" class="form-check-input" id="online" value="Online Payment" required>
                                    <label>Pay Online</label>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                     
                                    <input type="radio" name="payment_method" class="form-check-input" id="cashOnDelivery" value="Cash On Delivery">
                                    <label>Cash on Delivery</label>
                                </div>
                                
                                <input type="hidden" name="orderedItems" id="ordered-items">
                                
                                <div class="container text-center" id="loader" style="display:none">
                                    <span class="fa fa-refresh fa-spin fa-2x"></span>
                                    <h4> Please wait, processing your order...</h4>
                                </div>
                                
                                <div class="container text-center" id="submit-btn">
                                    <button id="placeorder-btn" class="btn btn-outline-success">Place Order</button>
                                    <a href="index.jsp" id="continue-btn" class="btn btn-outline-primary">Continue Shopping</a>
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
            
            document.getElementById("checkout-form").addEventListener("submit", function(event) {
                
                event.preventDefault(); // Prevent the default form submission
                
                $("#submit-btn").hide();
                $("#loader").show();
        
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

                // Calculate the total order amount
                let orderAmount = calculateTotalAmount(orderedItems);
                console.log(orderAmount);

                // Check the selected payment method
                var paymentMethod = document.querySelector('input[name="payment_method"]:checked');
                console.log(paymentMethod.value);
                
                if (paymentMethod) {
                    // If the payment method is "Online Payment", initiate Razorpay payment
                    if (paymentMethod.value === "Online Payment") {
            
                        initiateRazorpayPayment(orderAmount);
                        
                    } else if(paymentMethod.value === "Cash On Delivery"){
                        
                        //this.submit(); // Submit the form directly OR
                        
                        //submit form using ajax req
                        
                        let form = $(this).serialize();
                        //console.log(form);
                         
                        $.ajax({
                            url: "OrderServlet",
                            type: 'POST',
                            data: form,
                            success: function (response) {
                                
                                $("#submit-btn").show();
                                $("#loader").hide();
                                
                                console.log("form data sent to OrderServlet successfully.");
                         
                                deleteAllCartItems(); //after successful order
                                swal("Your order placed successfully!!", "Thank you for shopping with us...", "success");  
                                
                            },
                            error: function () {

                                $("#submit-btn").show();
                                $("#loader").hide();
                                
                                console.log("Error occurred while sending form data to OrderServlet.");
                                swal("Sorry, your order could not be placed.", "Please try again later.", "error");
                                
                            }
                            
                        });
                        
                        
                    }
                } else {
                    // Handle the case where no payment method is selected
                    alert("Please select a payment method");
                }
            });


            function calculateTotalAmount(items) {
                let total = 0;
                for (let i = 0; i < items.length; i++) {
                    let item = items[i];
                    total += item.productPrice * item.productQuantity;
                }
                return total;
            }
            
        </script>
        
        <script>
            
            function initiateRazorpayPayment(amount) {
                console.log("payment started...");
                console.log(amount);
                
                // Make an AJAX request to create a payment order on the server
                $.ajax({
                    type: "POST",
                    url: "PaymentServlet",
                    data: JSON.stringify({ amount: amount }),  // Convert JavaScript object to JSON string
                    contentType: "application/json", // Set the content type to JSON
                    dataType: "json", // Expect JSON in response

                    success: function(response) {
                        //invoked when success
                        console.log(response);

                        if(response.status === "created"){
                            // Redirect to the Razorpay checkout page
                            openRazorpayCheckout(response);
                        }
                    },
                    error: function() {
                        alert("Error occurred while processing the payment.");
                    }
                });
            }

            function openRazorpayCheckout(response) {
                var options = {
                    key: "rzp_test_vjlOCp32nRhvco", // Replace with your Razorpay public key
                    amount:response.amount , 
                    currency: "INR",
                    name: "Mykart",
                    description: "Payment for Services",
                    image: "https://cdn-icons-png.flaticon.com/128/4290/4290854.png",
                    order_id: response.id, // Replace with actual order ID
                    handler: function(response) {
                        console.log(response.razorpay_payment_id);
                        console.log(response.razorpay_order_id);
                        console.log(response.razorpay_signature);
                        console.log('payment successful...');
                        //alert("congrats !! Payment successful !!");
                        //swal("Congrats !!", "Payment successful !!", "success");
                        
                        // send form data and payment details after payment success
                        var formData = $("#checkout-form").serialize(); 

                        // Append payment ID and payment status as additional parameters
                        formData += "&payment_id=" + encodeURIComponent(response.razorpay_payment_id);
                        formData += "&payment_status=paid";
                        
                        //console.log(formData);

                        // Send form data to OrderServlet
                        $.ajax({
                            type: "POST",
                            url: "OrderServlet",
                            data: formData, // Send form data directly
                            contentType: "application/x-www-form-urlencoded", //default content type no need to write explicitly
                            
                            success: function(response) {
                     
                                $("#submit-btn").show();
                                $("#loader").hide();
                                
                                console.log("Payment details and form data sent to OrderServlet successfully.");
                                
                                deleteAllCartItems(); //after success 
                                swal("Your order placed successfully!!", "Thank you for shopping with us...", "success");  
                               
                            },
                            error: function() {
                                
                                $("#submit-btn").show();
                                $("#loader").hide();
                                
                                console.log("Error occurred while sending payment details and form data to OrderServlet.");
                                swal("Sorry, your order could not be placed.", "Please try again later.", "error");
                            }
                        });
                       
                        
                    },
                    prefill: {
                        name: "",
                        email: "",
                        contact: ""
                    },
                    notes: {
                        address: "Mykart Ecom Services India"
                    },
                    theme: {
                        color: "#3399cc" // Customize the color to match your branding
                    }
                };

                // Open Razorpay Checkout with the configured options
                var rzp = new Razorpay(options);

                rzp.on('payment.failed', function (response){
                    console.log(response.error.code);
                    console.log(response.error.description);
                    console.log(response.error.source);
                    console.log(response.error.step);
                    console.log(response.error.reason);
                    console.log(response.error.metadata.order_id);
                    console.log(response.error.metadata.payment_id);
                    //alert("Oops payment failed !!");
                    swal("Failed !!", "Oops payment failed !!", "error");
                    
                    $("#submit-btn").show();
                    $("#loader").hide();
                    
                });

                rzp.open();
            }
        </script>
        
    </body>
</html>
