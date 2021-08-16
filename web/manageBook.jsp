<%-- 
    Document   : manageBook
    Created on : Aug 12, 2021, 1:44:37 PM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Book Page</title>
        <meta charset="utf-8">
        <meta name="robots" content="noindex, nofollow">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="homeStyle.css" rel="stylesheet">
        <style>
            #search-table {
                font-family: Arial, Helvetica, sans-serif;
                border-collapse: collapse;
                width: 100%;

            }

            #search-table td, #search-table th {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center
            }

            #search-table tr:nth-child(even){background-color: #f2f2f2;}

            #search-table tr:hover {background-color: #ddd;}

            #search-table th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #04AA6D;
                color: white;
                text-align: center
            }
        </style>
    </head>
    <body>
        <div>
            <nav class="navbar navbar-expand-sm navbar-dark ">
                <c:url var="home" value="DispatcherController"/>
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
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" >
                                    ${user.name}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <c:url var="logout" value="DispatcherController">
                                        <c:param name="btAction" value="Logout" />
                                    </c:url>
                                    <li><a class="dropdown-item" href="${logout}">Log Out</a></li>
                                </ul>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <c:set var="user" value="${sessionScope.USER}"/>
                <c:if test="${empty user}">
                    <li class="nav-item">
                        <a class="nav-link active" href="login.jsp">Login</a>
                    </li>
                    <c:redirect url="login.jsp"/>
                </c:if>
                <c:if test="${user.roleId != 1}">
                    <c:redirect url="errors.html"/>
                </c:if>
            </nav>
        </div> <!-- header.// -->
        <c:set var="listCategory" value="${sessionScope.LISTCATEGORY}"/>
        <c:set var="listStatus" value="${requestScope.LISTSTATUS}"/>

        <div> <!-- content.// -->
            <c:set var="searchValue" value="${requestScope.searchValue}" />
            <c:set var="searchCategory" value="${requestScope.searchCategory}" />
            <form action="DispatcherController" style="margin-top: 20px; margin-bottom: 20px"> 
                <div class="row justify-content-center">
                    <div class="card " style="background-color: rgba(0,0,0,0.3);" >
                        <div class="card-body">
                            <div class="form-group">
                                <label class="text-light">Search:</label>
                                <input type="text" name="txtSearchValue" 
                                       <c:if test="${not empty param.txtSearchValue}">value="${param.txtSearchValue}"</c:if> 
                                       <c:if test="${not empty searchValue}">value="${searchValue}"</c:if> /><br/>
                                </div>
                                <div class="form-group">
                                    <label class="text-light">Category</label>
                                    <select name="ddList" >
                                    <c:forEach var="dtoCategory" items="${listCategory}">
                                        <option value="${dtoCategory.categoryId}" 
                                                <c:if test="${searchCategory eq dtoCategory.categoryId}">selected</c:if> 
                                                <c:if test="${param.ddList eq dtoCategory.categoryId}">selected</c:if>>
                                            ${dtoCategory.name}
                                        </option>
                                    </c:forEach>
                                </select> 
                                <input type="submit" value="SearchBook" name="btAction" />
                            </div>
                            <div class="form-group">
                                <a href="createBook.jsp">Create Book</a>
                                <a href="createDiscount.jsp">Create Discount</a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <c:set var="listBook" value="${requestScope.LISTBOOKMANAGE}" />
            <c:if test="${not empty listBook}">
                <table id="search-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Title</th>
                            <th>Price</th>
                            <th>Author</th>
                            <th>Category</th>
                            <th>Date Import</th>
                            <th>Quantity</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${listBook}" varStatus="counter">
                        <form action="DispatcherController">
                            <tr>
                                <td>${counter.count}</td>
                                <td>
                                    <input type="text" name="txtTitle" value="${dto.title}" />
                                </td>
                                <td>
                                    <input type="number" name="txtPrice" value="${dto.price}" />
                                </td>
                                <td>
                                    <input type="text" name="txtAuthor" value="${dto.author}" />
                                </td>
                                <td>
                                    <select name="ddListCate" >
                                        <c:forEach var="dtoCategory" items="${listCategory}">
                                            <option value="${dtoCategory.categoryId}" <c:if test="${dto.category.name eq dtoCategory.name}">selected</c:if>>
                                                ${dtoCategory.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <input class="form-control" type="date" name="txtDate" value="${dto.dateImport}">
                                </td>
                                <td>
                                    <input type="number" name="txtQuantity" value="${dto.quantity}" />
                                </td>
                                <td>
                                    <select name="ddListStatus" >
                                        <c:forEach var="dtoStatus" items="${listStatus}">
                                            <option value="${dtoStatus.statusId}" <c:if test="${dto.statusId eq dtoStatus.statusId}">selected</c:if>>
                                                ${dtoStatus.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <table border="1">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <form action="DispatcherController">
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <input type="hidden" name="txtBookId" value="${dto.bookId}" />
                                                            <input type="hidden" name="txtSearchValue"
                                                                   <c:if test="${not empty param.txtSearchValue}">value="${param.txtSearchValue}"</c:if> 
                                                                   <c:if test="${not empty searchValue}">value="${searchValue}"</c:if> />
                                                                   <input type="hidden" name="ddList" 
                                                                   <c:if test="${not empty param.txtSearchValue}">value="${param.ddList}"</c:if> 
                                                                   <c:if test="${not empty searchCategory}">value="${searchCategory}"</c:if> />
                                                                   <input type="submit" value="Save" name="btAction" onclick="return confirm('Are your sure?');"/>
                                                            </div>
                                                        </form>
                                                    </td>
                                                    <td>
                                                        <form action="DispatcherController">
                                                            <div class="d-flex justify-content-between align-items-center">
                                                                <input type="hidden" name="txtBookId" value="${dto.bookId}" />
                                                            <input type="hidden" name="txtSearchValue" value="${param.txtSearchValue}"/>
                                                            <input type="hidden" name="ddList" value="${param.ddList}"/>
                                                            <input type="submit" value="Delete" name="btAction" onclick="return confirm('Are your sure?');" />
                                                        </div>
                                                    </form>
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
            </c:if>
            <c:if test="${empty listBook}">
                <h4 class="alert alert-danger container">No Result</h4> 
            </c:if>
        </div>
    </body>
</html>
