/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import locnt.book.BookDAO;
import locnt.dtos.BookDTO;
import locnt.dtos.StatusDTO;
import locnt.status.StatusDAO;

/**
 *
 * @author LocPC
 */
public class EditBookServlet extends HttpServlet {

    private final String FAIL = "home.jsp";
    private final String SUCCESS = "manageBook.jsp";

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
            int bookId = Integer.parseInt(request.getParameter("txtBookId"));
            int category = Integer.parseInt(request.getParameter("txtCategory"));
            String title = request.getParameter("txtTitle");
            BookDAO dao = new BookDAO();
            BookDTO bookDTO = dao.searchBookById(bookId);
            List<BookDTO> listBook = new ArrayList<>();
            listBook.add(bookDTO);
            request.setAttribute("LISTBOOKMANAGE", listBook);
            url = SUCCESS;
            request.setAttribute("searchValue", title);
            request.setAttribute("searchCategory", category);
            StatusDAO statusDAO = new StatusDAO();
            statusDAO.getAllStatus();
            List<StatusDTO> listStatus = statusDAO.getListStatus();
            request.setAttribute("LISTSTATUS", listStatus);
        } catch (NamingException ex) {
            log("EditBookServlet_Naming " + ex.getMessage());
        } catch (SQLException ex) {
            log("EditBookServlet_SQL " + ex.getMessage());
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
