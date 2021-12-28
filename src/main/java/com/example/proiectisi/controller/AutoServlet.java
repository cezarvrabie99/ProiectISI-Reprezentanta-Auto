package com.example.proiectisi.controller;

import com.example.proiectisi.dao.AutoDAO;
import com.example.proiectisi.model.AutoModel;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "auto", value = "/auto")
public class AutoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    AutoDAO autoDAO;

    public void init() {
        try {
            autoDAO = new AutoDAO();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "delete")){
            try {
                autoDAO.delete(request.getParameter("vin"), user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("auto.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String vin = request.getParameter("vin");
        String model = request.getParameter("model");
        String versiune = request.getParameter("versiune");
        String culoare = request.getParameter("culoare");
        String jante = request.getParameter("jante");
        String interior = request.getParameter("interior");
        String autopilot;
        if (Objects.equals(request.getParameter("autopilot"), "Autopilot"))
            autopilot = "1";
        else
            autopilot = "0";
        String data_fab = request.getParameter("data_fab");
        String nr_usi = request.getParameter("nr_usi");
        String tractiune = request.getParameter("tractiune");
        String baterie = request.getParameter("baterie");
        String preta = request.getParameter("preta");
        String pretatva = request.getParameter("pretatva");
        String stoc = request.getParameter("stoc");

        AutoModel autoModel = new AutoModel();
        autoModel.setVin(vin);
        autoModel.setModel(model);
        autoModel.setVersiune(versiune);
        autoModel.setCuloare(culoare);
        autoModel.setJante(jante);
        autoModel.setInterior(interior);
        autoModel.setAutopilot(autopilot);
        autoModel.setData_fab(data_fab);
        autoModel.setNr_usi(nr_usi);
        autoModel.setTractiune(tractiune);
        autoModel.setBaterie(baterie);
        autoModel.setPreta(preta);
        autoModel.setPretatva(pretatva);
        autoModel.setStoc(stoc);

        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "edit")){
            try {
                if (autoDAO.update(autoModel, user)) {
                    response.sendRedirect("auto.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                if (autoDAO.insert(autoModel, user)) {
                    response.sendRedirect("auto.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
