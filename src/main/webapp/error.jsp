<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/29/2021
  Time: 12:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="head.html"%>
<html>
<head>
    <title>Error</title>
</head>
<body>
<%
    int codLog;
    try {
        UtilizatoriDAO utilizatoriDAO = new UtilizatoriDAO();
        Object userSession = session.getAttribute("user");
        if (userSession != null) {
            codLog = utilizatoriDAO.getCodf(userSession);
            if (!utilizatoriDAO.isAllowed(codLog, new int[]{4, 6, 7, 1}))
                response.sendRedirect("index.jsp");
        } else
            response.sendRedirect("index.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<form id="main">
    <div class = "login">
        <img src="${pageContext.request.contextPath}/assets/img/err.png" alt="tesla logo" width="200" height="200">
        <h1 id="title">Utilizator neconfigurat!</h1>
        <a href="${pageContext.request.contextPath}/index.jsp">Inapoi la Log In</a>
    </div>
</form>
</body>
</html>
