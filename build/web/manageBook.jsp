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
                <a class="navbar-brand display-4" style="color: white" href="home.jsp">Book</a>
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
            </nav>
        </div> <!-- header.// -->

        <div> <!-- content.// -->
            <form action="DispatcherController" style="margin-top: 20px; margin-bottom: 20px">
                Search: <input type="text" name="txtSearchValue" value="${param.txtSearchValue}" />
                Status:
                <select name="ddList" >
                    <option value="new" ${param.ddList == 'new' ? 'selected="selected"' : '' }>New</option>
                    <option value="active" ${param.ddList == 'active' ? 'selected="selected"' : ''}>Active</option>
                    <option value="inactive" ${param.ddList == 'inactive' ? 'selected="selected"' : '' }>Delete</option>
                </select>
                <input type="submit" value="SearchBook" name="btAction" />
                <a href="createBook.jsp">Create Book</a>
                <a href="createDiscount.jsp">Create Discount</a>
            </form>
            <c:set var="listBook" value="${requestScope.LISTBOOKMANAGE}" />
            <c:set var="listCategory" value="${sessionScope.LISTCATEGORY}"/>
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
                                    <table border="1">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <form action="DispatcherController">
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <input type="hidden" name="txtBookId" value="${dto.bookId}" />
                                                            <input type="hidden" name="txtSearchValue" value="${param.txtSearchValue}"/>
                                                            <input type="hidden" name="ddList" value="${param.ddList}"/>
                                                            <input type="submit" value="Save" name="btAction" />
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
