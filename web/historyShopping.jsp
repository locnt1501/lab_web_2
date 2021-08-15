<%-- 
    Document   : historyShopping
    Created on : Aug 13, 2021, 8:06:21 AM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>History Shopping Page</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <link href="homeStyle.css" rel="stylesheet">
        <style>
            #history-booking {
                font-family: Arial, Helvetica, sans-serif;
                border-collapse: collapse;
                width: 100%;

            }

            #history-booking td, #history-booking th {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center
            }

            #history-booking tr:nth-child(even){background-color: #f2f2f2;}

            #history-booking tr:hover {background-color: #ddd;}

            #history-booking th {
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
        <form action="DispatcherController">
            <div class="row">
                <div class="form-group col-6">
                    Date: <input class="form-control" placeholder="Date" type="date" name="txtDate" value="${param.txtDate}">
                </div>
            </div>
            <div class="form-group col-6">
                <input type="submit" value="SearchHistory" name="btAction" class="btn btn-dark btn-block display-3" />
            </div> 
        </form>

        <c:set var="listBookingHistory" value="${requestScope.LISTBOOKINGHISTORY}" />
        <c:if test="${not empty listBookingHistory}">
            <table id="history-booking">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Item Name</th>
                        <th>Date Create</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${listBookingHistory}" varStatus="counter">
                        <tr>
                            <td>${counter.count}</td>
                            <td>
                                <table border="1" style="width: 100%">
                                    <tbody  >
                                        <c:forEach var="item" items="${dto.listBook}">
                                            <tr>
                                                <td>${item}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </td>
                            <td>${dto.bookingDate}</td>
                            <td>${dto.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty listBookingHistory}">
            <h4 class="alert alert-danger container">No Result</h4> 
        </c:if> 
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
    </body>
</html>
