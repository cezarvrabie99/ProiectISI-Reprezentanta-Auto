package com.example.proiectisi.controller;

import com.example.proiectisi.dao.UtilizatoriDAO;
import com.example.proiectisi.model.UtilizatoriModel;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "utilizatori", value = "/utilizatori")
public class UtilizatoriServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    UtilizatoriDAO utilizatoriDAO;

    public void init() {
        try {
            utilizatoriDAO = new UtilizatoriDAO();
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
                utilizatoriDAO.delete(request.getParameter("userid"), user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("utilizatori.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String codf = request.getParameter("functii");

        UtilizatoriModel utilizatoriModel = new UtilizatoriModel();

        utilizatoriModel.setUsername(username);
        utilizatoriModel.setPassword(password);
        utilizatoriModel.setCodf(codf);

        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "edit")){
            try {
                if (utilizatoriDAO.update(utilizatoriModel, request.getParameter("userid"), user)) {
                    response.sendRedirect("utilizatori.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                if (utilizatoriDAO.insert(utilizatoriModel, user)) {
                    response.sendRedirect("utilizatori.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
