/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.dtos;

import java.io.Serializable;

/**
 *
 * @author LocPC
 */
public class BookingDetailDTO implements Serializable {

    private int bookingDetailId;
    private int bookId;
    private int quantity;
    private int bookingId;

    public BookingDetailDTO() {
    }

    public BookingDetailDTO(int bookingDetailId, int bookId, int quantity, int bookingId) {
        this.bookingDetailId = bookingDetailId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.bookingId = bookingId;
    }

    public int getBookingDetailId() {
        return bookingDetailId;
    }

    public void setBookingDetailId(int bookingDetailId) {
        this.bookingDetailId = bookingDetailId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

}
