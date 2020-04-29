<%-- 
    Document   : addresses
    Created on : 10-Mar-2020, 18:45:47
    Author     : Lina
--%>

<%@page import="java.sql.Connection"%>
<%@page import="lt.bit.data.Person"%>
<%@page import="lt.bit.data.DB"%>
<%@page import="lt.bit.data.Address"%>
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
                font-weight: 50; /**/
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

                    if (ids != null && p == null) { //cia jei nori redaguoti zmogu kurio nera (ne tas id); cia jei paduodi id daug didesni
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
                <%=p.getLastName() + " Adresai:"%></h1></div><br>
        <div> <a class="btn btn-green" href="addressEdit.jsp?idP=<%=p.getId()%>">Pridėti Naują</a>
            <a href="index.jsp" class="btn btn-green">Grįžti atgal</a></div>
        <hr>
        <div id="person">
            <%
                for (Address a : DB.getAddresses(con, id)) {
            %> 

            Id:<%= a.getId()%><br>
            Adresas:  <%=a.getAddress()%> <br>             
            Miestas:  <%=a.getCity()%> <br>
            Pašto kodas: <%=(a.getPostCode() != null) ? a.getPostCode() : " * * * * *"%> <br><br>
            <a class="btn-s" href="deleteAddress?idP=<%=p.getId()%>&idA=<%=a.getId()%>">Trinti </a>            
            <a class="btn-s" href="addressEdit.jsp?idP=<%=p.getId()%>&idA=<%=a.getId()%>"> Keisti</a>            
            <hr>
            <%
                }
            %>

        </div>
    </body>
</html>
