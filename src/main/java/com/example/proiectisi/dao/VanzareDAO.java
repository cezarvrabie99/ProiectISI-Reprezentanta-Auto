package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.VanzareModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

public class VanzareDAO {
    Connection connection = SqlConnection.getInstance().getConnection();
    LogsDAO logsDAO = new LogsDAO();

    public VanzareDAO() throws SQLException, ClassNotFoundException {
    }

    public boolean insert(VanzareModel vanzareModel, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        String sql;
        if (Objects.equals(vanzareModel.getTipprod(), "Piese"))
            sql = "INSERT INTO vanzare(tipprod, prod, codp, vin, pret, prettva, codc, numec, prenumec, angajat, datav, orav) " +
                    "VALUES (?, ?, ?, null, ?, ?, ?, ?, ?, ?, CURRENT_DATE , CURRENT_TIME);";
        else
            sql = "INSERT INTO vanzare(tipprod, prod, codp, vin, pret, prettva, codc, numec, prenumec, angajat, datav, orav) " +
                    "VALUES (?, ?, null, ?, ?, ?, ?, ?, ?, ?, CURRENT_DATE , CURRENT_TIME);";

        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, vanzareModel.getTipprod());
        preparedStatement.setString(2, vanzareModel.getProd());
        preparedStatement.setString(3, vanzareModel.getCodp());
        preparedStatement.setString(4, vanzareModel.getPret());
        preparedStatement.setString(5, vanzareModel.getPrettva());
        preparedStatement.setInt(6, getCodc(vanzareModel.getNumec(), vanzareModel.getPrenumec()));
        preparedStatement.setString(7, vanzareModel.getNumec());
        preparedStatement.setString(8, vanzareModel.getPrenumec());
        preparedStatement.setString(9, vanzareModel.getAngajat());

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public boolean update(VanzareModel vanzareModel, String codv, Object user) throws ClassNotFoundException, SQLException {
        boolean status = true;
        String sql;
        if (Objects.equals(vanzareModel.getTipprod(), "Piese"))
            sql = "UPDATE vanzare SET tipprod = ?, prod = ?, codp = ?, vin = null, pret = ?, prettva = ?, codc = ?, " +
                    "numec = ?, prenumec = ? WHERE codv = ?";
        else
            sql = "UPDATE vanzare SET tipprod = ?, prod = ?, codp = null, vin = ?, pret = ?, prettva = ?, codc = ?, " +
                    "numec = ?, prenumec = ? WHERE codv = ?";

        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, vanzareModel.getTipprod());
        preparedStatement.setString(2, vanzareModel.getProd());
        preparedStatement.setString(3, vanzareModel.getCodp());
        preparedStatement.setString(4, vanzareModel.getPret());
        preparedStatement.setString(5, vanzareModel.getPrettva());
        preparedStatement.setInt(6, getCodc(vanzareModel.getNumec(), vanzareModel.getPrenumec()));
        preparedStatement.setString(7, vanzareModel.getNumec());
        preparedStatement.setString(8, vanzareModel.getPrenumec());
        preparedStatement.setString(9, codv);

        System.out.println(preparedStatement);
        if (preparedStatement.execute())
            return true;

        logsDAO.logs(user, preparedStatement.toString());

        return status;
    }

    public void delete(String codv, Object user) throws SQLException {
        PreparedStatement preparedStatement = connection
                .prepareStatement("DELETE FROM vanzare where codv = ?;");
        preparedStatement.setString(1, codv);
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

}
