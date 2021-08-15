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
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import locnt.dtos.BookingHistoryDTO;
import locnt.utils.DBUtils;

/**
 *
 * @author LocPC
 */
public class BookingDAO implements Serializable {

    private List<BookingHistoryDTO> listBookingHistory;

    public List<BookingHistoryDTO> getListBookingHistory() {
        return listBookingHistory;
    }

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

    public void getHistoryBooking(String userId, Date dateCreate) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnect();
            if (con != null) {
                String sql = "SELECT  b.BookingDate, s.Name, b.BookingId "
                        + "FROM Booking b, Status s "
                        + "WHERE b.StatusId = s.StatusId and b.UserId = ? and b.BookingDate <= ? ORDER BY b.BookingDate";
                stm = con.prepareStatement(sql);
                stm.setString(1, userId);
                stm.setDate(2, dateCreate);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int bookingId = rs.getInt("BookingId");
                    Date bookingDate = rs.getDate("BookingDate");
                    String status = rs.getString("Name");

                    String subSql = "SELECT b.Title "
                            + "FROM BookingDetail bd, Book b "
                            + "WHERE b.BookId = bd.BookId and bd.BookingId = " + bookingId;
                    stm = con.prepareStatement(subSql);
                    ResultSet rsSub = stm.executeQuery();
                    List<String> listItemName = new ArrayList<>();
                    while (rsSub.next()) {
                        listItemName.add(rsSub.getString("Title"));
                    }

                    BookingHistoryDTO dto = new BookingHistoryDTO(bookingId, bookingDate, status, listItemName);
                    if (listBookingHistory == null) {
                        this.listBookingHistory = new ArrayList<BookingHistoryDTO>();
                    }
                    this.listBookingHistory.add(dto);
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
}
