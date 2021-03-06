<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/23/2021
  Time: 11:52 PM
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
        if (userSession != null && request.getParameter("codp") != null) {
            codLog = utilizatoriDAO.getCodf(userSession);
            if (!utilizatoriDAO.isAllowed(codLog, new int[]{4, 6, 7, 1}))
                response.sendRedirect("index.jsp");
        } else
            response.sendRedirect("index.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<form id="prod" method="post" action="${pageContext.request.contextPath}/piese" autocomplete="off">
    <p>Cod piesa: ${param.codp}</p>
    <%
        try
        {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select * from piese where codp = ?;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, request.getParameter("codp"));
            ResultSet rs = stmt.executeQuery();
            if(!rs.next())
                System.out.println("No Records in the table");
            else
            {%>
    <input name="codp" type="hidden" value="${param.codp}">
    <input name="denp" type="text" placeholder="Denumire" value="<%= rs.getString(2)%>">
    <input name="pretp" id="pretp" type="number" placeholder="Pret(fara TVA)" value="<%= rs.getString(3)%>" onkeyup="addVat()">
    <input name="pretptva" id="pretptva" type="text" placeholder="Pret" value="<%= rs.getString(4)%>" readonly>
    <script type='text/javascript'>
        function addVat() {
            let pret = document.getElementById("pretp").value;
            if (pret === ""){
                document.getElementById("pretptva").value = "";
            } else {
                document.getElementById("pretptva").value = eval(pret) + 0.19 * eval(pret);
            }
        }
    </script>
    <input name="action" value="edit" type="hidden">
    <input name="act" type="submit" value="Actualizeaza">
    <%}

        }
        catch(Exception e)
        {
        System.out.println(e.getMessage());
        e.getStackTrace();
        }
    %>
</form>
</body>
</html>
