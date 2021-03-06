<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 12:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="../headMin.html"%>
<html>
<head>
    <title>Edit</title>
</head>
<body>
<%
    int codLog;
    try {
        UtilizatoriDAO utilizatoriDAO = new UtilizatoriDAO();
        Object userSession = session.getAttribute("user");
        if (userSession != null && request.getParameter("codc") != null) {
            codLog = utilizatoriDAO.getCodf(userSession);
            if (!utilizatoriDAO.isAllowed(codLog, new int[]{4, 6, 7}))
                response.sendRedirect("index.jsp");
        } else
            response.sendRedirect("index.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<form id="prod" method="post" action="${pageContext.request.contextPath}/clienti" autocomplete="off">
    <p>Cod client: ${param.codc}</p>
    <%
        try {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select * from client where codc = ?;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, request.getParameter("codc"));
            ResultSet rs = stmt.executeQuery();
            if (!rs.next())
                System.out.println("No Records in the table");
            else {
    %>
    <input name="codc" type="hidden" value="${param.codc}">
    <input name="numec" type="text" placeholder="Nume" value="<%=rs.getString(2)%>">
    <input name="prenumec" type="text" placeholder="Prenume" value="<%=rs.getString(3)%>">
    <input name="cnp" type="text" placeholder="CNP" value="<%=rs.getString(4)%>">
    <input name="telefonc" type="text" placeholder="Nr. de telefon" value="<%=rs.getString(5)%>">
    <input name="emailc" type="text" placeholder="Email" value="<%=rs.getString(6)%>">
    <input name="adresac" type="text" placeholder="Adresa" value="<%=rs.getString(7)%>">
    <input name="localitate" type="text" placeholder="Localitate" value="<%=rs.getString(8)%>">
    <input name="judet" type="text" placeholder="Judet" value="<%=rs.getString(9)%>">
    <input name="tara" type="text" placeholder="Tara" value="<%=rs.getString(10)%>">
    <%}

    } catch (Exception e) {
        System.out.println(e.getMessage());
        e.getStackTrace();
    }
    %>
    <input name="action" value="edit" type="hidden">
    <input name="act" type="submit" value="Actualizeaza">
</form>
</body>
</html>
