package com.example.proiectisi.controller;

import com.example.proiectisi.dao.FunctiiDAO;
import com.example.proiectisi.model.FunctiiModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "functii", value = "/functii")
public class FunctiiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FunctiiDAO functiiDAO;

    public void init() {
        try {
            functiiDAO = new FunctiiDAO();
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
                functiiDAO.delete(request.getParameter("codf"), user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("functii.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String denf = request.getParameter("denf");
        String salariubrut = request.getParameter("salariubrut");
        String salariunet = request.getParameter("salariunet");

        FunctiiModel functiiModel = new FunctiiModel();

        functiiModel.setDenf(denf);
        functiiModel.setSalariubrut(salariubrut);
        functiiModel.setSalariunet(salariunet);

        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "edit")){
            try {
                if (functiiDAO.update(functiiModel, request.getParameter("codf"), user)) {
                    response.sendRedirect("functii.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                if (functiiDAO.insert(functiiModel, user)) {
                    response.sendRedirect("functii.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
