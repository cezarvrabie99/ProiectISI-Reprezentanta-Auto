<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 12:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="head.html"%>

<html>
<head>
    <title>Utilizatori</title>
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
    <form method="post" action="${pageContext.request.contextPath}/utilizatori" autocomplete="off">
        <label>Logat cu <%=session.getAttribute("user")%></label>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <input name="username" type="text" placeholder="Denumire">
        <input name="password" id="pass" type="password" placeholder="Parola">
        <input type="checkbox" id="check" onmousedown="myFunction()" onmouseup="myFunction()">
        <input name="password2" type="password" placeholder="Confirmati">
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
        <select id="comboFuncii" name="functii">

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

        <script>
            function myFunction() {
                let pw_ele = document.getElementById("pass");
                if (pw_ele.type === "password") {
                    pw_ele.type = "text";
                } else {
                    pw_ele.type = "password";
                }
            }
        </script>

        <input name="adauga" type="submit" value="Adauga">
    </form>

    <hr>

    <div class="link">
        <a class="edit" onclick="exportToExcel('table', 'Utilizatori')"><img src="${pageContext.request.contextPath}/assets/img/excel.png" alt="Export Excel" title="Export Excel"></a>
        <a class="edit" onclick="exportToPDF('#table', 'Utilizatori')"><img src="${pageContext.request.contextPath}/assets/img/pdf.png" alt="Export PDF" title="Export PDF"></a>
    </div>

    <hr>

    <input type='text' id='searchTable' placeholder='Cautare'>
</div>

<%
    try
    {
        Connection connection = SqlConnection.getInstance().getConnection();
        String sql = "select * from utilizatori;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next())
            System.out.println("No Records in the table");
        else
        {%>

<table id="table">
    <thead>
    <tr>
        <th>Cod utilizator</th>
        <th>Username</th>
        <th>Parola</th>
        <th>Functie</th>
    </tr>
    </thead>
    <tbody>
    <%do {%>

    <tr>
        <td><%= rs.getInt(1)%></td>
        <td><%= rs.getString(2)%></td>
        <td><%= rs.getString(3)%></td>
        <td><%= rs.getInt(4)%></td>

        <td class="link">
            <a id="edit" href="${pageContext.request.contextPath}/edit/editUtilizatori.jsp?userid=<%= rs.getString(1)%>">Editeaza</a>
            <a id="delete" href="${pageContext.request.contextPath}/utilizatori?action=delete&userid=<%= rs.getString(1)%>" methods="">Sterge</a>
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
