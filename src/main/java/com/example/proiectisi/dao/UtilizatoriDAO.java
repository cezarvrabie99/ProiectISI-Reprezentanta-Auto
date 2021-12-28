package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.UtilizatoriModel;

import java.sql.*;

public class UtilizatoriDAO {
    Connection connection;

    {
        try {
            connection = SqlConnection.getInstance().getConnection();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean validate(UtilizatoriModel utilizatoriModel) throws ClassNotFoundException, SQLException {
        boolean status;

         PreparedStatement preparedStatement = connection
                 .prepareStatement("SELECT * FROM utilizatori WHERE username = ? AND password = ?;");
        preparedStatement.setString(1, utilizatoriModel.getUsername());
        preparedStatement.setString(2, utilizatoriModel.getPassword());

        System.out.println(preparedStatement);
        ResultSet rs = preparedStatement.executeQuery();
        status = rs.next();
        return status;
    }
}
