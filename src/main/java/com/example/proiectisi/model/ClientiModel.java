package com.example.proiectisi.model;

import java.io.Serializable;

public class ClientiModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private String numec, prenumec, cnp, adresac, telefonc, emailc, localitate, judet, tara;

    public ClientiModel(String numec, String prenumec, String cnp, String adresac, String telefonc, String emailc, String localitate, String judet, String tara) {
        this.numec = numec;
        this.prenumec = prenumec;
        this.cnp = cnp;
        this.adresac = adresac;
        this.telefonc = telefonc;
        this.emailc = emailc;
        this.localitate = localitate;
        this.judet = judet;
        this.tara = tara;
    }

    public ClientiModel() {

    }

    public String getNumec() {
        return numec;
    }

    public void setNumec(String numec) {
        this.numec = numec;
    }

    public String getPrenumec() {
        return prenumec;
    }

    public void setPrenumec(String prenumec) {
        this.prenumec = prenumec;
    }

    public String getCnp() {
        return cnp;
    }

    public void setCnp(String cnp) {
        this.cnp = cnp;
    }

    public String getAdresac() {
        return adresac;
    }

    public void setAdresac(String adresac) {
        this.adresac = adresac;
    }

    public String getTelefonc() {
        return telefonc;
    }

    public void setTelefonc(String telefonc) {
        this.telefonc = telefonc;
    }

    public String getEmailc() {
        return emailc;
    }

    public void setEmailc(String emailc) {
        this.emailc = emailc;
    }

    public String getLocalitate() {
        return localitate;
    }

    public void setLocalitate(String localitate) {
        this.localitate = localitate;
    }

    public String getJudet() {
        return judet;
    }

    public void setJudet(String judet) {
        this.judet = judet;
    }

    public String getTara() {
        return tara;
    }

    public void setTara(String tara) {
        this.tara = tara;
    }
}
