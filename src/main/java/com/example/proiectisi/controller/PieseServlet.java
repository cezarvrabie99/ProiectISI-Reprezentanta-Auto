package com.example.proiectisi.controller;

import com.example.proiectisi.dao.PieseDAO;
import com.example.proiectisi.model.PieseModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if (Objects.equals(action, "/delete")){
            try {
                pieseDAO.delete(request.getParameter("codp"));
                System.out.println("delete");
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("delete catch");
            }
        }
        System.out.println("else");
        response.sendRedirect("loginsuccess.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codp = request.getParameter("codp");
        String denp = request.getParameter("denp");
        String pretp = request.getParameter("pretp");
        String pretptva = request.getParameter("pretptva");

        PieseModel pieseModel = new PieseModel();
        pieseModel.setCodp(codp);
        pieseModel.setDenp(denp);
        pieseModel.setPretp(pretp);
        pieseModel.setPretptva(pretptva);

        try {
            if (pieseDAO.insert(pieseModel)) {
                response.sendRedirect("loginsuccess.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
