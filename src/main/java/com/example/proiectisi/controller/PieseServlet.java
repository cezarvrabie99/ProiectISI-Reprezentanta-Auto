package com.example.proiectisi.controller;

import com.example.proiectisi.dao.PieseDAO;
import com.example.proiectisi.model.PieseModel;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "piese", value = "/piese")
public class PieseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PieseDAO pieseDAO;

    public void init() {
        try {
            pieseDAO = new PieseDAO();
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
                pieseDAO.delete(request.getParameter("codp"), user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("piese.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String codp = request.getParameter("codp");
        String denp = request.getParameter("denp");
        String pretp = request.getParameter("pretp");
        String pretptva = request.getParameter("pretptva");

        PieseModel pieseModel = new PieseModel();
        pieseModel.setCodp(codp);
        pieseModel.setDenp(denp);
        pieseModel.setPretp(pretp);
        pieseModel.setPretptva(pretptva);

        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "edit")){
            try {
                if (pieseDAO.update(pieseModel, user)) {
                    response.sendRedirect("piese.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                if (pieseDAO.insert(pieseModel, user)) {
                    response.sendRedirect("piese.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
