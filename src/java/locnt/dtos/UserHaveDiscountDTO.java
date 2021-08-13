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
public class UserHaveDiscountDTO implements Serializable {

    private int discountAcceptID;
    private String userID;
    private String discountId;

    public UserHaveDiscountDTO() {
    }

    public UserHaveDiscountDTO(int discountAcceptID, String userID, String discountId) {
        this.discountAcceptID = discountAcceptID;
        this.userID = userID;
        this.discountId = discountId;
    }

    public int getDiscountAcceptID() {
        return discountAcceptID;
    }

    public void setDiscountAcceptID(int discountAcceptID) {
        this.discountAcceptID = discountAcceptID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getDiscountId() {
        return discountId;
    }

    public void setDiscountId(String discountId) {
        this.discountId = discountId;
    }

}
