/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnt.discountcode.DiscountCodeDAO;
import locnt.dtos.DiscountCodeDTO;
import locnt.dtos.UserDTO;
import locnt.dtos.UserHaveDiscountDTO;
import locnt.userHaveDiscount.UserHaveDiscountDAO;

/**
 *
 * @author LocPC
 */
public class CheckCodeServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            UserDTO userDTO = (UserDTO) session.getAttribute("USER");
            String discountCode = request.getParameter("txtDiscountCode");
            DiscountCodeDAO dao = new DiscountCodeDAO();

            UserHaveDiscountDAO daoUserHaveDiscount = new UserHaveDiscountDAO();
            UserHaveDiscountDTO uhdDTO = daoUserHaveDiscount.checkUserUseDiscount(discountCode, userDTO.getUserId());
            if (uhdDTO == null) {
                DiscountCodeDTO dto = dao.checkCode(discountCode);
                if (dto != null) {
                    float total = (float) session.getAttribute("total");
                    float totalAfterDiscount = total - (total * dto.getPercentDiscount() / 100);

                    request.setAttribute("AFTERDISCOUNT", totalAfterDiscount);
                    request.setAttribute("DISCOUNT", total * dto.getPercentDiscount() / 100);
                } else {
                    request.setAttribute("errorDiscout", discountCode + " invalid");
                }
            } else {
                request.setAttribute("errorDiscout", "you have been used " + discountCode);
            }

        } catch (NamingException ex) {
            Logger.getLogger(CheckCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CheckCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
