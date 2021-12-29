<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/29/2021
  Time: 8:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="../head.html"%>
<html>
<head>
    <title>Edit</title>
    <script src="${pageContext.request.contextPath}/assets/js/getVanzare.js" type="text/javascript"></script>
</head>
<body>
<%
    int codLog;
    try {
        UtilizatoriDAO utilizatoriDAO = new UtilizatoriDAO();
        Object userSession = session.getAttribute("user");
        if (userSession != null) {
            codLog = utilizatoriDAO.getCodf(userSession);
            if (!utilizatoriDAO.isAllowed(codLog, new int[]{4, 6, 7, 1}) && request.getParameter("cods") != null)
                response.sendRedirect("../index.jsp");
        } else
            response.sendRedirect("../index.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<form id="prod" method="post" action="${pageContext.request.contextPath}/service" autocomplete="off">
    <p>Cod service: ${param.cods}</p>

    <%
        try {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select * from service where cods = ?;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, request.getParameter("cods"));
            ResultSet rs = stmt.executeQuery();
            if (!rs.next())
                System.out.println("No Records in the table");
            else {
    %>

    <input name="cods" type="hidden" value="${param.cods}">

    <% try {
        PreparedStatement preparedStatement2 = connection.prepareStatement("select numec from client;");
        ResultSet resultSet2 = preparedStatement2.executeQuery();
        if(!resultSet2.next())
            System.out.println("No Records in the table");
        else { %>
    <select id="combonumec" name="conbon">
        <% do {%>
        <option value="<%= resultSet2.getString(1)%>"><%= resultSet2.getString(1)%></option>
        <%} while(resultSet2.next());
        }
        }
        catch(Exception e) {
            System.out.println(e.getMessage());
            e.getStackTrace();
        } %>
    </select>

    <script type='text/javascript'>
        $('#combonumec').val('<%=rs.getString(3) %>');
    </script>

    <% try {
        PreparedStatement preparedStatement3 = connection.prepareStatement("select prenumec from client WHERE numec = ?;");
        preparedStatement3.setString(1, rs.getString(3));
        ResultSet resultSet3 = preparedStatement3.executeQuery();
        if(!resultSet3.next())
            System.out.println("No Records in the table");
        else { %>
    <select id="comboprenumec" name="conbop">
        <% do {%>
        <option value="<%= resultSet3.getString(1)%>"><%= resultSet3.getString(1)%></option>
        <%} while(resultSet3.next());
        }
        }
        catch(Exception e) {
            System.out.println(e.getMessage());
            e.getStackTrace();
        } %>
    </select>

    <script type='text/javascript'>
        $('#comboprenumec').val('<%=rs.getString(4) %>');
    </script>

    <input id="vin" name="vin" type="text" placeholder="VIN" value="<%=rs.getString(5)%>">

    <select id="combocodp" name="codp">
        <%
            PreparedStatement preparedStatement = connection.prepareStatement("select codp from piese;");
            ResultSet resultSet = preparedStatement.executeQuery();
            if (!resultSet.next())
                System.out.println("No Records in the table");
            else {
                do {
        %>
        <option value="<%=resultSet.getString(1)%>"><%=resultSet.getString(1)%></option>
        <%
                } while (resultSet.next());
            }
        %>
    </select>

    <script type="text/javascript">
        $('#combocodp').val('<%= rs.getString(7)%>');
    </script>

    <input id="produs" name="prod" type="text" placeholder="Produs" value="<%=rs.getString(8)%>" readonly>

    <select id="status" name="status">
        <option>In asteptare</option>
        <option>In reparatie</option>
        <option>Finalizata</option>
        <option>Ridicata</option>
    </select>
    <script type="text/javascript">
        $("#status").val('<%=rs.getString(10)%>')
    </script>

    <% if (Objects.equals(rs.getString(11), "1")) {%>
    <input name="garantie" id="garantie" type="checkbox" value="Garantie" checked>
    <%} else {%>
    <input name="garantie" id="garantie" type="checkbox" value="Garantie">
    <% } %>

    <%}
    } catch (Exception e) {
        System.out.println(e.getMessage());
        e.getStackTrace();
    }
    %>


    <input name="action" value="edit" type="hidden">
    <input name="act" type="submit" value="Actualizeaza">
</form>

</body>
</html>
