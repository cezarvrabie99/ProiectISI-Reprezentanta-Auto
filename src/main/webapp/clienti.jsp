<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 12:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="head.html"%>
<html>
<head>
    <title>Clienti</title>
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
    <form method="post" action="${pageContext.request.contextPath}/clienti" autocomplete="off">
        <label>Logat cu <%=session.getAttribute("user")%></label>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <input name="numec" type="text" placeholder="Nume">
        <input name="prenumec" type="text" placeholder="Prenume">
        <input name="cnp" type="text" placeholder="CNP">
        <input name="adresac" type="text" placeholder="Adresa">
        <input name="telefonc" type="text" placeholder="Nr. de telefon">
        <input name="emailc" type="text" placeholder="Email">
        <input name="localitate" type="text" placeholder="Localitate">
        <input name="judet" type="text" placeholder="Judet">
        <input name="tara" type="text" placeholder="Tara">

        <div class="link">
            <a class="edit" onclick="exportToExcel('table', 'Clienti')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
            <a class="edit" onclick="exportToPDF('#table', 'Clienti')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
        </div>
        <input name="adauga" type="submit" value="Adauga">
    </form>
    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<% try {
    Connection connection = SqlConnection.getInstance().getConnection();
    String sql = "select * from client;";
    PreparedStatement stmt = connection.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();
    if(!rs.next())
        System.out.println("No Records in the table");
    else {%>

<table id="table">
    <thead>
    <tr>
        <th>Cod client</th>
        <th>Nume</th>
        <th>Prenume</th>
        <th>CNP</th>
        <th>Adresa</th>
        <th>Telefon</th>
        <th>Email</th>
        <th>Localitate</th>
        <th>Judet</th>
        <th>Tara</th>
    </tr>
    </thead>
    <tbody>
    <% do {%>

    <tr>
        <td><%= rs.getInt(1)%></td>
        <td><%= rs.getString(2)%></td>
        <td><%= rs.getString(3)%></td>
        <td><%= rs.getLong(4)%></td>
        <td><%= rs.getString(5)%></td>
        <td><%= rs.getString(6)%></td>
        <td><%= rs.getString(7)%></td>
        <td><%= rs.getString(8)%></td>
        <td><%= rs.getString(9)%></td>
        <td><%= rs.getString(10)%></td>

        <td class="link">
            <a id="edit" href="${pageContext.request.contextPath}/edit/editClienti.jsp?codc=<%= rs.getString(1)%>">Editeaza</a>
            <a id="delete" href="${pageContext.request.contextPath}/clienti?action=delete&codc=<%= rs.getString(1)%>" methods="">Sterge</a>
        </td>
    </tr>

    <%} while(rs.next());
    }
    }
    catch(Exception e) {
        System.out.println(e.getMessage());
        e.getStackTrace();
    } %>
    <tr class='notFound' hidden>
        <td colspan='10'>Nu s-au gasit inregistrari!</td>
    </tr>
    </tbody>
</table>

</body>
</html>
