package com.example.proiectisi.controller;

import com.example.proiectisi.dao.LogsDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "logout", value = "/logout")
public class LogoutServlet extends HttpServlet {
    LogsDAO logsDAO = new LogsDAO();

    public LogoutServlet() throws SQLException, ClassNotFoundException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        try {
            logsDAO.logsConnect(session.getAttribute("user"), false, session.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {

    }
}
