package com.example.proiectisi.model;

import java.io.Serializable;

public class FunctiiModel implements Serializable {
    private static final long serialVersionUID = 1L;

    String denf, salariubrut, salariunet;

    public FunctiiModel(String denf, String salariubrut, String salariunet) {
        this.denf = denf;
        this.salariubrut = salariubrut;
        this.salariunet = salariunet;
    }

    public FunctiiModel() {

    }

    public String getDenf() {
        return denf;
    }

    public void setDenf(String denf) {
        this.denf = denf;
    }

    public String getSalariubrut() {
        return salariubrut;
    }

    public void setSalariubrut(String salariubrut) {
        this.salariubrut = salariubrut;
    }

    public String getSalariunet() {
        return salariunet;
    }

    public void setSalariunet(String salariunet) {
        this.salariunet = salariunet;
    }
}
