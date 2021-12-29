package com.example.proiectisi.controller;

import com.example.proiectisi.dao.GetVanzareDAO;
import com.example.proiectisi.model.AutoModel;
import com.example.proiectisi.model.ClientiModel;
import com.example.proiectisi.model.PieseModel;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "getvanzare", value = "/getvanzare")
public class GetVanzareServlet extends HttpServlet {
    Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            GetVanzareDAO getVanzareDAO = new GetVanzareDAO();

            String type = request.getParameter("type");
            String typeS = request.getParameter("typeS");
            String codpS = request.getParameter("codpS");
            String numec = request.getParameter("numec");

            if (type != null) {
                if (Objects.equals(type, "Piese")) {
                    List<PieseModel> list = getVanzareDAO.getAllPiese();
                    String pieseList = gson.toJson(list);
                    response.setContentType("application/json");
                    response.getWriter().write(pieseList);
                } else if (type.equals("Autoturisme")) {
                    List<AutoModel> list = getVanzareDAO.getAllVins();
                    String autoList = gson.toJson(list);
                    response.setContentType("application/json");
                    response.getWriter().write(autoList);
                }
                return;
            }

            if (typeS != null && codpS != null) {
                if (Objects.equals(typeS, "Piese")) {
                    List<PieseModel> list = getVanzareDAO.getPiesaByCodp(codpS);
                    String pieseList = gson.toJson(list);
                    response.setContentType("application/json");
                    response.getWriter().write(pieseList);
                } else if (typeS.equals("Autoturisme")) {
                    List<AutoModel> list = getVanzareDAO.getAutoByVIN(codpS);
                    String autoList = gson.toJson(list);
                    response.setContentType("application/json");
                    response.getWriter().write(autoList);
                }
                return;
            }

            if (numec != null) {
                List<ClientiModel> list = getVanzareDAO.getClientbyNume(numec);
                String prenumeList = gson.toJson(list);
                response.setContentType("application/json");
                response.getWriter().write(prenumeList);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
