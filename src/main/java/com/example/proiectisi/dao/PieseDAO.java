package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.PieseModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PieseDAO {
    Connection connection = SqlConnection.getInstance().getConnection();

    public PieseDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(PieseModel pieseModel) throws ClassNotFoundException, SQLException {
        boolean status = true;
        //Class.forName("com.mysql.jdbc.Driver");
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

    public List<PieseModel> selectAll() throws SQLException {

        List <PieseModel> users = new ArrayList<>();

        PreparedStatement preparedStatement = connection.prepareStatement("select * from piese;");
        System.out.println(preparedStatement);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            String codp = rs.getString("codp");
            String denp = rs.getString("denp");
            String pretp = rs.getString("pretp");
            String pretptva = rs.getString("pretptva");
            users.add(new PieseModel(codp, denp, pretp, pretptva));
        }
        return users;
    }

    public void delete(String codp) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM piese where codp = ?;");
        preparedStatement.setString(1, codp);
        preparedStatement.execute();
    }
}
