<%-- 
    Document   : review
    Created on : Aug 15, 2021, 4:21:51 PM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Review</title>
        <style type="text/css">
            table { border: 0; }
            table td { padding: 5px; }
        </style>
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
        <div align="center">
            <h1>Please Review Before Paying</h1>
            <form action="DispatcherController" method="post">
                <table>
                    <tr>
                        <td colspan="2"><b>Transaction Details:</b></td>
                        <td>
                            <input type="hidden" name="paymentId" value="${param.paymentId}" />
                            <input type="hidden" name="PayerID" value="${param.PayerID}" />
                        </td>
                    </tr>
                    <tr>
                        <td>Description:</td>
                        <td>${transaction.description}</td>
                    </tr>                   
                    <tr>
                        <td>Total:</td>
                        <td>${transaction.amount.total} USD</td>
                    </tr>
                    <tr><td><br/></td></tr>
                    <tr>
                        <td colspan="2"><b>Payer Information:</b></td>
                    </tr>
                    <tr>
                        <td>First Name:</td>
                        <td>${payer.firstName}</td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td>${payer.lastName}</td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td>${payer.email}</td>
                    </tr>
                    <tr><td><br/></td></tr>                  
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="Pay Now" name="btAction"/>
                        </td>
                    </tr>    
                </table>
            </form>
        </div>
    </body>
</html>
