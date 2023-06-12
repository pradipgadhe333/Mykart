
<%
    String message = (String)session.getAttribute("message");
    if(message!=null)
    {
        //print
        //out.println(message);
%>
        <div class="alert alert-success" role="alert">
            <h5><%= message %></h5>
        </div>
<%        
        session.removeAttribute("message");
    }
%>
