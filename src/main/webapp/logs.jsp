<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 9:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="head.html"%>

<html>
<head>
    <title>Loguri</title>
</head>
<body>
<%
    String currentUser = (String) session.getAttribute("user");
    int codLog = -1;
    try {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select codf from utilizatori where username = ?;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, currentUser);
        ResultSet rs = stmt.executeQuery();

        if(!rs.next())
            System.out.println("No Records in the table");
        else
            codLog = rs.getInt(1);

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }

    if (codLog != 4)
        response.sendRedirect("index.jsp");
%>

<div id="nav-placeholder">

</div>

<script>
    $(function(){
        $("#nav-placeholder").load("assets/nav/manager.html");
    });
</script>

<div id="prod">
    <label>Logat cu <%=session.getAttribute("user")%></label>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
    <div class="link">
        <a class="edit" onclick="exportToExcel('table', 'Loguri')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
        <a class="edit" onclick="exportToPDF('#table', 'Loguri')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
    </div>

    <hr>

    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<%
    try
    {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select * from logs;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next())
            System.out.println("No Records in the table");
        else
        {%>

<table id="table">
    <thead>
    <tr>
        <th>Cod Log</th>
        <th>Username</th>
        <th>Actiune</th>
        <th>Comanda</th>
        <th>Data</th>
        <th>Ora</th>
        <th>Cod functie</th>
    </tr>
    </thead>
    <tbody>
    <%do {%>

    <tr>
        <td><%= rs.getInt(1)%></td>
        <td><%= rs.getString(2)%></td>
        <td><%= rs.getString(3)%></td>
        <td><%= rs.getString(4)%></td>
        <td><%= rs.getString(5)%></td>
        <td><%= rs.getString(6)%></td>
        <td><%= rs.getInt(7)%></td>

    </tr>

    <%} while(rs.next());
    }

    }
    catch(Exception e)
    {
        System.out.println(e.getMessage());
        e.getStackTrace();
    }
    %>
    <tr class='notFound' hidden>
        <td colspan='7'>Nu s-au gasit inregistrari!</td>
    </tr>
    </tbody>
</table>
</body>
</html>
