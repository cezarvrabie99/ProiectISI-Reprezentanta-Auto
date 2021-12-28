package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.AutoModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AutoDAO {
    Connection connection = SqlConnection.getInstance().getConnection();
    LogsDAO logsDAO = new LogsDAO();

    public AutoDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(AutoModel autoModel, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO autoturism(vin, model, versiune, culoare, jante, interior, \n" +
                        "autopilot, data_fab, nr_usi, tractiune, baterie, preta, pretatva, stoc) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
        preparedStatement.setString(1, autoModel.getVin());
        preparedStatement.setString(2, autoModel.getModel());
        preparedStatement.setString(3, autoModel.getVersiune());
        preparedStatement.setString(4, autoModel.getCuloare());
        preparedStatement.setString(5, autoModel.getJante());
        preparedStatement.setString(6, autoModel.getInterior());
        preparedStatement.setString(7, autoModel.getAutopilot());
        preparedStatement.setString(8, autoModel.getData_fab());
        preparedStatement.setString(9, autoModel.getNr_usi());
        preparedStatement.setString(10, autoModel.getTractiune());
        preparedStatement.setString(11, autoModel.getBaterie());
        preparedStatement.setString(12, autoModel.getPreta());
        preparedStatement.setString(13, autoModel.getPretatva());
        preparedStatement.setString(14, autoModel.getStoc());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public boolean update(AutoModel autoModel, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("UPDATE autoturism SET model = ?, versiune = ?, culoare = ?, \n" +
                        "                                  jante = ?, interior = ?, autopilot = ?, data_fab = ?, \n" +
                        "                      nr_usi = ?, tractiune = ?, baterie = ?, preta = ?, pretatva = ?, \n" +
                        "                      stoc = ? WHERE vin = ?;");

        preparedStatement.setString(1, autoModel.getModel());
        preparedStatement.setString(2, autoModel.getVersiune());
        preparedStatement.setString(3, autoModel.getCuloare());
        preparedStatement.setString(4, autoModel.getJante());
        preparedStatement.setString(5, autoModel.getInterior());
        preparedStatement.setString(6, autoModel.getAutopilot());
        preparedStatement.setString(7, autoModel.getData_fab());
        preparedStatement.setString(8, autoModel.getNr_usi());
        preparedStatement.setString(9, autoModel.getTractiune());
        preparedStatement.setString(10, autoModel.getBaterie());
        preparedStatement.setString(11, autoModel.getPreta());
        preparedStatement.setString(12, autoModel.getPretatva());
        preparedStatement.setString(13, autoModel.getStoc());
        preparedStatement.setString(14, autoModel.getVin());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public void delete(String vin, Object user) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM autoturism where vin = ?;");
        preparedStatement.setString(1, vin);
        preparedStatement.execute();

        logsDAO.logs(user, preparedStatement.toString());
    }
}
