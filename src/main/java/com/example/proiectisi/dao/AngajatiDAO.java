package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.AngajatiModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AngajatiDAO {
    Connection connection = SqlConnection.getInstance().getConnection();
    LogsDAO logsDAO = new LogsDAO();

    public AngajatiDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(AngajatiModel angajatiModel, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO angajat(numea, prenumea, cnp, adresaa, telefona, emaila, localitate, \n" +
                        "                     judet, tara, codf) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
        preparedStatement.setString(1, angajatiModel.getNumea());
        preparedStatement.setString(2, angajatiModel.getPrenumea());
        preparedStatement.setString(3, angajatiModel.getCnp());
        preparedStatement.setString(4, angajatiModel.getAdresaa());
        preparedStatement.setString(5, angajatiModel.getTelefona());
        preparedStatement.setString(6, angajatiModel.getEmailaa());
        preparedStatement.setString(7, angajatiModel.getLocalitate());
        preparedStatement.setString(8, angajatiModel.getJudet());
        preparedStatement.setString(9, angajatiModel.getTara());
        preparedStatement.setString(10, angajatiModel.getCodf());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public boolean update(AngajatiModel angajatiModel, String coda, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("UPDATE angajat SET numea = ?, prenumea = ?, cnp = ?, \n" +
                        "                                  adresaa = ?, telefona = ?, emaila = ?, localitate = ?, \n" +
                        "                   judet = ?, tara = ?, codf = ? WHERE coda = ?;");
        preparedStatement.setString(1, angajatiModel.getNumea());
        preparedStatement.setString(2, angajatiModel.getPrenumea());
        preparedStatement.setString(3, angajatiModel.getCnp());
        preparedStatement.setString(4, angajatiModel.getAdresaa());
        preparedStatement.setString(5, angajatiModel.getTelefona());
        preparedStatement.setString(6, angajatiModel.getEmailaa());
        preparedStatement.setString(7, angajatiModel.getLocalitate());
        preparedStatement.setString(8, angajatiModel.getJudet());
        preparedStatement.setString(9, angajatiModel.getTara());
        preparedStatement.setString(10, angajatiModel.getCodf());
        preparedStatement.setString(11, coda);

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public void delete(String coda, Object user) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM angajat where coda = ?;");
        preparedStatement.setString(1, coda);
        preparedStatement.execute();

        logsDAO.logs(user, preparedStatement.toString());
    }
}
