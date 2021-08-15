<%-- 
    Document   : createBook
    Created on : Aug 12, 2021, 10:32:34 PM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Book Page</title>
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
        <c:set var="listCategory" value="${sessionScope.LISTCATEGORY}"/>
        <div class="container">
            <a href="manageBook.jsp">Back</a>
            <div class="card">
                <div class="card-body">
                    <h1 class="text text-center">Create Book</h1>
                    <form action="DispatcherController" method="POST" enctype="multipart/form-data">
                        <div class="row">
                            <div class="form-group col-6">
                                <label class="">Title</label>
                                <input class="form-control" placeholder="Title" type="text" name="txtTitle" required>
                            </div>
                            <div class="form-group col-6">
                                <label class="">Author</label>
                                <input class="form-control" placeholder="Author" type="text" name="txtAuthor" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-6">
                                <label class="">Price From(USD)</label>
                                <input class="form-control" placeholder="Price From (USD)" type="number" name="txtPrice" required>
                            </div>
                            <div class="form-group col-6">
                                <label class="">Quantity</label>
                                <input class="form-control" placeholder="Quantity" type="number" name="txtQuantity" required>
                            </div>
                        </div>
                        <div class="form-group col-12">
                            <label class="">Description</label>
                            <input class="form-control" placeholder="Description" type="text" name="txtDescription" required>
                        </div>
                        <div class="form-group">
                            <label class="">Category</label>
                            <select name="txtCategory" >
                                <c:forEach var="dto" items="${listCategory}">
                                    <option value="${dto.categoryId}" ${param.ddList eq dto.categoryId ? 'selected="selected"' : '' }>${dto.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="file" name="image" value="" accept="image/*"  required/>
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Create Book" name="btAction" class="btn btn-dark btn-block display-3"/>
                        </div>
                        <c:set var="succcess" value="${requestScope.CREATESUCCESS}" />
                        <c:if test="${not empty succcess}">
                            <div class="alert alert-success">
                                <strong>${succcess}!</strong> 
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
