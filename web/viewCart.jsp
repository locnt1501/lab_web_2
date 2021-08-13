<%-- 
    Document   : viewCart
    Created on : Aug 12, 2021, 11:26:31 PM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cart Page</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <link href="homeStyle.css" rel="stylesheet">
    </head>
    <body>
        <div>
            <nav class="navbar navbar-expand-sm navbar-dark ">
                <a class="navbar-brand display-4" href="home.jsp">Book</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav ml-auto">
                        <c:set var="user" value="${sessionScope.USER}"/>
                        <c:if test="${empty user}">
                            <li class="nav-item">
                                <a class="nav-link active" href="login.jsp">Login</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty user}">
                            <li class="nav-item dropdown active ">
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
                                    ${sessionScope.USER.name}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <li><a class="dropdown-item" href="viewCard.JSP">View Your Card</a></li>
                                    <li><a class="dropdown-item" href="logout">Log Out</a></li>
                                </ul>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </nav>
        </div>
        <c:set var="listBookCart" value="${sessionScope.CART}"/>
        <c:if test="${not empty listBookCart}">
            <div class="container">
                <table class="table table-hover table-condensed">
                    <thead>
                        <tr>
                            <th style="width: 52%;">Book name</th>
                            <th style="width: 10%;">Amount</th>
                            <th style="width: 8%;">Price</th>
                            <th style="width: 20%;" class="text-center">Subtotal</th>
                            <th style="width: 10%;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="book" items="${listBookCart}">
                            <c:set var="bookValue" value="${book.value}"/>
                            <tr>
                                <td style="width: 52%;">${bookValue.name}</td>
                                <td style="width: 10%;">
                                    <input type="number" name="txtQuantity" value="${bookValue.amount}" />
                                </td>
                                <td style="width: 8%;">${bookValue.price}</td>
                                <td style="width: 20%;" class="text-center">${bookValue.amount * bookValue.price}</td>
                                <td style="width: 10%;">
                                    <input type="submit" value="Remove" name="btAction" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td>
                                <a href="home.jsp" class="btn btn-warning"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i> Continue Shopping</a>
                            </td>
                            <td colspan="2" class="hidden-xs">

                            </td>
                            <td class="hidden-xs text-center">
                                <strong>Total $${requestScope.TOTALPRICE}</strong>
                            </td>
                            <td>
                                <a href="" class="btn btn-success btn-block">Checkout <i class="fa fa-angle-right"></i></a>
                            </td>
                        </tr>
                    </tfoot>
                </table>
                <div class="row">
                    <div class="col-8">
                        <h4>Payment</h4>
                        <form action="checkout" method="POST">
                            <input type="hidden" name="txtTotal" value="${requestScope.total - (requestScope.total * sessionScope.discountPercent / 100)}" />
                            <button class="btn btn-primary btn-lg btn-block" type="submit">Continue to checkout</button>
                        </form>
                    </div>
                    <div class="col-4">
                        <h4 class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted">Your cart</span>
                            <span class="badge badge-secondary badge-pill">${listTourCart.size()} </span>
                        </h4>
                        <ul class="list-group mb-3">
                            <li class="list-group-item d-flex justify-content-between lh-condensed">
                                <div>
                                    <h6 class="my-0">Total temporary</h6>
                                </div>
                                <span class="text-muted">$${requestScope.total}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between bg-light">
                                <div class="text-success">
                                    <h6 class="my-0">Discount Code</h6>
                                    <small>${sessionScope.discountCode}</small>
                                </div>
                                <span class="text-success">-$${requestScope.total * sessionScope.discountPercent / 100}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between lh-condensed">
                                <span>Total (USD)</span>
                                <strong>$${requestScope.total - (requestScope.total * sessionScope.discountPercent / 100)}</strong>
                            </li>
                        </ul>
                        <form class="card p-2" action="checkDiscountCode">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Discount code" name="txtDiscountCode" value="${sessionScope.discountCode}">
                                <div class="input-group-append">
                                    <input type="hidden" name="txtTotal" value="${requestScope.total}" />
                                    <button type="submit" class="btn btn-secondary">Check Code</button>
                                </div>
                            </div>
                            <c:if test="${not empty requestScope.errorDiscout}">
                                <h6 class="alert alert-danger container">${requestScope.errorDiscout}</h6> 
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${empty listBookCart}">
            <div class="container">
                <h4 class="alert alert-danger">No Items</h4> 
                <a href="home.jsp" class="btn btn-warning"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i> Continue Shopping</a>
            </div>
        </c:if>

    </body>
</html>
