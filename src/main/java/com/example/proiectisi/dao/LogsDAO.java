package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogsDAO {
    Connection connection = SqlConnection.getInstance().getConnection();

    public LogsDAO() throws SQLException, ClassNotFoundException {
    }

    private int getCodf(String username) throws SQLException {
        String sql = "select codf from utilizatori where username = ?;";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next())
            return -1;
        else
            return rs.getInt(1);
    }

    public void logsConnect(Object user, boolean action, String sessionID) throws SQLException {
        String username = (String) user;
        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO logs (username, actiune, comanda, datal, oral, codf) VALUES (?, ?, ?, CURRENT_DATE, CURRENT_TIME, ?);");
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, action ? "login" : "logout");
        preparedStatement.setString(3, sessionID);
        preparedStatement.setInt(4, getCodf(username));

        preparedStatement.execute();
    }

    public void logs(Object user, String sql) throws SQLException {
        String username = (String) user;
        String formattedSQL = sql.replaceFirst("com.mysql.cj.jdbc.ClientPreparedStatement: ", "");
        String action = "unknown";
        if (formattedSQL.toLowerCase().startsWith("insert"))
            action = "adaugare";
        else if (formattedSQL.toLowerCase().startsWith("update"))
            action = "editare";
        else if (formattedSQL.toLowerCase().startsWith("delete"))
            action = "stergere";


        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO logs (username, actiune, comanda, datal, oral, codf) VALUES (?, ?, ?, CURRENT_DATE, CURRENT_TIME, ?);");
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, action);
        preparedStatement.setString(3, formattedSQL);
        preparedStatement.setInt(4, getCodf(username));

        System.out.println(preparedStatement);

        preparedStatement.execute();
    }
}
