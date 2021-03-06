package com.example.proiectisi.controller;

import com.example.proiectisi.dao.LogsDAO;
import com.example.proiectisi.dao.UtilizatoriDAO;
import com.example.proiectisi.model.UtilizatoriModel;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilizatoriDAO utilizatoriDAO;
    LogsDAO logsDAO = new LogsDAO();

    public LoginServlet() throws SQLException, ClassNotFoundException {
    }

    public void init() {
        try {
            utilizatoriDAO = new UtilizatoriDAO();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String user = request.getParameter("user");
        String parola = request.getParameter("parola");
        UtilizatoriModel utilizatoriModel = new UtilizatoriModel();
        utilizatoriModel.setUsername(user);
        utilizatoriModel.setPassword(parola);
        try {
            if (utilizatoriDAO.validate(utilizatoriModel)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                logsDAO.logsConnect(session.getAttribute("user"), true, session.getId());
                int codf = utilizatoriDAO.getCodf(user);
                if (codf == 4)
                    response.sendRedirect("angajati.jsp");
                else if (codf == 6 || codf == 7)
                    response.sendRedirect("auto.jsp");
                else if (codf == 1)
                    response.sendRedirect("piese.jsp");
                else
                    response.sendRedirect("error.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
