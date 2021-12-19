package com.example.proiectisi.model;

import java.io.Serializable;

public class PieseModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private String codp, denp, pretp, pretptva;

    public PieseModel(String codp, String denp, String pretp, String pretptva) {
        this.codp = codp;
        this.denp = denp;
        this.pretp = pretp;
        this.pretptva = pretptva;
    }

    public PieseModel() {
        
    }

    public String getCodp() {
        return codp;
    }

    public void setCodp(String codp) {
        this.codp = codp;
    }

    public String getDenp() {
        return denp;
    }

    public void setDenp(String denp) {
        this.denp = denp;
    }

    public String getPretp() {
        return pretp;
    }

    public void setPretp(String pretp) {
        this.pretp = pretp;
    }

    public String getPretptva() {
        return pretptva;
    }

    public void setPretptva(String pretptva) {
        this.pretptva = pretptva;
    }
}
