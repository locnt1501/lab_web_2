/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import locnt.book.BookDAO;
import locnt.category.CategoryDAO;
import locnt.dtos.BookDTO;
import locnt.dtos.CategoryDTO;
import locnt.dtos.StatusDTO;
import locnt.status.StatusDAO;

/**
 *
 * @author LocPC
 */
public class ManageBookServlet extends HttpServlet {

    private final String MANAGE_BOOK_PAGE = "manageBook.jsp";

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
        String url = MANAGE_BOOK_PAGE;
        try {
            String valueSearch = request.getParameter("txtSearchValue");
            String categoryId = request.getParameter("ddList");
            CategoryDAO categoryDAO = new CategoryDAO();
            CategoryDTO categoryDTO = categoryDAO.searchCategoryById(Integer.parseInt(categoryId));

            BookDAO dao = new BookDAO();
            dao.searchBookByCategoryAndTitle(valueSearch, categoryDTO.getCategoryId());
            List<BookDTO> listBook = dao.getListBook();
            request.setAttribute("LISTBOOKMANAGE", listBook);
            StatusDAO statusDAO = new StatusDAO();
            statusDAO.getAllStatus();
            List<StatusDTO> listStatus = statusDAO.getListStatus();
            request.setAttribute("LISTSTATUS", listStatus);
        } catch (NamingException ex) {
            log("ManageBookServlet_Naming " + ex.getMessage());
        } catch (SQLException ex) {
            log("ManageBookServlet_SQL " + ex.getMessage());
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
