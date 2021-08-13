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
public class DiscountCodeDTO implements Serializable {
    private String discountId;
    private String name;
    private String percentDiscount;
    private String expiryDate;

    public DiscountCodeDTO() {
    }

    public DiscountCodeDTO(String discountId, String name, String percentDiscount, String expiryDate) {
        this.discountId = discountId;
        this.name = name;
        this.percentDiscount = percentDiscount;
        this.expiryDate = expiryDate;
    }

    public String getDiscountId() {
        return discountId;
    }

    public void setDiscountId(String discountId) {
        this.discountId = discountId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPercentDiscount() {
        return percentDiscount;
    }

    public void setPercentDiscount(String percentDiscount) {
        this.percentDiscount = percentDiscount;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    
}
