package com.example.proiectisi.controller;

import com.example.proiectisi.dao.ClientiDAO;
import com.example.proiectisi.model.ClientiModel;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "clienti", value = "/clienti")
public class ClientiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClientiDAO clientiDAO;

    public void init() {
        try {
            clientiDAO = new ClientiDAO();
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
                clientiDAO.delete(request.getParameter("codc"), user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("clienti.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String numec = request.getParameter("numec");
        String prenumec = request.getParameter("prenumec");
        String cnp = request.getParameter("cnp");
        String telefonc = request.getParameter("telefonc");
        String emailc = request.getParameter("emailc");
        String adresac = request.getParameter("adresac");
        String localitate = request.getParameter("localitate");
        String judet = request.getParameter("judet");
        String tara = request.getParameter("tara");

        ClientiModel clientiModel = new ClientiModel();
        clientiModel.setNumec(numec);
        clientiModel.setPrenumec(prenumec);
        clientiModel.setCnp(cnp);
        clientiModel.setTelefonc(telefonc);
        clientiModel.setEmailc(emailc);
        clientiModel.setAdresac(adresac);
        clientiModel.setLocalitate(localitate);
        clientiModel.setJudet(judet);
        clientiModel.setTara(tara);

        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "edit")){
            try {
                if (clientiDAO.update(clientiModel, request.getParameter("codc"), user)) {
                    response.sendRedirect("clienti.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                if (clientiDAO.insert(clientiModel, user)) {
                    response.sendRedirect("clienti.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
