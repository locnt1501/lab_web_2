/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.bookingdetail;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.NamingException;
import locnt.utils.DBUtils;

/**
 *
 * @author LocPC
 */
public class BookingDetailDAO implements Serializable {

    public boolean insertBookingDetails(int bookId, int quantity, int bookingId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "INSERT INTO BookingDetail VALUES(?, ?, ?) ";
                stm = con.prepareStatement(sql);
                stm.setInt(1, bookId);
                stm.setInt(2, quantity);
                stm.setInt(3, bookingId);
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
