/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.userHaveDiscount;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import locnt.dtos.UserHaveDiscountDTO;
import locnt.utils.DBUtils;

/**
 *
 * @author LocPC
 */
public class UserHaveDiscountDAO implements Serializable {

    public boolean insertUserUseDiscount(String discountCode, String userId)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "INSERT INTO UserHaveDiscount VALUES (?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, userId);
                stm.setString(2, discountCode);
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

    public UserHaveDiscountDTO checkUserUseDiscount(String discountCode, String userId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "SELECT DiscountAcceptID, UserID, DiscountId "
                        + "FROM UserHaveDiscount "
                        + "WHERE UserID = ? AND DiscountId = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userId);
                stm.setString(2, discountCode);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int id = rs.getInt("DiscountAcceptID");
                    String user = rs.getString("UserID");
                    String discountId = rs.getString("DiscountId");
                    UserHaveDiscountDTO dto = new UserHaveDiscountDTO(id, user, discountId);
                    return dto;
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
        return null;
    }
}
