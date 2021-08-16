<%-- 
    Document   : login
    Created on : Aug 12, 2021, 9:50:20 AM
    Author     : LocPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body {font-family: Arial, Helvetica, sans-serif;}
            form {border: 3px solid #f1f1f1;}

            input[type=text], input[type=password] {
                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }

            .button {
                background-color: #04AA6D;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                cursor: pointer;
                width: 100%;
            }

            .button:hover {
                opacity: 0.8;
            }

            .cancelbtn {
                width: auto;
                padding: 10px 18px;
                background-color: #f44336;
            }

            .imgcontainer {
                text-align: center;
                margin: 24px 0 12px 0;
            }

            .container {
                padding: 16px;
            }

            span.psw {
                float: right;
                padding-top: 16px;
            }

            /* Change styles for span and cancel button on extra small screens */
            @media screen and (max-width: 300px) {
                span.psw {
                    display: block;
                    float: none;
                }
                .cancelbtn {
                    width: 100%;
                }
            }
        </style>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <script src="https://www.google.com/recaptcha/api.js"></script>
        <title>Login Page</title>
    </head>
    <body>
        <h2>Login Form</h2>
        <form action="DispatcherController" method="post" style="width: 25%">
            <div class="container">
                <c:set var="errors" value="${requestScope.USERERROR}" />
                <label for="txtEmail"><b>Username</b></label>
                <input type="text" placeholder="Enter Username" name="txtUsername" required >

                <label for="txtPassword"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="txtPassword" required>
                
                <c:if test="${not empty errors}">
                    <font color="red">
                    ${errors}
                    </font>
                </c:if></br>

                <input type="submit" value="Login" name="btAction" id="button"/>
                <br/>
            </div>
        </form>

    </body>
</html>
