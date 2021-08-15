/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.dtos;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author LocPC
 */
public class BookingHistoryDTO implements Serializable {
    private int bookingId;
    private Date bookingDate;
    private String status;
    private List<String> listBook;

    public BookingHistoryDTO() {
    }

    public BookingHistoryDTO(int bookingId, Date bookingDate, String status, List<String> listBook) {
        this.bookingId = bookingId;
        this.bookingDate = bookingDate;
        this.status = status;
        this.listBook = listBook;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<String> getListBook() {
        return listBook;
    }

    public void setListBook(List<String> listBook) {
        this.listBook = listBook;
    }

    
    
    
}
