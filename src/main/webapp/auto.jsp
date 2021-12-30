<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 1:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="head.html"%>
<html>
<head>
    <title>Autoturisme</title>
    <script src="${pageContext.request.contextPath}/assets/js/getAuto.js" type="text/javascript"></script>
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
    <form id="form" method="post" action="${pageContext.request.contextPath}/auto" onsubmit="return validate('auto')" autocomplete="off">
        <label>Logat cu <%=session.getAttribute("user")%></label>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>

        <div class="input">
            <input name="vin" type="text" placeholder="VIN">
            <label id="vin1" class="dnone">✓</label>
            <label id="vin0" class="dnone">✖</label>
        </div>

        <select name="model" id="model">
            <option>Model S</option>
            <option>Model 3</option>
            <option>Model X</option>
            <option>Model Y</option>
        </select>
        <select name="versiune" id="versiune">
            <option>Long Range</option>
            <option>Plaid</option>
        </select>
        <select name="culoare" id="culoare">
            <option>Alb</option>
            <option>Negru</option>
            <option>Gri</option>
            <option>Albastru</option>
            <option>Rosu</option>
        </select>
        <select name="jante" id="jante">
            <option>19'' Silver</option>
            <option>21'' Carbon</option>
        </select>
        <select name="interior" id="interior">
            <option>Negru</option>
            <option>Alb</option>
            <option>Crem</option>
        </select>

        <input name="autopilot" id="autopilot" type="checkbox" value="Autopilot">
        <label for="autopilot">Autopilot</label>

        <div class="input">
            <input name="data_fab" id="data_fab" type="date">
            <label id="data_fab1" class="dnone">✓</label>
            <label id="data_fab0" class="dnone">✖</label>
        </div>

        <script type="text/javascript">
            $(function() {
                $(document).ready(function () {
                    let todaysDate = new Date();
                    let year = todaysDate.getFullYear();
                    let month = ("0" + (todaysDate.getMonth() + 1)).slice(-2);
                    let day = ("0" + todaysDate.getDate()).slice(-2);
                    let maxDate = (year +"-"+ month +"-"+ day);
                    $('#data_fab').attr('max',maxDate);
                });
            });
        </script>
        <input name="nr_usi" id="nr_usi" type="number" placeholder="Nr. usi" value="5" readonly style="cursor: not-allowed">
        <input name="tractiune" id="tractiune" type="text" placeholder="Tractiune" value="Integrala" readonly style="cursor: not-allowed">
        <input name="baterie" id="baterie" type="number" placeholder="Bateriei" value="100" readonly style="cursor: not-allowed">

        <div class="input">
            <input name="preta" id="preta" type="number" placeholder="Pret(fara TVA)" onkeyup="addVat()">
            <label id="preta1" class="dnone">✓</label>
            <label id="preta0" class="dnone">✖</label>
        </div>

        <div class="input">
            <input name="pretatva" id="pretatva" type="text" placeholder="Pret(cu TVA)" readonly>
            <label id="pretatva1" class="dnone">✓</label>
            <label id="pretatva0" class="dnone">✖</label>
        </div>

        <script type='text/javascript'>
            function addVat() {
                let pret = document.getElementById("preta").value;
                if (pret === ""){
                    document.getElementById("pretatva").value = "";
                } else {
                    document.getElementById("pretatva").value = eval(pret) + 0.19 * eval(pret);
                }
            }
        </script>
        <div class="input">
            <input name="stoc" type="number" min="0" placeholder="Stoc">
            <label id="stoc1" class="dnone">✓</label>
            <label id="stoc0" class="dnone">✖</label>
        </div>

        <input name="adauga" type="submit" value="Adauga">
    </form>

    <% if (codLog != 6) {%>
    <hr>
    <div class="link">
        <a class="edit" onclick="exportToExcel('table', 'Autoturisme')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
        <a class="edit" onclick="exportToPDF('#table', 'Autoturisme')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
    </div>
    <% } %>
    <hr>

    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<% try {
    Connection connection = SqlConnection.getInstance().getConnection();
    String sql = "select * from autoturism;";
    PreparedStatement stmt = connection.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();
    if(!rs.next())
        System.out.println("No Records in the table");
    else {%>

<table id="table">
    <thead>
    <tr>
        <th>VIN</th>
        <th>Model</th>
        <th>Versiune</th>
        <th>Culoare</th>
        <th>Jante</th>
        <th>Interior</th>
        <th>Autopilot</th>
        <th>Data fab</th>
        <th>Nr usi</th>
        <th>Tractiune</th>
        <th>Baterie</th>
        <th>Pret</th>
        <th>Pret(cu TVA)</th>
        <th>Stoc</th>
    </tr>
    </thead>
    <tbody>
    <% do {%>

    <tr>
        <td><%= rs.getString(1)%></td>
        <td><%= rs.getString(2)%></td>
        <td><%= rs.getString(3)%></td>
        <td><%= rs.getString(4)%></td>
        <td><%= rs.getString(5)%></td>
        <td><%= rs.getString(6)%></td>
        <td><%= rs.getBoolean(7) ? "Da": "Nu"%></td>
        <td><%= rs.getString(8)%></td>
        <td><%= rs.getInt(9)%></td>
        <td><%= rs.getString(10)%></td>
        <td><%= rs.getInt(11)%></td>
        <td><%= rs.getInt(12)%></td>
        <td><%= rs.getInt(13)%></td>
        <td><%= rs.getInt(14)%></td>

        <% if (codLog != 7) {%>
            <td class="link">
                <a id="edit" href="${pageContext.request.contextPath}/edit/editAuto.jsp?vin=<%= rs.getString(1)%>">Editeaza</a>
                <a id="delete" href="${pageContext.request.contextPath}/auto?action=delete&vin=<%= rs.getString(1)%>" methods="">Sterge</a>
            </td>
        <% } %>
    </tr>

    <%} while(rs.next());
    }
    }
    catch(Exception e) {
        System.out.println(e.getMessage());
        e.getStackTrace();
    } %>
    <tr class='notFound' hidden>
        <td colspan='14'>Nu s-au gasit inregistrari!</td>
    </tr>
    </tbody>
</table>

</body>
</html>
