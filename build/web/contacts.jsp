<%-- 
    Document   : contacts
    Created on : 10-Mar-2020, 18:49:35
    Author     : Lina
--%>

<%@page import="java.sql.Connection"%>
<%@page import="lt.bit.data.Contact"%>
<%@page import="lt.bit.data.DB"%>
<%@page import="lt.bit.data.Person"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                min-height: 100vh;
                display: flex;
                justify-content: top;
                align-items: left;  
                flex-direction: column;

                background: lightsteelblue;
                color: #333;
                font-family:  fantasy;
                font-size: 1rem;
                font-weight: 50; 
            }
            .btn{
                dispaly: inline-block;
                width: 110px;
                font-family:  fantasy;
                text-decoration: none;
                font-size: 20px;
                padding: 5px 20px;
                margin: 5px 5px 5px 0;
                border: none;
                border-radius: 5px;
            }
            .btn-s{
                background-color: cadetblue;
                font-family:  fantasy;
                text-decoration: none;
                font-size: 15px;
                padding: 2px 5px;
                margin: 2px 2px 2px 0;
                border: none;
                border-radius: 5px;
            }
            .btn-green{
                background-color: cadetblue;
                color: black;
            }
            a{
                color:darkslateblue;
            }

        </style>
    </head>

    <body>
        <%
            Connection con = (Connection) request.getAttribute("con");
            String ids = request.getParameter("id");

            Integer id = null;
            Person p = null;
            if (ids != null) {
                try {
                    id = new Integer(ids);

                    p = DB.getPerson(con, id);

                    if (ids != null && p == null) {
                        response.sendRedirect("index.jsp");
                        return;
                    }
                } catch (Exception ex) {
                    response.sendRedirect("index.jsp");
                    return;
                }
            }
        %>

        <div><h1><%=p.getFirstName() + " "%>
                <%=p.getLastName() + " Kontaktai:"%></h1></div><br>
        <div><a class="btn btn-green" href="contactEdit.jsp?idP=<%=p.getId()%>">Pridėti Naują</a>
            <a href="index.jsp" class="btn btn-green">Grįžti atgal</a></div>
        <hr>
        <div id="person">
            <%
                for (Contact c : DB.getContacts(con, id)) {
            %> 
            Id:<%= c.getId()%><br>
            Kontaktas:  <%=c.getContact()%> <br>             
            Tipas:  <%=c.getType()%> <br><br>       
            <a class="btn-s" href="deleteContact?idP=<%=p.getId()%>&idC=<%=c.getId()%>">Trinti </a>              
            <a class="btn-s" href="contactEdit.jsp?idP=<%=p.getId()%>&idC=<%=c.getId()%>"> Keisti</a>            
            <hr>
            <%
                }
            %>

        </div>
    </body>
</html>
