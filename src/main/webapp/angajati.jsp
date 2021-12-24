<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/19/2021
  Time: 12:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Angajati</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/tesla_icon.png">
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/assets/style/styles.css" rel="stylesheet" type="text/css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/searchTable.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/assets/js/exportToExcel.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.6/jspdf.plugin.autotable.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/exportToPDF.js" type="text/javascript"></script>
</head>
<body>
<div id="prod">
    <form method="post" action="${pageContext.request.contextPath}/angajati" autocomplete="off">
        <input name="numea" type="text" placeholder="Nume">
        <input name="prenumea" type="text" placeholder="Prenume">
        <input name="cnp" type="text" placeholder="CNP">
        <input name="adresaa" type="text" placeholder="Adresa">
        <input name="telefona" type="text" placeholder="Nr. de telefon">
        <input name="emaila" type="text" placeholder="Email">
        <input name="localitate" type="text" placeholder="Localitate">
        <input name="judet" type="text" placeholder="Judet">
        <input name="tara" type="text" placeholder="Tara">
        <select id="combo" name="functii">

        </select>
        <div class="link">
            <a class="edit" onclick="exportToExcel('table', 'Angajati')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
            <a class="edit" onclick="exportToPDF('#table', 'Angajati')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
        </div>
        <input name="adauga" type="submit" value="Adauga">
    </form>
    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<%
    try
    {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select * from angajat;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next())
            System.out.println("No Records in the table");
        else
        {%>

<table id="table">
    <thead>
    <tr>
        <th>Cod angajat</th>
        <th>Nume</th>
        <th>Prenume</th>
        <th>CNP</th>
        <th>Adresa</th>
        <th>Telefon</th>
        <th>Email</th>
        <th>Localitate</th>
        <th>Judet</th>
        <th>Tara</th>
        <th>Functie</th>
    </tr>
    </thead>
    <tbody>
    <%
        while(rs.next())
        {%>

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
        <td><%= rs.getInt(11)%></td>

        <td class="link">
            <a id="edit" href="${pageContext.request.contextPath}/edit/editPiese.jsp?codp=<%= rs.getString(1)%>">Editeaza</a>
            <a id="delete" href="${pageContext.request.contextPath}/piese?action=delete&codp=<%= rs.getString(1)%>" methods="">Sterge</a>
        </td>
    </tr>

    <%}
    }

    }
    catch(Exception e)
    {
        System.out.println(e.getMessage());
        e.getStackTrace();
    }
    %>
    </tbody>
</table>

</body>
</html>
