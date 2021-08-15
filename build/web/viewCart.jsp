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
            <c:url var="home" value="DispatcherController"/>
            <nav class="navbar navbar-expand-sm navbar-dark ">
                <a class="navbar-brand display-4" href="${home}">Book</a>
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
                                    <li><a class="dropdown-item" href="viewCart.jsp">View Your Card</a></li>
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
        </div>
        <c:set var="listBookCart" value="${sessionScope.CART}"/>
        <c:if test="${not empty listBookCart}">
            <div class="container">
                <form action="DispatcherController">
                    <table class="table table-hover table-condensed">
                        <thead>
                            <tr>
                                <th style="width: 52%;">Book name</th>
                                <th style="width: 10%;">Amount</th>
                                <th style="width: 8%;">Price</th>
                                <th style="width: 10%;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${listBookCart}">
                            <form action="DispatcherController">
                                <c:set var="bookValue" value="${book.value}"/>
                                <tr>
                                    <td style="width: 20%;">${bookValue.name} </td>
                                    <td style="width: 10%;">
                                        <input type="number" name="txtQuantity" value="${bookValue.amount}" />
                                    </td>
                                    <td style="width: 10%;">${bookValue.price * bookValue.amount}</td>
                                    <td style="width: 10%;">
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <input type="submit" value="Update" name="btAction" />
                                                    </td>
                                                    <td>
                                                        <input type="hidden" name="txtBookId" value="${book.key}" />
                                                        <input type="submit" value="Remove" name="btAction" onclick="return confirm('Are your sure?');"/>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </form>
                        </c:forEach>
                        </tbody>
                    </table>
                </form>
                <c:if test="${not empty requestScope.outOfStock}">
                    <h6 class="alert alert-danger container">${requestScope.outOfStock}</h6> 
                </c:if>
                <div class="row">
                    <div class="col-8">
                        <h4>Ship COD</h4>
                        <form action="DispatcherController" method="POST">
                            <input type="hidden" name="discountCode" value="${param.txtDiscountCode}" />
                            <input type="hidden" name="txtTotal" value="${sessionScope.total - (sessionScope.total * sessionScope.discountPercent / 100)}" />
                            <input type="submit" value="Checkout" class="btn btn-primary btn-lg btn-block" name="btAction"/>
                        </form>
                    </div>
                    <div class="col-4">
                        <h4 class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted">Your cart</span>
                            <span class="badge badge-secondary badge-pill">${listBookCart.size()} </span>
                        </h4>
                        <ul class="list-group mb-3">
                            <li class="list-group-item d-flex justify-content-between lh-condensed">
                                <div>
                                    <h6 class="my-0">Total temporary</h6>
                                </div>
                                <span class="text-muted">$${sessionScope.total}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between bg-light">
                                <div class="text-success">
                                    <h6 class="my-0">Discount Code</h6>
                                    <small>${sessionScope.discountCode}</small>
                                </div>
                                <span class="text-success">-$${sessionScope.total * sessionScope.discountPercent / 100}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between lh-condensed">
                                <span>Total (USD)</span>
                                <strong>$${sessionScope.total - (sessionScope.total * sessionScope.discountPercent / 100)}</strong>
                            </li>
                        </ul>
                        <form class="card p-2" action="DispatcherController">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Discount code" name="txtDiscountCode" value="${param.txtDiscountCode}">
                                <div class="input-group-append">
                                    <input type="hidden" name="txtTotal" value="${sessionScope.total}" />
                                    <input type="submit" value="Check Code" name="btAction" class="btn btn-secondary"/>
                                </div>
                            </div>
                            <c:if test="${not empty requestScope.errorDiscout}">
                                <h6 class="alert alert-danger container">${requestScope.errorDiscout}</h6> 
                            </c:if>
                        </form>
                    </div>
                </div>
                <h4>Payment with Paypal</h4>
                <c:url var="checkOutUrlPayPal" value="DispatcherController">
                    <c:if test="${requestScope.DISCOUNT_CODE != 'ERROR'}">
                        <c:param name="txtTotal" value="${sessionScope.total - (sessionScope.total * sessionScope.discountPercent / 100)}"/>
                    </c:if>
                    <c:param name="btAction" value="checkOutPaypal"/>
                </c:url>
                <a href="${checkOutUrlPayPal}"
                   class="btn btn-info btn-block">Checkout PayPal<i class="fa fa-angle-right"></i></a>
                <a href="${home}" class="btn btn-warning"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i> Continue Shopping</a>
            </div>
        </c:if>
        <c:if test="${empty listBookCart}">
            <div class="container" style="margin-top: 10px ">
                <h4 class="alert alert-danger">No Items</h4> 
                <a href="DispatcherController" class="btn btn-warning"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i> Continue Shopping</a>
            </div>
        </c:if>

    </body>
</html>
