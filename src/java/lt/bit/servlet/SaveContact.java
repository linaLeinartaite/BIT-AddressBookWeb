
package lt.bit.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lt.bit.data.Contact;
import lt.bit.data.DB;
import lt.bit.data.Person;

/**
 *
 * @author Lina
 */
@WebServlet(name = "SaveContact", urlPatterns = {"/saveContact"})
public class SaveContact extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Connection con = (Connection) request.getAttribute("con");

        String idPs = request.getParameter("idP");
        String idCs = request.getParameter("idC");
    //    Integer idP = new Integer(idPs);
        Integer idC = null;
        Person p = null;
        Contact nc = null;

        if (idPs != null) {
            try {
                p = DB.getPerson(con, new Integer(idPs));
                if (p == null) {
                    response.sendRedirect("contacts.jsp?id=" + idPs);
                    return;
                }

            } catch (Exception ex) {
                response.sendRedirect("contacts.jsp?id=" + idPs);
                return;
            }
            nc = new Contact();
            nc.setPersonId(p.getId());
            nc.setContact(request.getParameter("cn"));
            nc.setType(request.getParameter("t"));

            if (idPs != null && idCs != null) {
                idC = new Integer(idCs);
                nc.setId(idC);
                for (Contact c : DB.getContacts(con, p.getId())) {
                    if (idC.equals(c.getId())) {
                        DB.updateContact(con, nc);
                        System.out.println("nc: " + nc);
                    }
                }
            } else {
                DB.addContact(con, p.getId(), nc);
            }
        }
        response.sendRedirect("contacts.jsp?id=" + idPs); 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
