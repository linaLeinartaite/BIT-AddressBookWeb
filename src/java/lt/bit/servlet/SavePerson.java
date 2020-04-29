
package lt.bit.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lt.bit.data.DB;
import lt.bit.data.Person;

/**
 *
 * @author Lina
 */
@WebServlet(name = "SavePerson", urlPatterns = {"/savePerson"})
public class SavePerson extends HttpServlet {

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
        String ids = request.getParameter("id");
        Person p = null;       

        if (ids != null) {
            try {
                p = DB.getPerson(con, new Integer(ids));
                if (p == null) {
                    response.sendRedirect("index.jsp");
                    return;
                }
            } catch (Exception ex) {
                response.sendRedirect("index.jsp");
                return;
            }
        } else {
            p = new Person();
        }
      
        p.setFirstName(request.getParameter("fn"));
        p.setLastName(request.getParameter("ln"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date bd = sdf.parse(request.getParameter("bd"));
            p.setBirthDate(bd);
        } catch (Exception ex) {
            //DB_CONNECTION
            p.setBirthDate(null); 
        }
        try {
            BigDecimal salary = new BigDecimal(request.getParameter("salary"));
            p.setSalary(salary);
        } catch (Exception ex) {
             //DB_CONNECTION
            p.setSalary(null);  
        }

        if (ids == null) {
            DB.addPerson(con, p);
        } else {
            DB.updatePerson(con, p);
        }
        response.sendRedirect("index.jsp"); 
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
