/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
public class CheckoutServlet extends HttpServlet {

    private final String FAIL = "viewCart.jsp";
    private final String SUCCESS = "home.jsp";

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
        PrintWriter out = response.getWriter();
        String url = FAIL;
        try {
            HttpSession session = request.getSession();
            UserDTO dto = (UserDTO) session.getAttribute("USER");
            String discountCode = request.getParameter("discountCode");
            float total = Float.parseFloat(request.getParameter("txtTotal"));

            HashMap<Integer, CartDTO> listResourceCart = (HashMap<Integer, CartDTO>) session.getAttribute("CART");
            if (discountCode.isEmpty()) {
                discountCode = null;
            }
            boolean validateQuantity = true;
            boolean result = false;
            if (listResourceCart != null) {
                Date createDate = new Date(System.currentTimeMillis());
                BookingDAO dao = new BookingDAO();
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
                    // insert booking vs bookingdetail
                    int bookingId = dao.checkoutBookingReturnBookingID(createDate, total, 1, dto.getUserId(), discountCode);
                    BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
                    for (CartDTO element : listResourceCart.values()) {
                        BookDAO bookDAO = new BookDAO();
                        BookDTO bookDTO = bookDAO.searchBookById(element.getBookId());
                        result = bookingDetailDAO.insertBookingDetails(element.getBookId(),
                                element.getAmount(), bookingId);
                        bookDAO.updateQuantity(bookDTO.getQuantity() - element.getAmount(),
                                bookDTO.getBookId());
                    }
                }
            }
            if (result) {
                if (discountCode != null && !discountCode.isEmpty()) {
                    UserHaveDiscountDAO haveDiscountDAO = new UserHaveDiscountDAO();
                    haveDiscountDAO.insertUserUseDiscount(discountCode, dto.getUserId());
                }
                url = SUCCESS;
                session.removeAttribute("CART");
                session.removeAttribute("discountCode");
            }
        } catch (SQLException ex) {
            log("CheckoutServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("CheckoutServlet_Naming " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
            out.close();
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
