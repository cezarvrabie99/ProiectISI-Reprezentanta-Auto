package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.ClientiModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ClientiDAO {
    Connection connection = SqlConnection.getInstance().getConnection();

    public ClientiDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(ClientiModel clientiModel) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO client(numec, prenumec, cnp, telefonc, emailc, adresac, localitate, \n" +
                        "                     judet, tara) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);");
        preparedStatement.setString(1, clientiModel.getNumec());
        preparedStatement.setString(2, clientiModel.getPrenumec());
        preparedStatement.setString(3, clientiModel.getCnp());
        preparedStatement.setString(4, clientiModel.getTelefonc());
        preparedStatement.setString(5, clientiModel.getEmailc());
        preparedStatement.setString(6, clientiModel.getAdresac());
        preparedStatement.setString(7, clientiModel.getLocalitate());
        preparedStatement.setString(8, clientiModel.getJudet());
        preparedStatement.setString(9, clientiModel.getTara());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        return status;
    }

    public boolean update(ClientiModel clientiModel, String codc) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("UPDATE client SET numec = ?, prenumec = ?, cnp = ?, \n" +
                        "                                  telefonc = ?, emailc = ?, adresac = ?, localitate = ?, \n" +
                        "                   judet = ?, tara = ? WHERE codc = ?;");
        preparedStatement.setString(1, clientiModel.getNumec());
        preparedStatement.setString(2, clientiModel.getPrenumec());
        preparedStatement.setString(3, clientiModel.getCnp());
        preparedStatement.setString(4, clientiModel.getTelefonc());
        preparedStatement.setString(5, clientiModel.getEmailc());
        preparedStatement.setString(6, clientiModel.getAdresac());
        preparedStatement.setString(7, clientiModel.getLocalitate());
        preparedStatement.setString(8, clientiModel.getJudet());
        preparedStatement.setString(9, clientiModel.getTara());
        preparedStatement.setString(10, codc);

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        return status;
    }

    public void delete(String codc) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM client where codc = ?;");
        preparedStatement.setString(1, codc);
        preparedStatement.execute();
    }
}
