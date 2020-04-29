<%-- 
    Document   : index
    Created on : 10-Mar-2020, 18:42:08
    Author     : Lina
--%>

<%@page import="java.sql.Connection"%>
<%@page import="lt.bit.data.DB"%>
<%@page import="lt.bit.data.Person"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>darbuotoju sarasas</title>
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
            .link{
                font-weight: 550;
                color:black;
            }

        </style>
    </head>
    <body>
        <div id="title"><h1>DARBUOTOJŲ SĄRAŠAS</h1></div> 
        <a class="btn btn-green" href="edit.jsp">Pridėti Naują</a>
        <hr>
        <div id="person">
            <%
                //D_CONNECTION (using ConFilter.java)
                Connection con = (Connection) request.getAttribute("con");

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                for (Person p : DB.getPersons(con)) {
            %>
            id: <%=p.getId()%> <br>
            Vardas: <%=p.getFirstName()%> <br>
            Pavarde: <%=p.getLastName()%> <br>
            Gimimo data: <%=(p.getBirthDate() != null) ? sdf.format(p.getBirthDate()) : " * * * * *"%> <br>
            Alga: <%=(p.getSalary() != null) ? p.getSalary() : " * * * * *"%> <br>
            <a class="link"  href="addresses.jsp?id=<%=p.getId()%>">Adresai</a><br>
            <a class="link" href="contacts.jsp?id=<%=p.getId()%>">Kontaktai</a> <br><br>
            <a class="btn-s" href="deletePerson?id=<%=p.getId()%>">Trinti</a>              
            <a class="btn-s" href="edit.jsp?id=<%=p.getId()%>">Keisti</a>            
            <hr>

            <%
                }
            %>

        </div>
    </body>
</html>
