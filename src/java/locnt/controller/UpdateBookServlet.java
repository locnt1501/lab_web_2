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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import locnt.book.BookDAO;

/**
 *
 * @author LocPC
 */
public class UpdateBookServlet extends HttpServlet {

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
        String url = "";
        try {
            String searchValue = request.getParameter("txtSearchValue");
            String status = request.getParameter("ddList");

            String bookIdString = request.getParameter("txtBookId");
            String title = request.getParameter("txtTitle");
            String priceString = request.getParameter("txtPrice");
            String author = request.getParameter("txtAuthor");
            String category = request.getParameter("txtCategory");
            String dateImportString = request.getParameter("txtDate");
            String quantiyString = request.getParameter("txtQuantity");

            Date dateImport;
            float price;
            int quantity;
            int bookId;
            if (!priceString.isEmpty()) {
                price = Float.parseFloat(priceString);
            } else {
                price = 0;
            }

            if (!dateImportString.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                dateImport = new Date(sdf.parse(dateImportString).getTime());
            } else {
                dateImport = null;
            }

            if (!quantiyString.isEmpty()) {
                quantity = Integer.parseInt(quantiyString);
            } else {
                quantity = 0;
            }
            if (!bookIdString.isEmpty()) {
                bookId = Integer.parseInt(bookIdString);
            } else {
                bookId = 0;
            }
            BookDAO dao = new BookDAO();
            boolean updateBook = dao.updateBook(bookId, title, price, author, category, dateImport, quantity);
            if (updateBook) {
                url = "DispatcherController"
                        + "?txtSearchValue=" + searchValue
                        + "&ddList=" + status
                        + "&btAction=SearchBook";
            }
        } catch (NamingException ex) {
            Logger.getLogger(UpdateBookServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateBookServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(UpdateBookServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            response.sendRedirect(url);
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
