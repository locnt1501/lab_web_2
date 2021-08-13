/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.category;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import locnt.dtos.BookDTO;
import locnt.dtos.CategoryDTO;
import locnt.utils.DBUtils;

/**
 *
 * @author LocPC
 */
public class CategoryDAO implements Serializable {

    private List<CategoryDTO> listCategory;

    public List<CategoryDTO> getListCategory() {
        return listCategory;
    }

    public void showAllCategory() throws NamingException, SQLException {
        Connection con = null;
        Statement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "Select CategoryId, Name FROM Category";
                stm = con.createStatement();
                rs = stm.executeQuery(sql);
                while (rs.next()) {
                    int category = rs.getInt("CategoryId");
                    String name = rs.getString("Name");
                    CategoryDTO dto = new CategoryDTO(category, name);
                    if (this.listCategory == null) {
                        this.listCategory = new ArrayList<>();
                    }
                    this.listCategory.add(dto);
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

    public CategoryDTO searchCategoryById(int categoryId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "Select CategoryId, Name FROM Category WHERE CategoryId = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, categoryId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int category = rs.getInt("CategoryId");
                    String name = rs.getString("Name");
                    CategoryDTO dto = new CategoryDTO(category, name);
                    return dto;
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
        return null;
    }
}
