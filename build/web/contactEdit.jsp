<%-- 
    Document   : contactsEdit
    Created on : 10-Mar-2020, 18:50:01
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
                justify-content: center;
                align-items: center;  
                flex-direction: column;

                background: lightsteelblue;
                color: #333;
                font-family:  fantasy;
                font-size: 1rem;
                font-weight: 50;
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
                /*border-bottom: 2px solid lightslategray;*/
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
            String idCs = request.getParameter("idC");
            Integer idP = null;
            Integer idC = null;
            Person p = null;
            if (idPs != null) {
                try {
                    idP = new Integer(idPs);
                    p = DB.getPerson(con, idP);
                } catch (Exception ex) {
                    //ignore
                }
        %>
        <form method="POST" action="saveContact">      
            <%
                if (idPs != null && idCs != null) {
                    try {
                        idC = new Integer(idCs);
                        if ((idPs != null && p == null) || (idCs != null && p == null)) {
                            response.sendRedirect("contacts.jsp?id=" + idPs);
                            return;
                        }
                    } catch (Exception ex) {
                        response.sendRedirect("contacts.jsp?id=" + idPs);
                        return;
                    }

                    for (Contact c : DB.getContacts(con, idP)) {
                        if (idC.equals(c.getId())) {
            %>   

            <div class="input"><label>Kontaktas: </label> <input name="cn"  value="<%=c.getContact()%>"></div>
            <div class="input"><label>Tipas: </label> <input name="t" value="<%=c.getType()%>"></div>            
            <input type="hidden" name="idC" value="<%=c.getId()%>"> 
            <%
                    }
                }
            } else {

            %>             
            <div class="input"><label>Kontaktas: </label> <input name="cn" value=""></div>
            <div class="input"><label>Tipas: </label> <input name="t" value=""></div>  
                <%                    }
                %> 
            <input type="hidden" name="idP" value="<%=p.getId()%>"> 
            <input class="btn btn-green" type="submit" value="Išsaugoti"> 
        </form>
        <a href="contacts.jsp?id=<%=idPs%>">Grįžti atgal</a>
        <%
            }
        %>
    </body>
</html>
