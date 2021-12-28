<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/19/2021
  Time: 12:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="head.html"%>
<html>
<head>
    <title>Piese</title>
</head>
<body>
<%
if (!Objects.equals(session.getAttribute("user"), "manager")) {
    response.sendRedirect("index.jsp");
}
%>
<div id="prod">
<form method="post" action="${pageContext.request.contextPath}/piese" autocomplete="off">
    <label>Logat cu <%=session.getAttribute("user")%></label>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
    <input name="codp" type="text" placeholder="Cod piesa">
    <input name="denp" type="text" placeholder="Denumire">
    <input name="pretp" id="pretp" type="number" placeholder="Pret(fara TVA)" onkeyup="addVat()">
    <input name="pretptva" id="pretptva" type="text" placeholder="Pret(cu TVA)" readonly>
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
    <div class="link">
        <a class="edit" onclick="exportToExcel('table', 'Piese')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
        <a class="edit" onclick="exportToPDF('#table', 'Piese')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
    </div>
    <input name="adauga" type="submit" value="Adauga">
</form>
<input type='text' id='searchTable' placeholder='Cautare'>
</div>

<%
    try
    {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select * from piese;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next())
            System.out.println("No Records in the table");
        else
        {%>

<table id="table">
    <thead>
        <tr>
            <th>Cod piesa</th>
            <th>Denumire</th>
            <th>Pret(fara TVA)</th>
            <th>Pret(cu TVA)</th>
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
                <a id="edit" href="${pageContext.request.contextPath}/edit/editPiese.jsp?codp=<%= rs.getString(1)%>">Editeaza</a>
                <a id="delete" href="${pageContext.request.contextPath}/piese?action=delete&codp=<%= rs.getString(1)%>" methods="">Sterge</a>
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
