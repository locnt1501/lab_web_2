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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnt.booking.BookingDAO;
import locnt.dtos.BookingHistoryDTO;
import locnt.dtos.UserDTO;

/**
 *
 * @author LocPC
 */
public class ShowHistoryBookingServlet extends HttpServlet {

    private final String SUCCESS = "historyShopping.jsp";
    private final String FAIL = "invalid.html";

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
            BookingDAO dao = new BookingDAO();
            String dateString = request.getParameter("txtDate");
            Date date;
            boolean validate = true;
            if (!dateString.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                date = new Date(sdf.parse(dateString).getTime());
            } else {
                date = null;
            }
            if (validate) {
                dao.getHistoryBooking(dto.getUserId(), date);
                List<BookingHistoryDTO> listBookingHistory = dao.getListBookingHistory();
                request.setAttribute("LISTBOOKINGHISTORY", listBookingHistory);
            }
            url = SUCCESS;
        } catch (SQLException ex) {
            log("ShowHistoryBookingServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("ShowHistoryBookingServlet_Naming " + ex.getMessage());
        } catch (ParseException ex) {
            log("ShowHistoryBookingServlet_Parse " + ex.getMessage());
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
