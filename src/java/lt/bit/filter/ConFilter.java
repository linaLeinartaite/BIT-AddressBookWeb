
package lt.bit.filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.rmi.ServerException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 *
 * @author Lina
 */
@WebFilter(filterName = "ConFilter", urlPatterns = {"/*"})
public class ConFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception ex) {
            throw new ServletException("Failed to load JDBC driver", ex);
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/addressbook?serverTimezone=UTC&characterEncoding=UTF-8", "root", "root")) {
            request.setAttribute("con", con);
            chain.doFilter(request, response);
        } catch (Exception ex) {
            throw new ServletException("Failed to connect to DB", ex);
        }
    }

    @Override
    public void destroy() {
    }
}
