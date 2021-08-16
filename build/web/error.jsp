<%-- 
    Document   : error
    Created on : Aug 15, 2021, 4:47:46 PM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ERROR Page</title>
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
            </nav>
        </div>
        <h1>Error</h1>
    </body>
</html>
