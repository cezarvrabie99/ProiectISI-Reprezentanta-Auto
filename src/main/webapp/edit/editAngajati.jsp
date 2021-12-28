        <%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
        <%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/27/2021
  Time: 11:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../headMin.html"%>
<html>
<head>
    <title>Edit</title>
</head>
<body>
<%
    if (!Objects.equals(session.getAttribute("user"), "manager") ||
            request.getParameter("coda") == null) {
        response.sendRedirect("../index.jsp");
    }
%>
<form id="prod" method="post" action="${pageContext.request.contextPath}/angajati" autocomplete="off">
    <p>Cod angajat: ${param.coda}</p>
    <%
        int codf = 0;
        try {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select * from angajat where coda = ?;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, request.getParameter("coda"));
            ResultSet rs = stmt.executeQuery();
            if (!rs.next())
                System.out.println("No Records in the table");
            else {
                codf = rs.getInt(11);
    %>
    <input name="coda" type="hidden" value="${param.coda}">
    <input name="numea" type="text" placeholder="Nume" value="<%=rs.getString(2)%>">
    <input name="prenumea" type="text" placeholder="Prenume" value="<%=rs.getString(3)%>">
    <input name="cnp" type="text" placeholder="CNP" value="<%=rs.getString(4)%>">
    <input name="adresaa" type="text" placeholder="Adresa" value="<%=rs.getString(5)%>">
    <input name="telefona" type="text" placeholder="Nr. de telefon" value="<%=rs.getString(6)%>">
    <input name="emaila" type="text" placeholder="Email" value="<%=rs.getString(7)%>">
    <input name="localitate" type="text" placeholder="Localitate" value="<%=rs.getString(8)%>">
    <input name="judet" type="text" placeholder="Judet" value="<%=rs.getString(9)%>">
    <input name="tara" type="text" placeholder="Tara" value="<%=rs.getString(10)%>">
    <%}

    } catch (Exception e) {
        System.out.println(e.getMessage());
        e.getStackTrace();
    }
    %>

    <%
        try {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select codf, denf from functie;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next())
                System.out.println("No Records in the table");
            else {%>
    <select id="combo" name="functii">

        <% do {%>
        <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
        <%
                    } while (rs.next());
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
                e.getStackTrace();
            } %>
    </select>
    <script type='text/javascript'>
        document.getElementById("combo").value = <%=codf%>;
    </script>
    <input name="action" value="edit" type="hidden">
    <input name="act" type="submit" value="Actualizeaza">
</form>
</body>
</html>