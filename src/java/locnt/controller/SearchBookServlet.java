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
import locnt.dtos.BookDTO;

/**
 *
 * @author LocPC
 */
public class SearchBookServlet extends HttpServlet {
    
    private final String SUCCESS = "home.jsp";
    private final String FAIL = "home.jsp";

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
            String name = request.getParameter("txtBook");
            int category = Integer.parseInt(request.getParameter("ddList"));
            String priceFromString = request.getParameter("txtPriceFrom");
            String priceToString = request.getParameter("txtPriceTo");
            
            float priceFrom;
            float priceTo;
            boolean validate = true;
            if (!priceFromString.isEmpty() && !priceToString.isEmpty()) {
                priceFrom = Float.parseFloat(priceFromString);
                priceTo = Float.parseFloat(priceToString);
                if (priceFrom >= priceTo || priceFrom < 0) {
                    validate = false;
                }
            } else {
                priceFrom = 0;
                priceTo = 0;
            }
            
            if (validate) {
                BookDAO dao = new BookDAO();
                dao.searchBook(name, category, priceFrom, priceTo);
                List<BookDTO> listBook = dao.getListBook();
                request.setAttribute("LISTBOOK", listBook);
                url = SUCCESS;
            }
        } catch (NamingException ex) {
            log("SearchBookServlet_Naming " + ex.getMessage());
        } catch (SQLException ex) {
            log("SearchBookServlet_SQL " + ex.getMessage());
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
