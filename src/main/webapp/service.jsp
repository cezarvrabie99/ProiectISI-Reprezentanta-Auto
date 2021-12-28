<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 5:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="head.html"%>
<html>
<head>
    <title>Service</title>
</head>
<body>
<%
    if (!Objects.equals(session.getAttribute("user"), "manager")) {
        response.sendRedirect("index.jsp");
    }
%>

<div id="nav-placeholder">

</div>

<script>
    $(function(){
        $("#nav-placeholder").load("assets/nav/manager.html");
    });
</script>

<div id="prod">
    <form method="post" action="${pageContext.request.contextPath}/service" autocomplete="off">
        <label>Logat cu <%=session.getAttribute("user")%></label>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>

        <%
            try
            {
                Connection connection = SqlConnection.getInstance().getConnection();
                String sql = "select numec from client;";
                PreparedStatement stmt = connection.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                if(!rs.next())
                    System.out.println("No Records in the table");
                else {%>
        <select id="combonumec" name="conbon">
            <% do {%>
            <option><%= rs.getString(1)%></option>
            <%
                        } while(rs.next());
                    }
                }
                catch(Exception e) {
                    System.out.println(e.getMessage());
                    e.getStackTrace();
                } %>
        </select>

        <select id="comboprenumec" name="conbop">
            <option>Selecteaza numele</option>
        </select>
        <input id="vin" name="vin" type="text" placeholder="VIN">

        <%
            try
            {
                Connection connection = SqlConnection.getInstance().getConnection();
                String sql = "select codp from piese;";
                PreparedStatement stmt = connection.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                if(!rs.next())
                    System.out.println("No Records in the table");
                else {%>
        <select id="combocodp" name="codp">
            <% do {%>
            <option><%= rs.getString(1)%></option>
            <%
                        } while(rs.next());
                    }
                }
                catch(Exception e) {
                    System.out.println(e.getMessage());
                    e.getStackTrace();
                } %>
        </select>

        <input id="produs" name="prod" type="text" placeholder="Produs" value="<?php echo selectFrom('select denp from piese;', 1)?>" readonly>
        <select id="status" name="status">
            <option>In asteptare</option>
            <option>In reparatie</option>
            <option>Finalizata</option>
            <option>Ridicata</option>
        </select>
        <input name="garantie" id="garantie" type="checkbox" value="Garantie">
        <label for="garantie">Garantie</label>

        <div class="link">
            <a class="edit" onclick="exportToExcel('table', 'Service')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
            <a class="edit" onclick="exportToPDF('#table', 'Service')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
        </div>

        <input name="adauga" type="submit" value="Adauga">
    </form>
    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<%
    try
    {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select * from service;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next())
            System.out.println("No Records in the table");
        else
        {%>

<table id="table">
    <thead>
    <tr>
        <th>Cod service</th>
        <th>Cod client</th>
        <th>Nume</th>
        <th>Prenume</th>
        <th>VIN</th>
        <th>Model</th>
        <th>Cod piesa</th>
        <th>Piesa</th>
        <th>Angajat</th>
        <th>Stare</th>
        <th>Garantie</th>
        <th>Data</th>
        <th>Ora</th>
    </tr>
    </thead>
    <tbody>
    <%do {%>

    <tr>
        <td><%= rs.getInt(1)%></td>
        <td><%= rs.getInt(2)%></td>
        <td><%= rs.getString(3)%></td>
        <td><%= rs.getString(4)%></td>
        <td><%= rs.getString(5)%></td>
        <td><%= rs.getString(6)%></td>
        <td><%= rs.getString(7)%></td>
        <td><%= rs.getString(8)%></td>
        <td><%= rs.getString(9)%></td>
        <td><%= rs.getString(10)%></td>
        <td><%= rs.getBoolean(11) ? "Da" : "Nu"%></td>
        <td><%= rs.getString(12)%></td>
        <td><%= rs.getString(13)%></td>

        <td class="link">
            <a id="edit" href="${pageContext.request.contextPath}/edit/editService.jsp?cods=<%= rs.getString(1)%>">Editeaza</a>
            <a id="delete" href="${pageContext.request.contextPath}/service?action=delete&cods=<%= rs.getString(1)%>" methods="">Sterge</a>
        </td>
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
        <td colspan='13'>Nu s-au gasit inregistrari!</td>
    </tr>
    </tbody>
</table>

</body>
</html>
