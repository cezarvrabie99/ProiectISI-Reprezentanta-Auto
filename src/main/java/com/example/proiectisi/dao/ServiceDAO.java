package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.ServiceModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ServiceDAO {
    Connection connection = SqlConnection.getInstance().getConnection();
    LogsDAO logsDAO = new LogsDAO();

    public ServiceDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(ServiceModel serviceModel, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO service(codc, numec, prenumec, vin, model, codp, denp, angajat, stare, " +
                        "garantie, datas, oras) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_DATE , CURRENT_TIME);");
        preparedStatement.setInt(1, getCodc(serviceModel.getNumec(), serviceModel.getPrenumec()));
        preparedStatement.setString(2, serviceModel.getNumec());
        preparedStatement.setString(3, serviceModel.getPrenumec());
        preparedStatement.setString(4, serviceModel.getVin());
        preparedStatement.setString(5, getModel(serviceModel.getVin()));
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
        preparedStatement.setInt(1, getCodc(serviceModel.getNumec(), serviceModel.getPrenumec()));
        preparedStatement.setString(2, serviceModel.getNumec());
        preparedStatement.setString(3, serviceModel.getPrenumec());
        preparedStatement.setString(4, serviceModel.getVin());
        preparedStatement.setString(5, getModel(serviceModel.getVin()));
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

    public int getCodc(String numec, String prenumec) throws SQLException {
        String query = "SELECT codc FROM client WHERE numec = ? AND prenumec = ?;";
        PreparedStatement pst = connection.prepareStatement(query);
        pst.setString(1, numec);
        pst.setString(2, prenumec);
        ResultSet rs = pst.executeQuery();
        if(rs.next())
            return rs.getInt(1);

        return -1;
    }

    public String getModel(String vin) {
        vin = vin.toUpperCase();
        char vin3 = vin.charAt(3);
        switch (vin3){
            case 'S':
                return "Model S";
            case '3':
                return "Model 3";
            case 'X':
                return "Model X";
            case 'Y':
                return "Model Y";
            case 'R':
                return "Roadster";
            default:
                return "error";
        }
    }
}
