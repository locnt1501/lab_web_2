/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnt.category.CategoryDAO;
import locnt.dtos.BookDTO;
import locnt.dtos.CategoryDTO;
import locnt.dtos.UserDTO;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 *
 * @author LocPC
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class DispatcherController extends HttpServlet {

    private final String ERROR_PAGE = "errors.html";
    private final String HOME_PAGE = "home.jsp";
    private final String LOGIN_SERVLET = "LoginServlet";
    private final String LOGOUT_SERVLET = "LogoutServlet";
    private final String SEARCH_BOOK_SERVLET = "SearchBookServlet";
    private final String MANAGE_BOOK_SERVLET = "ManageBookServlet";
    private final String DELETE_BOOK_SERVLET = "DeleteBookServlet";
    private final String UPDATE_BOOK_SERVLET = "UpdateBookServlet";
    private final String UPDATE_CART_SERVLET = "UpdateCartServlet";
    private final String CREATE_BOOK_SERVLET = "CreateBookServlet";
    private final String CREATE_DISCOUNT_SERVLET = "CreateDiscountServlet";
    private final String HISTORY_SHOPPING_SERVLET = "HistoryShoppingServlet";
    private final String ADD_ITEM_TO_CART_SERVLET = "AddItemToCartServlet";
    private final String REMOVE_ITEM_SERVLET = "RemoveItemServlet";
    private final String CHECK_CODE_SERVLET = "CheckCodeServlet";
    private final String CHECK_OUT_SERVLET = "CheckoutServlet";
    private final String EDIT_BOOK_SERVLET = "EditBookServlet";
    private final String SHOW_HISTORY_BOOKING_SERVLET = "ShowHistoryBookingServlet";
    private final String CHECK_OUT_PAYPAL_SERVLET = "AuthorizePaymentServlet";
    private final String REVIEW_PAYMENT_SERVLET = "ReviewPaymentServlet";
    private final String EXECUTE_PAYMENT_SERVLET = "ExecutePaymentServlet";

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
        String url = ERROR_PAGE;
        try {
            String button = null;
            Hashtable hashtable = getParams(request);
            if (!hashtable.isEmpty()) {
                button = (String) hashtable.get("btAction");
            } else {
                button = request.getParameter("btAction");
            }

            CategoryDAO dao = new CategoryDAO();
            dao.showAllCategory();
            HttpSession session = request.getSession();
            List<CategoryDTO> listCategory = dao.getListCategory();
            session.setAttribute("LISTCATEGORY", listCategory);
            UserDTO user = (UserDTO) session.getAttribute("USER");
            if (button == null) {
                url = HOME_PAGE;
            } else if (button.equals("Login")) {
                url = LOGIN_SERVLET;
            } else if (button.equals("Logout")) {
                url = LOGOUT_SERVLET;
            } else if (button.equals("Search")) {
                url = SEARCH_BOOK_SERVLET;
            } else {
                if (user != null) {
                    if (user.getRoleId() == 1) { // role admin
                        if (button.equals("Create Book")) {
                            url = CREATE_BOOK_SERVLET;
                        } else if (button.equals("Edit")) {
                            url = EDIT_BOOK_SERVLET;
                        } else if (button.equals("Create Discount")) {
                            url = CREATE_DISCOUNT_SERVLET;
                        } else if (button.equals("Delete")) {
                            url = DELETE_BOOK_SERVLET;
                        } else if (button.equals("Save")) {
                            url = UPDATE_BOOK_SERVLET;
                        } else if (button.equals("SearchBook")) {
                            url = MANAGE_BOOK_SERVLET;
                        }
                    } else if (user.getRoleId() == 2) { // role user
                        if (button.equals("SearchHistory")) {
                            url = HISTORY_SHOPPING_SERVLET;
                        } else if (button.equals("Add to Cart")) {
                            url = ADD_ITEM_TO_CART_SERVLET;
                        } else if (button.equals("Remove")) {
                            url = REMOVE_ITEM_SERVLET;
                        } else if (button.equals("Check Code")) {
                            url = CHECK_CODE_SERVLET;
                        } else if (button.equals("Update")) {
                            url = UPDATE_CART_SERVLET;
                        } else if (button.equals("Checkout")) {
                            url = CHECK_OUT_SERVLET;
                        } else if (button.equals("SearchHistory")) {
                            url = SHOW_HISTORY_BOOKING_SERVLET;
                        } else if (button.equals("checkOutPaypal")) {
                            url = CHECK_OUT_PAYPAL_SERVLET;
                        } else if (button.equals("ReviewPayment")) {
                            url = REVIEW_PAYMENT_SERVLET;
                        } else if (button.equals("Pay Now")) {
                            url = EXECUTE_PAYMENT_SERVLET;
                        }
                    }
                }
            }

        } catch (NamingException ex) {
            log("DispatcherControllerServlet_Naming " + ex.getMessage());
        } catch (SQLException ex) {
            log("DispatcherControllerServlet_SQL " + ex.getMessage());
        } catch (FileUploadException ex) {
            log("DispatcherControllerServlet_FileUpload " + ex.getMessage());
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

    private Hashtable getParams(HttpServletRequest request) throws FileUploadException,
            NamingException, SQLException {
        boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
        Hashtable params = new Hashtable();
        String imageLink = null;
        if (isMultiPart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
            String fileName = null;
            Iterator<FileItem> iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = iter.next();
                if (item.isFormField()) {
                    params.put(item.getFieldName(), item.getString());
                } else {
                    try {
                        String itemName = item.getName();
                        fileName = itemName.substring(itemName.lastIndexOf("\\") + 1);
                        String realPath = getServletContext().getRealPath("/")
                                + "images\\" + fileName;
                        File saveFile = new File(realPath);
                        item.write(saveFile);
                        imageLink = "images\\" + fileName;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }

            String title = (String) params.get("txtTitle");
            String author = (String) params.get("txtAuthor");
            String description = (String) params.get("txtDescription");
            String categoryString = (String) params.get("txtCategory");
            String priceString = (String) params.get("txtPrice");
            String quantityString = (String) params.get("txtQuantity");

            int category = Integer.parseInt(categoryString);
            CategoryDAO categoryDAO = new CategoryDAO();
            CategoryDTO categoryDTO = categoryDAO.searchCategoryById(category);
            float price = Float.parseFloat(priceString);

            int quantity = Integer.parseInt(quantityString);

            Date dateImport = new Date(System.currentTimeMillis());

            BookDTO dto = new BookDTO(0, title, imageLink, description, price,
                    author, categoryDTO, dateImport, quantity, 1);
            HttpSession session = request.getSession();
            session.setAttribute("CREATEBOOK", dto);
        }
        return params;
    }
}
