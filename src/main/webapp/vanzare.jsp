<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/29/2021
  Time: 1:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="head.html"%>

<html>
<head>
    <title>Vanzare</title>
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
            if (!utilizatoriDAO.isAllowed(codLog, new int[]{4, 6, 7}))
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
    });
</script>

<div id="prod">
    <form method="post" action="${pageContext.request.contextPath}/vanzare" autocomplete="off">
        <label>Logat cu <%=session.getAttribute("user")%></label>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <select id="comboTip" name="tipprod">
            <option>Piese</option>
            <option>Autoturisme</option>
        </select>
        <% try {
                Connection connection = SqlConnection.getInstance().getConnection();
                String sql = "select codp from piese;";
                PreparedStatement stmt = connection.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                if(!rs.next())
                    System.out.println("No Records in the table");
                else { %>
        <select id="combocodp" name="codp">
            <% do {%>
            <option value="<%= rs.getString(1)%>"><%= rs.getString(1)%></option>
            <%} while(rs.next());
                }
                }
                catch(Exception e) {
                    System.out.println(e.getMessage());
                    e.getStackTrace();
                } %>
        </select>

        <input id="produs" name="prod" type="text" placeholder="Produs" value="" readonly>
        <input name="pret" id="pret" type="number" placeholder="Pret(fara TVA)" value="" readonly>
        <input name="prettva" id="prettva" type="number" placeholder="Pret" value="" readonly>

        <% try {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select numec from client;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if(!rs.next())
                System.out.println("No Records in the table");
            else { %>
        <select id="combonumec" name="conbon">
            <% do {%>
            <option value="<%= rs.getString(1)%>"><%= rs.getString(1)%></option>
            <%} while(rs.next());
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


        <input name="adauga" type="submit" value="Adauga">
    </form>

    <hr>

    <div class="link">
        <a class="edit" onclick="exportToExcel('table', 'Vanzare')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
        <a class="edit" onclick="exportToPDF('#table', 'Vanzare')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
    </div>

    <hr>

    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<%
    try
    {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select * from vanzare;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next())
            System.out.println("No Records in the table");
        else
        {%>

<table id="table">
    <thead>
    <tr>
        <th>Cod vanzare</th>
        <th>Tip Produs</th>
        <th>Produs</th>
        <th>Cod produs</th>
        <th>VIN</th>
        <th>Pret(fara TVA)</th>
        <th>Pret(cu TVA)</th>
        <th>Cod Client</th>
        <th>Nume</th>
        <th>Prenume</th>
        <th>Angajat</th>
        <th>Data</th>
        <th>Ora</th>
    </tr>
    </thead>
    <tbody>
    <%do {%>

    <tr>
        <td><%= rs.getInt(1)%></td>
        <td><%= rs.getString(2)%></td>
        <td><%= rs.getString(3)%></td>
        <td><%= rs.getString(4) == null ? "" : rs.getString(4)%></td>
        <td><%= rs.getString(5) == null ? "" : rs.getString(5)%></td>
        <td><%= rs.getString(6)%></td>
        <td><%= rs.getString(7)%></td>
        <td><%= rs.getInt(8)%></td>
        <td><%= rs.getString(9)%></td>
        <td><%= rs.getString(10)%></td>
        <td><%= rs.getString(11)%></td>
        <td><%= rs.getString(12)%></td>
        <td><%= rs.getString(13)%></td>

        <td class="link">
            <a id="edit" href="${pageContext.request.contextPath}/edit/editVanzare.jsp?codv=<%= rs.getString(1)%>">Editeaza</a>
            <a id="delete" href="${pageContext.request.contextPath}/vanzare?action=delete&codv=<%= rs.getString(1)%>" methods="">Sterge</a>
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
