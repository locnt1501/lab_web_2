/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.payment;

import com.paypal.base.rest.PayPalRESTException;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnt.book.BookDAO;
import locnt.booking.BookingDAO;
import locnt.bookingdetail.BookingDetailDAO;
import locnt.dtos.BookDTO;
import locnt.dtos.CartDTO;
import locnt.dtos.UserDTO;
import locnt.userHaveDiscount.UserHaveDiscountDAO;

/**
 *
 * @author LocPC
 */
public class AuthorizePaymentServlet extends HttpServlet {

    private final String FAIL = "viewCart.jsp";

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
        response.setContentType("text/html;charset=UTF-8");
        String total = request.getParameter("txtTotal");
        OrderDetail orderDetail = new OrderDetail("Book", "0", "0", "0", total);
        String url = FAIL;
        boolean flag = false;
        try {
            HttpSession session = request.getSession();
            HashMap<Integer, CartDTO> listResourceCart = (HashMap<Integer, CartDTO>) session.getAttribute("CART");
            session.setAttribute("total", total);
            boolean validateQuantity = true;
            if (listResourceCart != null) {
                // check so luong 
                for (CartDTO element : listResourceCart.values()) {
                    BookDAO bookDAO = new BookDAO();
                    BookDTO bookDTO = bookDAO.searchBookById(element.getBookId());
                    if (bookDTO.getQuantity() - element.getAmount() < 0) {
                        validateQuantity = false;
                        request.setAttribute("outOfStock", bookDTO.getTitle()
                                + " out of stock. Please remove item or decrease quantity item. Thanks!!!");
                    }
                }
                if (validateQuantity) {
                    PaymentServices paymentServices = new PaymentServices();
                    url = paymentServices.authorizePayment(orderDetail);
                    flag = true;
                }
            }

        } catch (PayPalRESTException ex) {
            log("AuthorizePaymentServlet_PayPalREST " + ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (NamingException ex) {
            log("AuthorizePaymentServlet_Naming " + ex.getMessage());
        } catch (SQLException ex) {
            log("AuthorizePaymentServlet_SQL " + ex.getMessage());
        } finally {
            if (flag) {
                response.sendRedirect(url);
            } else {
                request.getRequestDispatcher(url).forward(request, response);

            }
        }
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
