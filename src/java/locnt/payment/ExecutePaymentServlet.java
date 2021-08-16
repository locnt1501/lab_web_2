/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.payment;

import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
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

/**
 *
 * @author LocPC
 */
public class ExecutePaymentServlet extends HttpServlet {

    private final String ERROR = "error.jsp";
    private final String SUCCESS = "receipt.jsp";
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
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
        String url = FAIL;
        boolean result = false;
        try {
            HttpSession session = request.getSession();
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.executePayment(paymentId, payerId);

            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);

            String total = (String) session.getAttribute("total");
            UserDTO dto = (UserDTO) session.getAttribute("USER");
            String discountCode = (String) session.getAttribute("discountCode");
            Date createDate = new Date(System.currentTimeMillis());
            BookingDAO dao = new BookingDAO();
            HashMap<Integer, CartDTO> listResourceCart = (HashMap<Integer, CartDTO>) session.getAttribute("CART");
            // insert booking vs bookingdetail
            int bookingId = dao.checkoutBookingReturnBookingID(createDate,
                    Float.parseFloat(total), 1, dto.getUserId(), discountCode);
            BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
            for (CartDTO element : listResourceCart.values()) {
                BookDAO bookDAO = new BookDAO();
                BookDTO bookDTO = bookDAO.searchBookById(element.getBookId());
                result = bookingDetailDAO.insertBookingDetails(element.getBookId(),
                        element.getAmount(), bookingId);
                bookDAO.updateQuantity(bookDTO.getQuantity() - element.getAmount(),
                        bookDTO.getBookId());

            }
            if (result) {
                url = SUCCESS;
                request.setAttribute("payer", payerInfo);
                request.setAttribute("transaction", transaction);
                session.removeAttribute("CART");
                session.removeAttribute("discountCode");
            }

        } catch (PayPalRESTException ex) {
            url = ERROR;
            log("ExecutePaymentServlet_PayPalREST " + ex.getMessage());
        } catch (SQLException ex) {
            log("ExecutePaymentServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("ExecutePaymentServlet_Naming " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
