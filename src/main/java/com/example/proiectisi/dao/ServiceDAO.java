package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.ServiceModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ServiceDAO {
    Connection connection = SqlConnection.getInstance().getConnection();
    LogsDAO logsDAO = new LogsDAO();

    public ServiceDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(ServiceModel serviceModel, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO piese(codc, numec, prenumec, vin, model, codp, denp, angajat, stare, " +
                        "garantie, datas, oras) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_DATE , CURRENT_TIME);");
        preparedStatement.setString(1, serviceModel.getCodc());
        preparedStatement.setString(2, serviceModel.getNumec());
        preparedStatement.setString(3, serviceModel.getPrenumec());
        preparedStatement.setString(4, serviceModel.getVin());
        preparedStatement.setString(5, serviceModel.getModel());
        preparedStatement.setString(6, serviceModel.getCodp());
        preparedStatement.setString(7, serviceModel.getDenp());
        preparedStatement.setString(8, serviceModel.getAngajat());
        preparedStatement.setString(9, serviceModel.getStare());
        preparedStatement.setString(10, serviceModel.getGarantie());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public boolean update(ServiceModel serviceModel, String cods, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("UPDATE service SET codc = ?, numec = ?, prenumec = ?, vin = ?, model = ?, " +
                        "codp = ?, denp = ?, stare = ?, garantie = ? WHERE cods = ?;");
        preparedStatement.setString(1, serviceModel.getCodc());
        preparedStatement.setString(2, serviceModel.getNumec());
        preparedStatement.setString(3, serviceModel.getPrenumec());
        preparedStatement.setString(4, serviceModel.getVin());
        preparedStatement.setString(5, serviceModel.getModel());
        preparedStatement.setString(6, serviceModel.getCodp());
        preparedStatement.setString(7, serviceModel.getDenp());
        preparedStatement.setString(8, serviceModel.getStare());
        preparedStatement.setString(9, serviceModel.getGarantie());
        preparedStatement.setString(10, cods);

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public void delete(String cods, Object user) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM service where cods = ?;");
        preparedStatement.setString(1, cods);
        preparedStatement.execute();

        logsDAO.logs(user, preparedStatement.toString());
    }
}
