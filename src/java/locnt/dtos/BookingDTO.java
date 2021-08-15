/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author LocPC
 */
public class BookingDTO implements Serializable {

    private int bookingId;
    private Date bookingDate;
    private float totalMoney;
    private int StatusId;
    private String userId;
    private String discountId;

    public BookingDTO() {
    }

    public BookingDTO(int bookingId, Date bookingDate, float totalMoney, int StatusId, String userId, String discountId) {
        this.bookingId = bookingId;
        this.bookingDate = bookingDate;
        this.totalMoney = totalMoney;
        this.StatusId = StatusId;
        this.userId = userId;
        this.discountId = discountId;
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

    public float getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(float totalMoney) {
        this.totalMoney = totalMoney;
    }

    public int getStatusId() {
        return StatusId;
    }

    public void setStatusId(int StatusId) {
        this.StatusId = StatusId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDiscountId() {
        return discountId;
    }

    public void setDiscountId(String discountId) {
        this.discountId = discountId;
    }

}
