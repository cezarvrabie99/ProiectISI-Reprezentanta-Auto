package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.PieseModel;

import java.sql.*;

public class PieseDAO {
    Connection connection = SqlConnection.getInstance().getConnection();

    public PieseDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(PieseModel pieseModel) throws ClassNotFoundException, SQLException {
        boolean status = true;
         PreparedStatement preparedStatement = connection
                 .prepareStatement("INSERT INTO piese(codp, denp, pretp, pretptva) VALUES (?, ?, ?, ?);");
        preparedStatement.setString(1, pieseModel.getCodp());
        preparedStatement.setString(2, pieseModel.getDenp());
        preparedStatement.setString(3, pieseModel.getPretp());
        preparedStatement.setString(4, pieseModel.getPretptva());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        return status;
    }

    public boolean update(PieseModel pieseModel) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("UPDATE piese SET denp = ?, pretp = ?, pretptva = ? WHERE codp = ?;");
        preparedStatement.setString(1, pieseModel.getDenp());
        preparedStatement.setString(2, pieseModel.getPretp());
        preparedStatement.setString(3, pieseModel.getPretptva());
        preparedStatement.setString(4, pieseModel.getCodp());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        return status;
    }

    public void delete(String codp) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM piese where codp = ?;");
        preparedStatement.setString(1, codp);
        preparedStatement.execute();
    }
}
