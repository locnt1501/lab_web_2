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
public class BookDTO implements Serializable {

    private int bookId;
    private String title;
    private String imageLink;
    private String description;
    private float price;
    private String author;
    private CategoryDTO category;
    private Date dateImport;
    private int quantity;

    public BookDTO(int bookId, String title, String imageLink, String description, float price, String author, CategoryDTO category, Date dateImport, int quantity) {
        this.bookId = bookId;
        this.title = title;
        this.imageLink = imageLink;
        this.description = description;
        this.price = price;
        this.author = author;
        this.category = category;
        this.dateImport = dateImport;
        this.quantity = quantity;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public CategoryDTO getCategory() {
        return category;
    }

    public void setCategory(CategoryDTO category) {
        this.category = category;
    }

    public Date getDateImport() {
        return dateImport;
    }

    public void setDateImport(Date dateImport) {
        this.dateImport = dateImport;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    

}
