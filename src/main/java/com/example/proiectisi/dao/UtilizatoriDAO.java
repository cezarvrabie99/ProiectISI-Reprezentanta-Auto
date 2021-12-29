package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.UtilizatoriModel;

import java.sql.*;

public class UtilizatoriDAO {
    Connection connection = SqlConnection.getInstance().getConnection();
    LogsDAO logsDAO = new LogsDAO();

    public UtilizatoriDAO() throws SQLException, ClassNotFoundException {
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

    public boolean insert(UtilizatoriModel utilizatoriModel, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("INSERT INTO utilizatori(username, password, codf) VALUES (?, ?, ?);");
        preparedStatement.setString(1, utilizatoriModel.getUsername());
        preparedStatement.setString(2, utilizatoriModel.getPassword());
        preparedStatement.setString(3, utilizatoriModel.getCodf());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public boolean update(UtilizatoriModel utilizatoriModel, String userid, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        PreparedStatement preparedStatement = connection
                .prepareStatement("UPDATE utilizatori SET username = ?, password = ?, codf = ? WHERE userid = ?;");
        preparedStatement.setString(1, utilizatoriModel.getUsername());
        preparedStatement.setString(2, utilizatoriModel.getPassword());
        preparedStatement.setString(3, utilizatoriModel.getCodf());
        preparedStatement.setString(4, userid);

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public void delete(String userid, Object user) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM utilizatori where userid = ?;");
        preparedStatement.setString(1, userid);
        preparedStatement.execute();

        logsDAO.logs(user, preparedStatement.toString());
    }

    public int getCodf(Object userObject) throws SQLException {
        String user = userObject.toString();
        int codLog = -1;
        PreparedStatement preparedStatement = connection
                .prepareStatement("SELECT codf FROM utilizatori WHERE username = ?");
        preparedStatement.setString(1, user);
        ResultSet rs = preparedStatement.executeQuery();

        if(!rs.next())
            System.out.println("No Records in the table");
        else
            codLog = rs.getInt(1);

        return codLog;
    }

    public boolean isAllowed(int codLog, int[] allowed) {
        for (int j : allowed)
            if (j == codLog)
                return true;
        return false;
    }
}
