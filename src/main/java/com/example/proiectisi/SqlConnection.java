package com.example.proiectisi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlConnection {
    private static SqlConnection sqlConnection;

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager
                .getConnection("jdbc:mysql://localhost:3306/proiect", "root", "");
    }

    public synchronized static SqlConnection getInstance(){
        if (sqlConnection == null)
            sqlConnection = new SqlConnection();
        return sqlConnection;
    }
}
