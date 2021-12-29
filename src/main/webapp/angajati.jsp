<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/19/2021
  Time: 12:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="head.html"%>
<html>
<head>
    <title>Angajati</title>
</head>
<body>
<%
    int codLog;
    try {
        UtilizatoriDAO utilizatoriDAO = new UtilizatoriDAO();
        Object userSession = session.getAttribute("user");
        if (userSession != null) {
            codLog = utilizatoriDAO.getCodf(userSession);
            if (codLog != 4)
                response.sendRedirect("index.jsp");
        } else
            response.sendRedirect("index.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
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
    <form id="form" method="post" action="${pageContext.request.contextPath}/angajati" onsubmit="return validation()" autocomplete="off">
        <label>Logat cu <%=session.getAttribute("user")%></label>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <div class="input">
            <input name="numea" type="text" placeholder="Nume">
            <label id="numea1" class="dnone">✓</label>
            <label id="numea0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="prenumea" type="text" placeholder="Prenume">
            <label id="prenumea1" class="dnone">✓</label>
            <label id="prenumea0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="cnp" type="text" placeholder="CNP">
            <label id="cnp1" class="dnone">✓</label>
            <label id="cnp0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="adresaa" type="text" placeholder="Adresa">
            <label id="adresaa1" class="dnone">✓</label>
            <label id="adresaa0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="telefona" type="text" placeholder="Nr. de telefon">
            <label id="telefona1" class="dnone">✓</label>
            <label id="telefona0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="emaila" type="text" placeholder="Email">
            <label id="emaila1" class="dnone">✓</label>
            <label id="emaila0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="localitate" type="text" placeholder="Localitate">
            <label id="localitate1" class="dnone">✓</label>
            <label id="localitate0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="judet" type="text" placeholder="Judet">
            <label id="judet1" class="dnone">✓</label>
            <label id="judet0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="tara" type="text" placeholder="Tara">
            <label id="tara1" class="dnone">✓</label>
            <label id="tara0" class="dnone">✖</label>
        </div>

        <%
            try
            {
                Connection connection = SqlConnection.getInstance().getConnection();
                String sql = "select codf, denf from functie;";
                PreparedStatement stmt = connection.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                if(!rs.next())
                    System.out.println("No Records in the table");
                else {%>
        <select id="combo" name="functii">

            <% do {%>
                <option value="<%= rs.getInt(1)%>"><%= rs.getString(2)%></option>
            <%
                        } while(rs.next());
            }
            }
            catch(Exception e) {
                System.out.println(e.getMessage());
                e.getStackTrace();
            } %>
        </select>
        <div class="link">
            <a class="edit" onclick="exportToExcel('table', 'Angajati')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
            <a class="edit" onclick="exportToPDF('#table', 'Angajati')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
        </div>
        <input name="adauga" type="submit" value="Adauga">
    </form>
    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<% try {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select * from angajat;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
    if(!rs.next())
            System.out.println("No Records in the table");
        else {%>

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
        <td><%= rs.getInt(11)%></td>

        <td class="link">
            <a id="edit" href="${pageContext.request.contextPath}/edit/editAngajati.jsp?coda=<%= rs.getString(1)%>">Editeaza</a>
            <a id="delete" href="${pageContext.request.contextPath}/angajati?action=delete&coda=<%= rs.getString(1)%>" methods="">Sterge</a>
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
        <td colspan='11'>Nu s-au gasit inregistrari!</td>
    </tr>
    </tbody>
</table>

</body>
</html>
