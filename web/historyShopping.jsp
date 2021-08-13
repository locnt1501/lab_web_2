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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History Request Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
        <nav class="navbar navbar-expand-sm navbar-dark ">
            <h2 class="navbar-brand display-4" style="color: black"> Welcome ${sessionScope.USER.name}</h2>
            <div class="collapse navbar-collapse">
                <form action="DispatcherController">
                    <ul class="navbar-nav ml-auto">
                        <c:set var="user" value="${sessionScope.USER}"/>
                        <c:if test="${empty user}">
                            <li class="nav-item">
                                <a class="nav-link active" href="login.jsp">Login</a>
                            </li>
                            <c:redirect url="login.jsp"/>
                        </c:if>
                        <c:if test="${user.roleId == 1}">
                            <c:redirect url="errors.html"/>
                        </c:if>
                        <c:if test="${not empty user}">
                            <input type="submit" value="Logout" name="btAction" style="color: black" />
                        </c:if>
                    </ul>
                </form>
            </div>
        </nav>
        <a href="home.jsp">Back</a>
        <form action="DispatcherController">
            <div class="row">
                <div class="form-group col-6">
                    Date: <input class="form-control" placeholder="Date" type="date" name="txtDate" value="${param.txtDate}">
                </div>
            </div>
            <div class="form-group">
                <input type="submit" value="Search History" name="btAction" class="btn btn-dark btn-block display-3" />
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
                                        <c:forEach var="item" items="${dto.listItemName}">
                                            <tr>
                                                <td>${item}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </td>
                            <td>${dto.createDate}</td>
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
