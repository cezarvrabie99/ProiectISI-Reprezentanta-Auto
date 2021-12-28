package com.example.proiectisi.controller;

import com.example.proiectisi.dao.ClientiDAO;
import com.example.proiectisi.dao.ServiceDAO;
import com.example.proiectisi.model.ClientiModel;
import com.example.proiectisi.model.ServiceModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "ServiceServlet", value = "/ServiceServlet")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ServiceDAO serviceDAO;

    public void init() {
        try {
            serviceDAO = new ServiceDAO();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "delete")){
            try {
                serviceDAO.delete(request.getParameter("cods"), user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("service.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codc = request.getParameter("codc");
        String numec = request.getParameter("numec");
        String prenumec = request.getParameter("prenumec");
        String vin = request.getParameter("vin");
        String model = request.getParameter("model");
        String codp = request.getParameter("codp");
        String denp = request.getParameter("denp");
        String angajat = request.getParameter("angajat");
        String stare = request.getParameter("stare");
        String garantie;
        if (Objects.equals(request.getParameter("garantie"), "Garantie"))
            garantie = "1";
        else
            garantie = "0";

        ServiceModel serviceModel = new ServiceModel();
        serviceModel.setCodc(codc);
        serviceModel.setNumec(numec);
        serviceModel.setPrenumec(prenumec);
        serviceModel.setVin(vin);
        serviceModel.setModel(model);
        serviceModel.setCodp(codp);
        serviceModel.setDenp(denp);
        serviceModel.setAngajat(angajat);
        serviceModel.setStare(stare);
        serviceModel.setGarantie(garantie);

        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "edit")){
            try {
                if (serviceDAO.update(serviceModel, request.getParameter("cods"), user)) {
                    response.sendRedirect("service.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                if (serviceDAO.insert(serviceModel, user)) {
                    response.sendRedirect("service.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
