<%@page import="com.learn.mycart.entities.User"%>
<%
    User user1 = (User) session.getAttribute("current-user");
    if (user1 == null) {
        session.setAttribute("message", "You are not logged in !! Login first to checkout...");
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-custom text-white">
                <h5 class="modal-title" id="exampleModalLabel">Profile details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div class="container text-center">

                    <img src="img/user_profile/<%= user1.getUserPic()%>" class="img-fluid" style="border-radius:50%; max-width: 100px;" alt="profile-pic">
                    <br>
                    <h5 class="mt-3">Hello, <%= user1.getUserName()%></h5>

                    <!-- fetching user details-->

                    <div id="profile-details">

                        <table class="table">

                            <tbody>
                                <tr>
                                    <th scope="row">User id:</th>
                                    <td><%= user1.getUserId()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">Email id:</th>
                                    <td><%= user1.getUserEmail()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">Password:</th>
                                    <td><%= user1.getUserPassword()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">Phone number:</th>
                                    <td><%= user1.getUserPhone()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">Address:</th>
                                    <td><%= user1.getUserAddress()%></td>
                                </tr>

                            </tbody>
                        </table>
                    </div>

                    <!--profile edit-->

                    <div id="profile-edit" style="display:none">

                        <h4 class="mt-2">Update your profile details</h4>

                        <form action="ProfileEditServlet" method="post" enctype="multipart/form-data">

                            <table class="table">
                                <tr>
                                    <td>User id:</td>
                                    <td><%= user1.getUserId()%></td>
                                </tr>
                                <tr>
                                    <td>User Name:</td>
                                    <td><input type="text" class="form-control" name="user_name" value="<%= user1.getUserName()%>"></td>
                                </tr>
                                <tr>
                                    <td>Email id:</td>
                                    <td><input type="email" class="form-control" name="user_email" value="<%= user1.getUserEmail()%>"></td>
                                </tr>
                                <tr>
                                    <td>Password:</td>
                                    <td><input type="password" class="form-control" name="user_password" value="<%= user1.getUserPassword()%>"></td>
                                </tr>
                                <tr>
                                    <td>Phone number:</td>
                                    <td><input type="number" class="form-control" name="user_phone" value="<%= user1.getUserPhone()%>"></td>
                                </tr>
                                <tr>
                                    <td>Address:</td>
                                    <td>
                                        <textarea rows="3" class="form-control" name="user_address"><%= user1.getUserAddress()%>
                                        </textarea>
                                    </td>
                                </tr>

                            </table>

                            <div class="container">
                                <button type="submit" class="btn btn-outline-success">Save</button>
                            </div>

                        </form>
                    </div>

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" id="edit-profile-btn" class="btn btn-primary">Edit</button>
            </div>
        </div>
    </div>
</div>

