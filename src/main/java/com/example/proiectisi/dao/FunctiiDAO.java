package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.AngajatiModel;
import com.example.proiectisi.model.FunctiiModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FunctiiDAO {
    Connection connection = SqlConnection.getInstance().getConnection();
    LogsDAO logsDAO = new LogsDAO();

    public FunctiiDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(FunctiiModel functiiModel, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO functie(denf, salariubrut, salariunet) VALUES (?, ?, ?);");
        preparedStatement.setString(1, functiiModel.getDenf());
        preparedStatement.setString(2, functiiModel.getSalariubrut());
        preparedStatement.setString(3, functiiModel.getSalariunet());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public boolean update(FunctiiModel functiiModel, String codf, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("UPDATE functie SET denf = ?, salariubrut = ?, salariunet = ? WHERE codf = ?;");
        preparedStatement.setString(1, functiiModel.getDenf());
        preparedStatement.setString(2, functiiModel.getSalariubrut());
        preparedStatement.setString(3, functiiModel.getSalariunet());
        preparedStatement.setString(4, codf);

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public void delete(String codf, Object user) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM functie where codf = ?;");
        preparedStatement.setString(1, codf);
        preparedStatement.execute();

        logsDAO.logs(user, preparedStatement.toString());
    }
}
