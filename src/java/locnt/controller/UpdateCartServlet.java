/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnt.dtos.CartDTO;

/**
 *
 * @author LocPC
 */
public class UpdateCartServlet extends HttpServlet {

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
        try {
            int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
            int bookId = Integer.parseInt(request.getParameter("txtBookId"));
            HttpSession session = request.getSession();
            HashMap<Integer, CartDTO> listBookCart = (HashMap<Integer, CartDTO>) session.getAttribute("CART");

            if (listBookCart != null) {
                if (listBookCart.containsKey(bookId)) {
                    if (quantity > 0) {
                        listBookCart.get(bookId).setAmount(quantity );
                    } else {
                        listBookCart.remove(bookId);
                    }
                }
            }
            // calculate total price
            float totalprice = 0;
            for (Map.Entry<Integer, CartDTO> entry : listBookCart.entrySet()) {
                CartDTO value = entry.getValue();
                totalprice += value.getPrice() * value.getAmount();
            }
            session.setAttribute("total", totalprice);
        } finally {
            request.getRequestDispatcher("viewCart.jsp").forward(request, response);
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
