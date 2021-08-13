/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.discountcode;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import locnt.utils.DBUtils;

/**
 *
 * @author LocPC
 */
public class DiscountCodeDAO implements Serializable {

    public boolean insertDiscount(String discountCode, String name, int percent, Date expiryDate)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "INSERT INTO DiscountCode VALUES (?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, discountCode);
                stm.setString(2, name);
                stm.setInt(3, percent);
                stm.setDate(4, expiryDate);
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
