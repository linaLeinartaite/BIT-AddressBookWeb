<%-- 
    Document   : addressesEdit
    Created on : 10-Mar-2020, 18:49:12
    Author     : Lina
--%>

<%@page import="java.sql.Connection"%>
<%@page import="lt.bit.data.Address"%>
<%@page import="java.text.SimpleDateFormat"%>
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
            Connection con = (Connection) request.getAttribute("con");
            
            String idPs = request.getParameter("idP");
            String idAs = request.getParameter("idA");
            Integer idP = null;
            Integer idA = null;
            Person p = null;
            if (idPs != null) {
                try {
                    idP = new Integer(idPs);
                    p = DB.getPerson(con, idP);
                } catch (Exception ex) {
//ignore
                }
        %>
        <form method="POST" action="saveAddress">      
            <%
                if (idPs != null && idAs != null) { 
                    try {
                        idA = new Integer(idAs);
                        if ((idPs != null && p == null) || (idAs != null && p == null)) { 
                            response.sendRedirect("addresses.jsp?id=" + idPs);
                            return; 
                        }
                    } catch (Exception ex) {
                        response.sendRedirect("addresses.jsp?id=" + idPs); 
                        return; 
                    }

                    for (Address a : DB.getAddresses(con, idP)) {
                        if (idA.equals(a.getId())) {
            %>              
            <div class="input"><label>Adresas:</label> <input name="ad"  value="<%=a.getAddress()%>"></div>
            <div class="input"><label>Miestas:</label> <input name="m" value="<%=a.getCity()%>"></div>
            <div class="input"><label>Pašto kodas:</label> <input name="pk" value="<%=(a.getPostCode() != null) ? a.getPostCode() : ""%>"></div>  
            <input type="hidden" name="idA" value="<%=a.getId()%>">  
            <%
                    }
                }
            } else {

            %>   
            <div class="input"><label>Adresas:</label> <input name="ad"  value=""></div>
            <div class="input"><label>Miestas:</label> <input name="m" value=""></div>
            <div class="input"><label>Pašto kodas:</label> <input name="pk" value=""></div>
                <%                    }
                %>  
            <input type="hidden" name="idP" value="<%=p.getId()%>"> 
            <input class="btn btn-green" type="submit" value="Išsaugoti">  
        </form>
        <a href="addresses.jsp?id=<%=idPs%>">Grįžti atgal</a>
        <%
            }
        %>
    </body>
</html>




