package com.example.proiectisi.dao;

import com.example.proiectisi.SqlConnection;
import com.example.proiectisi.model.AutoModel;
import com.example.proiectisi.model.ClientiModel;
import com.example.proiectisi.model.PieseModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GetVanzareDAO {
    Connection connection = SqlConnection.getInstance().getConnection();

    public GetVanzareDAO() throws SQLException, ClassNotFoundException {
    }

    public List<AutoModel> getAllVins() throws SQLException {
        List<AutoModel> list = new ArrayList<>();

        String query = "SELECT vin FROM autoturism WHERE stoc > 0;";
        PreparedStatement pst = connection.prepareStatement(query);
        ResultSet rs = pst.executeQuery();

        while(rs.next()) {
            AutoModel autoModel = new AutoModel();
            autoModel.setVin(rs.getString(1));
            list.add(autoModel);
        }

        return list;
    }

    public List<AutoModel> getAutoByVIN(String vin) throws SQLException {
        List<AutoModel> list = new ArrayList<>();

        String query = "SELECT model, preta, pretatva FROM autoturism WHERE vin = ?;";
        PreparedStatement pst = connection.prepareStatement(query);
        pst.setString(1, vin);
        ResultSet rs = pst.executeQuery();

        while(rs.next()) {
            AutoModel autoModel = new AutoModel();
            autoModel.setModel(rs.getString(1));
            autoModel.setPreta(rs.getString(2));
            autoModel.setPretatva(rs.getString(3));

            list.add(autoModel);
        }

        return list;
    }

    public List<PieseModel> getAllPiese() throws SQLException {
        List<PieseModel> list = new ArrayList<>();

        String query = "SELECT codp FROM piese;";
        PreparedStatement pst = connection.prepareStatement(query);
        ResultSet rs = pst.executeQuery();

        while(rs.next()) {
            PieseModel pieseModel = new PieseModel();
            pieseModel.setCodp(rs.getString(1));
            list.add(pieseModel);
        }

        return list;
    }

    public List<PieseModel> getPiesaByCodp(String codp) throws SQLException {
        List<PieseModel> list = new ArrayList<>();

        String query = "SELECT denp, pretp, pretptva FROM piese WHERE codp = ?;";
        PreparedStatement pst = connection.prepareStatement(query);
        pst.setString(1, codp);
        ResultSet rs = pst.executeQuery();

        while(rs.next()) {
            PieseModel pieseModel = new PieseModel();
            pieseModel.setDenp(rs.getString(1));
            pieseModel.setPretp(rs.getString(2));
            pieseModel.setPretptva(rs.getString(3));
            list.add(pieseModel);
        }

        return list;
    }

    public List<ClientiModel> getClientbyNume(String nume) throws SQLException {
        List<ClientiModel> list = new ArrayList<>();

        String query = "SELECT prenumec FROM client WHERE numec = ?;";
        PreparedStatement pst = connection.prepareStatement(query);
        pst.setString(1, nume);
        ResultSet rs = pst.executeQuery();

        while(rs.next()) {
            ClientiModel clientiModel = new ClientiModel();
            clientiModel.setPrenumec(rs.getString(1));
            list.add(clientiModel);
        }

        return list;
    }
}
