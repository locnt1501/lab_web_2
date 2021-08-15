<%-- 
    Document   : createDiscount
    Created on : Aug 12, 2021, 11:38:11 PM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Discount Page</title>
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
                <c:url var="home" value="DispatcherController"/>
                <a class="navbar-brand display-4" href="${home}">Book</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item dropdown active ">
                            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
                                ${sessionScope.USER.name}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <c:url var="logout" value="DispatcherController">
                                    <c:param name="btAction" value="Logout" />
                                </c:url>
                                <li><a class="dropdown-item" href="${logout}">Log Out</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        <div class="container">
            <a href="manageBook.jsp">Back</a>
            <div class="card">
                <div class="card-body">
                    <h1 class="text text-center">Create Discount</h1>
                    <form action="DispatcherController" method="POST">
                        <div class="form-group col-12">
                            <label class="">Code Discount:</label>
                            <input class="form-control" placeholder="Code Discount" type="text" name="txtCodeDiscount" required>
                        </div>
                        <div class="row">
                            <div class="form-group col-6">
                                <label class="">Name</label>
                                <input class="form-control" placeholder="Name Discount" type="text" name="txtNameDiscount" required>
                            </div>
                            <div class="form-group col-6">
                                <label class="">Percent Discount</label>
                                <input class="form-control" placeholder="Persent Discount maximum 100" max="100" type="number" name="txtPercent" required>
                            </div>
                        </div>
                        <div class="form-group col-12">
                            <label class="">Expiry Date:</label>
                            <input class="form-control" type="date" name="txtDate" required>
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Create Discount" name="btAction" class="btn btn-dark btn-block display-3"/>
                        </div>
                        <c:if test="${not empty requestScope.createMsg}">
                            <div class="alert alert-success">
                                <strong>Success!</strong> ${requestScope.createMsg}
                            </div>
                        </c:if>
                        <c:if test="${not empty requestScope.CREATEERROR}">
                            <div class="alert alert-danger">
                                <strong>Fail!</strong> ${requestScope.CREATEERROR}
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
