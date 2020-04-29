<%-- 
    Document   : edit
    Created on : 10-Mar-2020, 18:42:25
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
        <title>JSP Page</title>
        <style>
            body {
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;  
                flex-direction: column;

                background: lightsteelblue;
                color: #333;
                font-family:  fantasy;
                font-size: 1rem;
                font-weight: 50; /**/
            } 
            form{
                display: flex;
                width:50%;
                justify-content: center;
                align-items: center;
                flex-direction: column;
            }

            .input{
                display: inline-block;
                width:100%; 
                padding: 5px 20px;
                margin: 5px 5px;
            }
            .input >label{
                display: inline-block;
                width:15%;
            }
            .input >input{
                display: inline-block;
                width:75%;
            }

            .btn{                
                font-family:  fantasy;
                text-decoration: none;
                font-size: 20px;
                padding: 5px 20px;
                margin: 5px 5px;
                border: none;
                border-radius: 5px;
            }
            .btn-green{
                background-color: cadetblue;
            }
            .btn-grey {
                background-color: lightgrey;
            }

            a{
                color:darkslateblue;
            }

        </style>
    </head>
    <body>
        <%
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

//tikrinsim ar mums siuncia id: 
//t.y. jei mes cia atejom per "keisti" linka;
//(nes jei per "prideti nauja" linka tai musu ids==null);
            String ids = request.getParameter("id");
            Integer id = null;
            Person p = null;
            if (ids != null) {
                try {
                    id = new Integer(ids);
                    Connection con = (Connection) request.getAttribute("con");
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
        <!--po viso sito virsuj turim du variantus: arba abu ==null arba abu !=null-->

        <form method="POST" action="savePerson"> 
            <div class="input"><label>Vardas:</label> <input name="fn"  value="<%=(ids != null) ? p.getFirstName() : ""%>"></div>
            <div class="input"><label> Pavarde:</label> <input name="ln" value="<%=(ids != null) ? p.getLastName() : ""%>"></div>
            <div class="input"><label> Gimimo data:</label> <input name="bd" value="<%=(ids != null && p.getBirthDate() != null) ? sdf.format(p.getBirthDate()) : ""%>"></div>
            <div class="input"><label> Alga:</label>  <input name="salary" value="<%=(ids != null && p.getSalary() != null) ? p.getSalary() : ""%>"> </div>
            <input class="btn btn-green" type="submit" value="Išsaugoti">   

            <%if (p != null) {
            %>
            <input type="hidden" name="id" value="<%=p.getId()%>">  
            <%}%>
        </form>
        <a href="index.jsp">Grįžti atgal</a>
    </body>
</html>
