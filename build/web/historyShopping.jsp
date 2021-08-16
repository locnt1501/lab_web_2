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
        <title>History Page</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
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
                                    <c:if test="${user.roleId != 1}">
                                        <li><a class="dropdown-item" href="viewCart.jsp">View Your Card</a></li>
                                        <li><a class="dropdown-item" href="historyShopping.jsp">History</a></li>
                                        </c:if>
                                        <c:url var="logout" value="DispatcherController">
                                            <c:param name="btAction" value="Logout" />
                                        </c:url>
                                    <li><a class="dropdown-item" href="${logout}">Log Out</a></li>
                                </ul>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <div>
                    <c:set var="user" value="${sessionScope.USER}"/>
                    <c:if test="${empty user}">
                        <li class="nav-item">
                            <a class="nav-link active" href="login.jsp">Login</a>
                        </li>
                        <c:redirect url="login.jsp"/>
                    </c:if>
                    <c:if test="${user.roleId != 2}">
                        <c:redirect url="errors.html"/>
                    </c:if>
                </div>
            </nav>
        </div>
        <div class="container">
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
        </div> 
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>
