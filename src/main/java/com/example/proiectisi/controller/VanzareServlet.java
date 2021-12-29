package com.example.proiectisi.controller;

import com.example.proiectisi.dao.VanzareDAO;
import com.example.proiectisi.model.VanzareModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "vanzare", value = "/vanzare")
public class VanzareServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    VanzareDAO vanzareDAO;

    public void init() {
        try {
            vanzareDAO = new VanzareDAO();
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
                vanzareDAO.delete(request.getParameter("codv"), user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("vanzare.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipprod = request.getParameter("tipprod");
        String prod = request.getParameter("prod");
        String codp = request.getParameter("codp");
        String vin = request.getParameter("vin");
        String pret = request.getParameter("pret");
        String prettva = request.getParameter("prettva");
        String codc = request.getParameter("codc");
        String numec = request.getParameter("numec");
        String prenumec = request.getParameter("prenumec");
        String angajat = request.getParameter("angajat");

        VanzareModel vanzareModel = new VanzareModel();

        vanzareModel.setTipprod(tipprod);
        vanzareModel.setProd(prod);
        vanzareModel.setCodp(codp);
        vanzareModel.setVin(vin);
        vanzareModel.setPret(pret);
        vanzareModel.setPrettva(prettva);
        vanzareModel.setCodc(codc);
        vanzareModel.setNumec(numec);
        vanzareModel.setPrenumec(prenumec);
        vanzareModel.setAngajat(angajat);

        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (Objects.equals(request.getParameter("action"), "edit")){
            try {
                if (vanzareDAO.update(vanzareModel, request.getParameter("codv"), user)) {
                    response.sendRedirect("vanzare.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                if (vanzareDAO.insert(vanzareModel, user)) {
                    response.sendRedirect("vanzare.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
