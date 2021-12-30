<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %><%--
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
    <script src="${pageContext.request.contextPath}/assets/js/getVanzare.js" type="text/javascript"></script>
</head>
<body>
<%
    int codLog = -1;
    try {
        UtilizatoriDAO utilizatoriDAO = new UtilizatoriDAO();
        Object userSession = session.getAttribute("user");
        if (userSession != null) {
            codLog = utilizatoriDAO.getCodf(userSession);
            if (!utilizatoriDAO.isAllowed(codLog, new int[]{4, 6, 7, 1}))
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
        const cod = <%=codLog %>;
        if (cod === 4)
            $("#nav-placeholder").load("assets/nav/manager.html");
        else if (cod === 6 || cod === 7)
            $("#nav-placeholder").load("assets/nav/consilier.html");
        else if (cod === 1)
            $("#nav-placeholder").load("assets/nav/mecanic.html");
    });
</script>

<div id="prod">
    <label>Logat cu <%=session.getAttribute("user")%></label>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
    <% if (codLog != 1) {%>
    <form id="form" method="post" action="${pageContext.request.contextPath}/service" onsubmit="return validate('service')" autocomplete="off">

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

        <div class="input">
            <select id="comboprenumec" name="conbop">
                <option>Selecteaza numele</option>
            </select>
            <label id="conbop1" class="dnone">✓</label>
            <label id="conbop0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input id="vin" name="vin" type="text" placeholder="VIN">
            <label id="vin1" class="dnone">✓</label>
            <label id="vin0" class="dnone">✖</label>
        </div>

        <% try {
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

        <div class="input">
            <input id="produs" name="prod" type="text" placeholder="Produs" value="Selecteaza Piesa" readonly>
            <label id="prod1" class="dnone">✓</label>
            <label id="prod0" class="dnone">✖</label>
        </div>

        <select id="status" name="status">
            <option>In asteptare</option>
            <option>In reparatie</option>
            <option>Finalizata</option>
            <option>Ridicata</option>
        </select>

        <input name="garantie" id="garantie" type="checkbox" value="Garantie">
        <label for="garantie">Garantie</label>

        <% if (codLog != 6 && codLog !=1) {%>
        <hr>
        <div class="link">
            <a class="edit" onclick="exportToExcel('table', 'Service')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
            <a class="edit" onclick="exportToPDF('#table', 'Service')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
        </div>
        <% } %>
        <hr>

        <input name="adauga" type="submit" value="Adauga">
    </form>
    <% } %>
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

        <% if (codLog != 7) {%>
        <td class="link">
            <a id="edit" href="${pageContext.request.contextPath}/edit/editService.jsp?cods=<%= rs.getString(1)%>">Editeaza</a>
            <% if (codLog != 1) {%>
                <a id="delete" href="${pageContext.request.contextPath}/service?action=delete&cods=<%= rs.getString(1)%>" methods="">Sterge</a>
            <% } %>
        </td>
        <% } %>
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
