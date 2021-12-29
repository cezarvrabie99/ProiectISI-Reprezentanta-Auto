<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.example.proiectisi.model.AutoModel" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/29/2021
  Time: 6:48 PM
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
            if (!utilizatoriDAO.isAllowed(codLog, new int[]{4, 6, 7}) && request.getParameter("codv") != null)
                response.sendRedirect("../index.jsp");
        } else
            response.sendRedirect("../index.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<%!
    public String selectFrom(String sql) throws SQLException, ClassNotFoundException {
        PreparedStatement pst = SqlConnection.getInstance().getConnection().prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        System.out.println(sql);
        if(rs.next()) {
            System.out.println(rs.getString(1));
            return rs.getString(1);
        }

        return "-1";
    }
%>

<form id="prod" method="post" action="${pageContext.request.contextPath}/vanzare" autocomplete="off">
    <p>Cod vanzare: ${param.codv}</p>

    <%
        int codv = 0;
        String tipprod, codp, vin;
        try {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select * from vanzare where codv = ?;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, request.getParameter("codv"));
            ResultSet rs = stmt.executeQuery();
            if (!rs.next())
                System.out.println("No Records in the table");
            else {
                codv = rs.getInt(1);
                tipprod = rs.getString(2);
                codp = rs.getString(4);
                vin = rs.getString(5);
    %>

    <input name="codv" type="hidden" value="${param.codv}">

    <select id="comboTip" name="tipprod">
        <option>Piese</option>
        <option>Autoturisme</option>
    </select>
    <script type='text/javascript'>
        $('#comboTip').val("<%=tipprod %>");
    </script>



    <select id="combocodp" name="codp">
        <% String prodSQL;
            if (Objects.equals(tipprod, "Piese"))
                prodSQL = "select codp from piese;";
            else
                prodSQL = "select vin from autoturism where stoc > 0;";

            PreparedStatement preparedStatement = connection.prepareStatement(prodSQL);
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
        $('#combocodp').val('<%= Objects.equals(tipprod, "Piese") ? codp : vin%>');
    </script>

    <input id="produs" name="prod" type="text" placeholder="Produs" value="<%=rs.getString(3)%>" readonly>
    <input name="pret" id="pret" type="number" placeholder="Pret(fara TVA)" value="<%=rs.getString(6)%>" readonly>
    <input name="prettva" id="prettva" type="number" placeholder="Pret" value="<%=rs.getString(7)%>" readonly>

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
        $('#combonumec').val('<%=rs.getString(9) %>');
    </script>

    <% try {
        PreparedStatement preparedStatement3 = connection.prepareStatement("select prenumec from client WHERE numec = ?;");
        preparedStatement3.setString(1, rs.getString(9));
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
        $('#comboprenumec').val('<%=rs.getString(10) %>');
    </script>

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
