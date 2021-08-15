/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.booking;

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
public class BookingDAO implements Serializable {

    public int checkoutBookingReturnBookingID(Date createDate, float totalMoney, int status, String userId, String discountId) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnect();
            String sql = "INSERT INTO Booking OUTPUT inserted.BookingId VALUES (?, ?, ?, ?, ?)";
            stm = con.prepareStatement(sql);
            stm.setDate(1, createDate);
            stm.setFloat(2, totalMoney);
            stm.setInt(3, status);
            stm.setString(4, userId);
            stm.setString(5, discountId);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("BookingId");
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

        return -1;
    }
}
