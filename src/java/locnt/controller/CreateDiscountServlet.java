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
import locnt.discountcode.DiscountCodeDAO;

/**
 *
 * @author LocPC
 */
public class CreateDiscountServlet extends HttpServlet {
    
    private final String SUCCESS = "createDiscount.jsp";

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
        String url = SUCCESS;
        
        try {
            String codeDiscount = request.getParameter("txtCodeDiscount");
            String nameDiscount = request.getParameter("txtNameDiscount");
            String percentString = request.getParameter("txtPercent");
            String dateString = request.getParameter("txtDate");
            
            int percent;
            Date date;
            boolean validate = true;
            if (!percentString.isEmpty()) {
                percent = Integer.parseInt(percentString);
            } else {
                percent = 0;
            }
            if (!dateString.isEmpty()) {
                Date dateNow = new Date(System.currentTimeMillis());
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                date = new Date(sdf.parse(dateString).getTime());
                if (!date.after(dateNow)) {
                    validate = false;
                }
            } else {
                date = null;
            }
            if (validate) {
                DiscountCodeDAO dao = new DiscountCodeDAO();
                boolean result = dao.insertDiscount(codeDiscount, nameDiscount, percent, date);
                if (result) {
                    request.setAttribute("createMsg", codeDiscount + " will approve " + dateString);
                }
            }
        } catch (ParseException ex) {
            log("CreateDiscountServlet_Parse " + ex.getMessage());
        } catch (SQLException ex) {
            log("CreateDiscountServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("CreateDiscountServlet_Naming " + ex.getMessage());
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
