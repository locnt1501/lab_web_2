<%-- 
    Document   : error
    Created on : Aug 15, 2021, 4:47:46 PM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ERROR Page</title>
    </head>
    <body>
        <h1>Error</h1>
        <h3>${requestScope.errorMessage}</h3>
    </body>
</html>
