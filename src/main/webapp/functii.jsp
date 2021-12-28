<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 11:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="head.html"%>
<html>
<head>
    <title>Functii</title>
</head>
<body>
<%
    if (!Objects.equals(session.getAttribute("user"), "manager")) {
        response.sendRedirect("index.jsp");
    }
%>

<div id="prod">
    <form method="post" action="${pageContext.request.contextPath}/functii" autocomplete="off">
        <label>Logat cu <%=session.getAttribute("user")%></label>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <input name="denf" type="text" placeholder="Denumire">
        <input name="salariubrut" id="salariubrut" type="number" placeholder="Salariul brut" onkeyup="updateSal()">
        <input name="salariunet" id="salariunet" type="text" placeholder="Salariul net" readonly>
        <script type='text/javascript'>
            function updateSal() {
                let brut = document.getElementById("salariubrut").value;
                let net1 = brut - 0.25 * brut - 0.1 * brut;
                document.getElementById("salariunet").value = net1 - 0.1 * net1;
            }
        </script>

        <input name="adauga" type="submit" value="Adauga">
    </form>

    <hr>

    <div class="link">
        <a class="edit" onclick="exportToExcel('table', 'Functii')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
        <a class="edit" onclick="exportToPDF('#table', 'Functii')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
    </div>

    <hr>

    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<%
    try
    {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select * from functie;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next())
            System.out.println("No Records in the table");
        else
        {%>

<table id="table">
    <thead>
    <tr>
        <th>Cod functie</th>
        <th>Denumire</th>
        <th>Salariul brut</th>
        <th>Salariul net</th>
    </tr>
    </thead>
    <tbody>
    <%do {%>

    <tr>
        <td><%= rs.getString(1)%></td>
        <td><%= rs.getString(2)%></td>
        <td><%= rs.getDouble(3)%></td>
        <td><%= rs.getDouble(4)%></td>

        <td class="link">
            <a id="edit" href="${pageContext.request.contextPath}/edit/editFunctii.jsp?codf=<%= rs.getString(1)%>">Editeaza</a>
            <a id="delete" href="${pageContext.request.contextPath}/functii?action=delete&codf=<%= rs.getString(1)%>" methods="">Sterge</a>
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
        <td colspan='4'>Nu s-au gasit inregistrari!</td>
    </tr>
    </tbody>
</table>

</body>
</html>
