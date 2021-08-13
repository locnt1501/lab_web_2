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
public class AddItemToCartServlet extends HttpServlet {

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
        String url = null;
        try {
            int bookId = Integer.parseInt(request.getParameter("txtBookId"));
            String name = request.getParameter("txtBookTitle");
            float price = Float.parseFloat(request.getParameter("txtPriceBook"));

            HttpSession session = request.getSession();
            HashMap<Integer, CartDTO> listBookCart = (HashMap<Integer, CartDTO>) session.getAttribute("CART");

            if (listBookCart == null) {
                listBookCart = new HashMap<>();
                CartDTO cartDTO = new CartDTO(bookId, name, 1, price, 0);
                listBookCart.put(bookId, cartDTO);

            } else {
                if (listBookCart.containsKey(bookId)) {
                    listBookCart.get(bookId).setAmount(listBookCart.get(bookId).getAmount() + 1);
                } else {
                    CartDTO cartDTO = new CartDTO(bookId, name, 1, price, 0);
                    listBookCart.put(bookId, cartDTO);
                }
            }

            session.setAttribute("CART", listBookCart);
            // calculate total price
            float totalprice = 0;
            for (Map.Entry<Integer, CartDTO> entry : listBookCart.entrySet()) {
                CartDTO value = entry.getValue();
                totalprice += value.getPrice();
                System.out.println(value.getPrice());
            }
            request.setAttribute("TOTALPRICE", totalprice);
            String bookName = request.getParameter("txtBook");
            String categoryString = request.getParameter("txtCategory");
            String priceFrom = request.getParameter("txtPriceFrom");
            String priceTo = request.getParameter("txtPriceTo");

            url = "DispatcherController"
                    + "?txtBook=" + bookName
                    + "&ddList=" + categoryString
                    + "&txtPriceFrom=" + priceFrom
                    + "&txtPriceTo=" + priceTo
                    + "&btAction=Search";

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
