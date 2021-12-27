package com.example.proiectisi.controller;

import com.example.proiectisi.dao.AngajatiDAO;
import com.example.proiectisi.model.AngajatiModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "angajati", value = "/angajati")
public class AngajatiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AngajatiDAO angajatiDAO;

    public void init() {
        try {
            angajatiDAO = new AngajatiDAO();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (Objects.equals(request.getParameter("action"), "delete")){
            try {
                angajatiDAO.delete(request.getParameter("coda"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("angajati.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numea = request.getParameter("numea");
        String prenumea = request.getParameter("prenumea");
        String cnp = request.getParameter("cnp");
        String adresaa = request.getParameter("adresaa");
        String telefona = request.getParameter("telefona");
        String emaila = request.getParameter("emaila");
        String localitate = request.getParameter("localitate");
        String judet = request.getParameter("judet");
        String tara = request.getParameter("tara");
        String codf = request.getParameter("functii");

        AngajatiModel angajatiModel = new AngajatiModel();
        angajatiModel.setNumea(numea);
        angajatiModel.setPrenumea(prenumea);
        angajatiModel.setCnp(cnp);
        angajatiModel.setAdresaa(adresaa);
        angajatiModel.setTelefona(telefona);
        angajatiModel.setEmailaa(emaila);
        angajatiModel.setLocalitate(localitate);
        angajatiModel.setJudet(judet);
        angajatiModel.setTara(tara);
        angajatiModel.setCodf(codf);

        if (Objects.equals(request.getParameter("action"), "edit")){
            try {
                if (angajatiDAO.update(angajatiModel, request.getParameter("coda"))) {
                    response.sendRedirect("angajati.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                if (angajatiDAO.insert(angajatiModel)) {
                    response.sendRedirect("angajati.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
