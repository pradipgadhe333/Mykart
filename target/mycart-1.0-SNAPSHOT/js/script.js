function add_to_cart(pid, pname, price, pquantity)
{
    let cart = localStorage.getItem("cart");
    if (cart == null)
    {
        //no cart yet
        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price}
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        console.log("Product is added for the first time");
        showToast("Item is added to cart...");

    } else {
        //cart is already present
        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find((item) => item.productId == pid)
        if (oldProduct)
        {
            // we have to increase the quantity
            if (oldProduct.productQuantity < pquantity) {
                oldProduct.productQuantity = oldProduct.productQuantity + 1;
                pcart.map((item) => {

                    if (item.productId == oldProduct.productId)
                    {
                        item.productQuantity = oldProduct.productQuantity;
                    }

                });

                localStorage.setItem("cart", JSON.stringify(pcart));
                console.log("Product qauntity is increased");
                showToast("Product quantity is increased...");
            }else{
                 console.log("Maximum quantity of product reached !!");
                 showToast("Maximum quantity of product reached !!");
            }

        } else {
            //we have to add the product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            console.log("Product is added");
            showToast("Product is added to cart...");
        }
    }

    updateCart();
}

//updating cart

function updateCart()
{
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);//now we get cart as a object
    if (cart == null || cart.length == 0)
    {
        console.log("Cart is empty !!");
        $(".cart-items").html("(0)");
        
        // Create an image element
        var imageElement = $("<img>").attr("src", "img/empty.png");

        // Create a div element and append the image element to it
        var cartBodyContent = $("<div>").append(imageElement).append("<h3>Your cart is empty !! </h3>");

        // Add styles to center the cartBodyContent horizontally and vertically
        cartBodyContent.css({
          display: "flex",
          flexDirection: "column",  // Add this line to stack the image and message vertically
          justifyContent: "center",
          alignItems: "center"
        });

        $(".cart-body").html(cartBodyContent);

        
        $(".checkout-btn").attr('disabled',true);
        $("#placeorder-btn").attr('disabled',true);
        
    } else {
        //there is some item in cart to show
        console.log(cart);

        $(".cart-items").html(`( ${cart.length} )`);

        let table = `
        <div class='table-responsive'>
            <table class='table'>
                <thead class='thead-light'>

                    <tr>
                        <th style="white-space:nowrap">Item Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Action</th>
                    </tr>

                </thead>
        
        
            `;
        
        let totalPrice = 0;
        cart.map((item)=>{
            
            table+=`
                <tr>
                    <td style="width:45%"> ${item.productName} </td>
                    <td style="white-space:nowrap"> &#8377; ${item.productPrice} </td>
                    <td style="white-space:nowrap"> <button onclick="decreaseItemQantity(${item.productId})" class="btn btn-outline-danger btn-sm" style="font-size:16px;"><b> - </b></button> ${item.productQuantity} <button onclick="increaseItemQantity(${item.productId})" class="btn btn-outline-success btn-sm" style="font-size:16px" ><b> + </b></button> </td>
                    <td> &#8377; ${item.productQuantity * item.productPrice} </td>
                    <td><button class="btn btn-danger btn-sm" onclick='deleteItemFromCart(${item.productId})'>Remove</button></td>
                </tr>
            
            `;
            
            totalPrice += item.productPrice * item.productQuantity;
            
        });

        table = table + `
            <tr><td colspan='4' class='text-right font-weight:900' style='font-size:20px';><b>Total Amount : &#8377; ${totalPrice}</b></td></tr>
        </table>
        </div> `;
        
        $(".cart-body").html(table);
        $(".checkout-btn").attr('disabled',false);
        $("#placeorder-btn").attr('disabled',false);
        
    }
}

//increase quantity of item present in the cart
function increaseItemQantity(pid)
{
    let pcart=JSON.parse(localStorage.getItem('cart'));
    
    let oldProduct = pcart.find((item) => item.productId == pid);
    // we have to increase the quantity
            if (oldProduct.productQuantity < 5) {
                oldProduct.productQuantity = oldProduct.productQuantity + 1;
                pcart.map((item) => {

                    if (item.productId == oldProduct.productId)
                    {
                        item.productQuantity = oldProduct.productQuantity;
                    }

                });

                localStorage.setItem("cart", JSON.stringify(pcart));
                console.log("Product qauntity is increased");
                showToast("Product quantity is increased...");
            }else{
                 console.log("Maximum quantity of product reached !!");
                 showToast("Maximum quantity of product reached !!");
            }
      
    
    updateCart();
                 
}

//decreasing item quantity
function decreaseItemQantity(pid)
{
    let pcart=JSON.parse(localStorage.getItem('cart'));
    
    let oldProduct = pcart.find((item) => item.productId == pid)
    
    if(oldProduct.productQuantity > 1)
    {
        // we have to increase the quantity
        oldProduct.productQuantity = oldProduct.productQuantity - 1;
        pcart.map((item) => {

            if (item.productId == oldProduct.productId)
            {
                item.productQuantity = oldProduct.productQuantity;
            }

        });

        localStorage.setItem("cart", JSON.stringify(pcart));
        console.log("Product qauntity is decreased");
        showToast("Product quantity is decreased...");     
         
    }else
    {
        showToast("Product quantity cannot be less than 1");
    }
    
    updateCart();                 
}

//removes particular item from cart 
function deleteItemFromCart(pid)
{
    let cart=JSON.parse(localStorage.getItem('cart'));
    
    let newcart=cart.filter((item)=>item.productId != pid);
    
    localStorage.setItem('cart',JSON.stringify(newcart));
    
    updateCart();
    
    showToast("Item is removed from cart...");
}

//removes all items from cart after placing order
function deleteAllCartItems() {
    
 //let newcart = []; // create an empty array
 //localStorage.setItem('cart', JSON.stringify(newcart));
 
//OR
let cart=JSON.parse(localStorage.getItem('cart'));
localStorage.removeItem('cart');
  
  updateCart();
  //showToast("All items have been removed from the cart...");
}


$(document).ready(function () {
    updateCart();
});

function showToast(content) {
        $("#toast").addClass("display");
        $("#toast").html(content);

        setTimeout(() => {
          $("#toast").removeClass("display");
        }, 3000);
      }
      
function goToCheckoout()
{
    window.location="checkout.jsp";
}


