<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 12:09 PM
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
        if (userSession != null && request.getParameter("codf") != null) {
            codLog = utilizatoriDAO.getCodf(userSession);
            if (codLog != 4)
                response.sendRedirect("index.jsp");
        } else
            response.sendRedirect("index.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<form id="prod" method="post" action="${pageContext.request.contextPath}/functii" autocomplete="off">
    <p>Cod functie: ${param.codf}</p>
    <%
        try {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select * from functie where codf = ?;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, request.getParameter("codf"));
            ResultSet rs = stmt.executeQuery();
            if (!rs.next())
                System.out.println("No Records in the table");
            else {
    %>
    <input name="codf" type="hidden" value="${param.codf}">
    <input name="denf" type="text" placeholder="Functie" value="<%=rs.getString(2)%>">
    <input name="salariubrut" id="salariubrut" type="number" placeholder="Salariul brut" value="<%=rs.getString(3)%>" onkeyup="updateSal()">
    <input name="salariunet" id="salariunet" type="text" placeholder="Salariul net" value="<%=rs.getString(4)%>" readonly>
    <script type='text/javascript'>
        function updateSal() {
            let brut = document.getElementById("salariubrut").value;
            let net1 = brut - 0.25 * brut - 0.1 * brut;
            document.getElementById("salariunet").value = net1 - 0.1 * net1;
        }
    </script>
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
