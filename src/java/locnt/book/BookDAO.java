/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.book;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import locnt.category.CategoryDAO;
import locnt.dtos.BookDTO;
import locnt.dtos.CategoryDTO;
import locnt.utils.DBUtils;

/**
 *
 * @author LocPC
 */
public class BookDAO implements Serializable {

    private List<BookDTO> listBook;

    public List<BookDTO> getListBook() {
        return listBook;
    }

    public void searchBook(String title, int category, float priceFrom, float priceTo) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "Select BookId, Title, ImageLink, Description, Price, Author, CategoryId, DateImport, Quantity "
                        + "FROM Book "
                        + "WHERE StatusId = 2 AND Quantity > 0 AND Title = ? AND CategoryId = ? AND Price BETWEEN ? AND ? ";
                stm = con.prepareStatement(sql);
                stm.setString(1, title);
                stm.setInt(2, category);
                stm.setFloat(3, priceFrom);
                stm.setFloat(4, priceTo);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int bookId = rs.getInt("BookId");
                    String tileDB = rs.getString("Title");
                    String imageLink = rs.getString("ImageLink");
                    String description = rs.getString("Description");
                    float price = rs.getFloat("Price");
                    String author = rs.getString("Author");
                    int categoryId = rs.getInt("CategoryId");
                    Date date = rs.getDate("DateImport");
                    int quantity = rs.getInt("Quantity");

                    CategoryDAO categoryDAO = new CategoryDAO();
                    CategoryDTO categoryDTO = categoryDAO.searchCategoryById(categoryId);

                    BookDTO dto = new BookDTO(bookId, tileDB, imageLink,
                            description, price, author, categoryDTO, date, quantity);
                    if (this.listBook == null) {
                        this.listBook = new ArrayList<>();
                    }
                    this.listBook.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public void searchBookByStatusAndTitle(String title, int status) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "Select BookId, Title, ImageLink, Description, Price, Author, CategoryId, DateImport, Quantity "
                        + "FROM Book "
                        + "WHERE StatusId = ? AND Title = ? ";
                stm = con.prepareStatement(sql);
                stm.setInt(1, status);
                stm.setString(2, title);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int bookId = rs.getInt("BookId");
                    String tileDB = rs.getString("Title");
                    String imageLink = rs.getString("ImageLink");
                    String description = rs.getString("Description");
                    float price = rs.getFloat("Price");
                    String author = rs.getString("Author");
                    int categoryId = rs.getInt("CategoryId");
                    Date date = rs.getDate("DateImport");
                    int quantity = rs.getInt("Quantity");

                    CategoryDAO categoryDAO = new CategoryDAO();
                    CategoryDTO categoryDTO = categoryDAO.searchCategoryById(categoryId);

                    BookDTO dto = new BookDTO(bookId, tileDB, imageLink,
                            description, price, author, categoryDTO, date, quantity);
                    if (this.listBook == null) {
                        this.listBook = new ArrayList<>();
                    }
                    this.listBook.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public boolean updateBook(int bookId, String title, float price,
            String author, int category, Date dateImport, int quantity) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "UPDATE Book Set Title = ?, Price = ?, Author = ?, CategoryId = ?, DateImport = ?, Quantity = ? "
                        + "WHERE BookId = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, title);
                stm.setFloat(2, price);
                stm.setString(3, author);
                stm.setInt(4, category);
                stm.setDate(5, dateImport);
                stm.setInt(6, quantity);
                stm.setInt(7, bookId);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {

            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean deleteBook(int bookId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "UPDATE Book Set StatusId = 3 "
                        + "WHERE BookId = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, bookId);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {

            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean insertBook(String title, String imageLink, String description,
            float price, String author, int category, Date dateImport, int quantity, int status) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "INSERT INTO Book VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, title);
                stm.setString(2, imageLink);
                stm.setString(3, description);
                stm.setFloat(4, price);
                stm.setString(5, author);
                stm.setInt(6, category);
                stm.setDate(7, dateImport);
                stm.setInt(8, quantity);
                stm.setInt(9, status);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {

            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    

}
