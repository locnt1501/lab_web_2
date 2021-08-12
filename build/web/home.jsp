<%-- 
    Document   : home
    Created on : Aug 12, 2021, 9:32:57 AM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Home Dream Travel Page</title>
        <meta charset="utf-8">
        <meta name="robots" content="noindex, nofollow">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="homeStyle.css" rel="stylesheet">
    </head>
    <body>
        <div>
            <nav class="navbar navbar-expand-sm navbar-dark ">
                <a class="navbar-brand display-4" style="color: white">Book</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav ml-auto">
                        <c:set var="user" value="${sessionScope.USER}"/>
                        <c:if test="${empty user}">
                            <li class="nav-item">
                                <a class="nav-link active" href="login.jsp">Login</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty user}">
                            <li class="nav-item">
                                <c:if test="${user.roleId == 1}">
                                <li><a class="navbar-brand display-4" href="manageBook.jsp">Manage Book</a></li>
                                </c:if>
                            </li>
                            <li class="nav-item dropdown active ">
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" >
                                    ${user.name}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <li><a class="dropdown-item" href="viewCart">View Your Card</a></li>
                                        <c:url var="logout" value="DispatcherController">
                                            <c:param name="btAction" value="Logout" />
                                        </c:url>
                                    <li><a class="dropdown-item" href="${logout}">Log Out</a></li>
                                </ul>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </nav>
            <div class="jumbotron row" style="position: relative;">
                <div class="col-12" >
                    <form action="DispatcherController">
                        <div class="row justify-content-center">
                            <div class="card " style="background-color: rgba(0,0,0,0.3);" >
                                <div class="card-body">
                                    <h1 class="text text-light text-center">Search Book</h1>
                                    <form action="search">
                                        <div class="form-group">
                                            <label class="text-light">Name</label>
                                            <input class="form-control" placeholder="Name Book" type="text" name="txtBook" value="${param.txtBook}">
                                        </div>
                                        <div class="form-group">
                                            <label class="text-light">Category</label>
                                            <input class="form-control" placeholder="Category" type="text" name="txtCategory" value="${param.txtCategory}">
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-6">
                                                <label class="text-light">Price From(USD)</label>
                                                <input class="form-control" placeholder="Price From (USD)" type="text" name="txtPriceFrom" value="${param.txtPriceFrom}">
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="text-light">Price To(USD)</label>
                                                <input class="form-control" placeholder="Price To (USD)" type="text" name="txtPriceTo" value="${param.txtPriceTo}">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <input type="submit" value="Search" name="btAction" class="btn btn-dark btn-block display-3"/>
                                        </div>                                                         
                                    </form>
                                </div>
                            </div> <!-- card.// -->
                        </div> <!-- row.// -->
                    </form>
                </div>
            </div>
        </div> <!-- header.// -->
        <c:set var="listBook" value="${requestScope.LISTBOOK}"/>
        <c:if test="${not empty listBook}">
            <main role="main" class="container">
                <div class="row">
                    <c:forEach var="book" items="${listBook}">
                        <div class="col-md-4 d-flex" >
                            <div class="card mb-4 box-shadow">
                                <img class="card-img-top"
                                     src="${book.imageLink}"
                                     alt="Card image cap">
                                <div class="card-body">
                                    <h5>${book.title}</h5>
                                    <p>Price: ${book.price} USD</p>
                                    <p>Description: ${book.description}</p>
                                    <p>Author: ${book.author}</p>
                                    <p>Category: ${book.category}</p>
                                    <p>Quantity ${book.quantity}</p>
                                    <form action="addToCart" method="POST">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <input type="hidden" name="txtBook" value="${param.txtBook}"/>
                                            <input type="hidden" name="txtCategory" value="${param.txtCategory}"/>
                                            <input type="hidden" name="txtPriceFrom" value="${param.txtPriceFrom}"/>
                                            <input type="hidden" name="txtPriceTo" value="${param.txtPriceTo}"/>
                                            <c:if test="${not empty user && user.roleId != 1}">
                                                <c:if test="${book.quantity != 0}">
                                                    <input type="submit" value="Add to Cart" name="btAction" class="btn btn-sm btn-success"/>
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div> <!-- row.// -->
            </main>
        </c:if>
        <c:if test="${empty listBook}">
            <h4 class="alert alert-danger container">No Result</h4> 
        </c:if>
    </body>
</html>
