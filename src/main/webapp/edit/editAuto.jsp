<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.proiectisi.SqlConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.example.proiectisi.dao.UtilizatoriDAO" %><%--
  Created by IntelliJ IDEA.
  User: cezar
  Date: 12/28/2021
  Time: 3:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="../headMin.html"%>
<html>
<head>
    <title>Edit</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%
    int codLog;
    try {
        UtilizatoriDAO utilizatoriDAO = new UtilizatoriDAO();
        Object userSession = session.getAttribute("user");
        if (userSession != null && request.getParameter("vin") != null) {
            codLog = utilizatoriDAO.getCodf(userSession);
            if (!utilizatoriDAO.isAllowed(codLog, new int[]{4, 6, 7}))
                response.sendRedirect("index.jsp");
        } else
            response.sendRedirect("index.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<form id="prod" method="post" action="${pageContext.request.contextPath}/auto" autocomplete="off">
    <p>VIN: ${param.vin}</p>
    <%
        String[] models = {"Model S", "Model 3", "Model X", "Model Y"};
        String[] versionSX = {"Long Range", "Plaid"};
        String[] version3 = {"Standard Range Plus", "Long Range", "Performance"};
        String[] versionY = {"Long Range", "Performance"};
        String[] colors = {"Alb", "Negru", "Argintiu", "Albastru", "Rosu"};
        String[] wheelsS = {"19'' Silver", "21'' Carbon"};
        String[] wheels3 = {"18'' Aero", "19'' Sport"};
        String[] wheelsX = {"20'' Silver", "22'' Black"};
        String[] wheelsY = {"19'' Silver", "20'' Black"};
        String[] interiorSX = {"Negru", "Alb", "Crem"};
        String[] interior3Y = {"Negru", "Alb"};

        String[] tempVersion, tempWheels, tempInterior;

        String model, versiune, culoare, jante, interior, autopilot, data_fab, nr_usi, tractiune, baterie,
                preta, pretatva, stoc;
        try {
            Connection connection = SqlConnection.getInstance().getConnection();
            String sql = "select * from autoturism where vin = ?;";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, request.getParameter("vin"));
            ResultSet rs = stmt.executeQuery();
            if (!rs.next())
                System.out.println("No Records in the table");
            else {
                model = rs.getString(2);
                versiune = rs.getString(3);
                culoare = rs.getString(4);
                jante = rs.getString(5);
                interior = rs.getString(6);
                autopilot = rs.getString(7);
                data_fab = rs.getString(8);
                nr_usi = rs.getString(9);
                tractiune = rs.getString(10);
                baterie = rs.getString(11);
                preta = rs.getString(12);
                pretatva = rs.getString(13);
                stoc = rs.getString(14);

                if ("Model 3".equals(model))
                    tempVersion = version3;
                else if ("Model Y".equals(model))
                    tempVersion = versionY;
                else
                    tempVersion = versionSX;

                if ("Model S".equals(model))
                    tempWheels = wheelsS;
                else if ("Model 3".equals(model))
                    tempWheels = wheels3;
                else if ("Model X".equals(model))
                    tempWheels = wheelsX;
                else
                    tempWheels = wheelsY;

                if ("Model S".equals(model) || "Model X".equals(model))
                    tempInterior = interiorSX;
                else
                    tempInterior = interior3Y;

                if (Objects.equals(versiune, "Performance")){
                    if (Objects.equals(model, "Model 3"))
                        tempWheels = new String[]{"20'' Black"};
                    if (Objects.equals(model, "Model Y"))
                        tempWheels = new String[]{"21'' Black"};
                }
    %>
    <input name="vin" type="hidden" value="${param.vin}">

    <select name="model" id="model">
        <% for (String mod : models) { %>
            <option><%=mod%></option>
        <% } %>
    </select>
    <script type='text/javascript'>
        $('#model').val("<%=model %>");
    </script>

    <select name="versiune" id="versiune">
        <% for (String version : tempVersion) { %>
            <option><%=version%></option>
        <% } %>
    </select>
    <script type='text/javascript'>
        $('#versiune').val("<%=versiune%>");
    </script>

    <select name="culoare" id="culoare">
        <% for (String color : colors) { %>
            <option><%=color%></option>
        <% } %>
    </select>
    <script type='text/javascript'>
        $('#culoare').val("<%=culoare%>");
    </script>

    <select name="jante" id="jante">
        <% for (String wheels : tempWheels) { %>
            <option><%=wheels%></option>
        <% } %>
    </select>
    <script type='text/javascript'>
        $('#jante').val("<%=jante%>");
    </script>

    <select name="interior" id="interior">
        <% for (String inter : tempInterior) { %>
            <option><%=inter%></option>
        <% } %>
    </select>
    <script type='text/javascript'>
        $('#interior').val("<%=interior%>");
    </script>

    <% if (Objects.equals(autopilot, "1")) {%>
        <input name="autopilot" id="autopilot" type="checkbox" value="Autopilot" checked>
    <%} else {%>
    <input name="autopilot" id="autopilot" type="checkbox" value="Autopilot">
    <% } %>
    <label for="autopilot">Autopilot</label>

    <input name="data_fab" id="data_fab" type="date" value="<%=data_fab%>">
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
    <input name="nr_usi" id="nr_usi" type="number" placeholder="Nr. usi" value="<%=nr_usi%>" readonly style="cursor: not-allowed">
    <input name="tractiune" id="tractiune" type="text" placeholder="Tractiune" value="<%=tractiune%>" readonly style="cursor: not-allowed">
    <input name="baterie" id="baterie" type="number" placeholder="Bateriei" value="<%=baterie%>" readonly style="cursor: not-allowed">
    <input name="preta" id="preta" type="number" placeholder="Pret(fara TVA)" value="<%=preta%>" onkeyup="addVat()">
    <input name="pretatva" id="pretatva" type="number" value="<%=pretatva%>" placeholder="Pret(cu TVA)" readonly>
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
    <input name="stoc" type="number" placeholder="Stoc" value="<%=stoc%>">
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
