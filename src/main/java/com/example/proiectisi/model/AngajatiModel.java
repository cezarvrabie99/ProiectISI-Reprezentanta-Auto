package com.example.proiectisi.model;

import java.io.Serializable;

public class AngajatiModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private String numea, prenumea, cnp, adresaa, telefona, emailaa, localitate, judet, tara, codf;

    public AngajatiModel(String numea, String prenumea, String cnp, String adresaa, String telefona, String emailaa, String localitate, String judet, String tara, String codf) {
        this.numea = numea;
        this.prenumea = prenumea;
        this.cnp = cnp;
        this.adresaa = adresaa;
        this.telefona = telefona;
        this.emailaa = emailaa;
        this.localitate = localitate;
        this.judet = judet;
        this.tara = tara;
        this.codf = codf;
    }

    public AngajatiModel() {

    }

    public String getNumea() {
        return numea;
    }

    public void setNumea(String numea) {
        this.numea = numea;
    }

    public String getPrenumea() {
        return prenumea;
    }

    public void setPrenumea(String prenumea) {
        this.prenumea = prenumea;
    }

    public String getCnp() {
        return cnp;
    }

    public void setCnp(String cnp) {
        this.cnp = cnp;
    }

    public String getAdresaa() {
        return adresaa;
    }

    public void setAdresaa(String adresaa) {
        this.adresaa = adresaa;
    }

    public String getTelefona() {
        return telefona;
    }

    public void setTelefona(String telefona) {
        this.telefona = telefona;
    }

    public String getEmailaa() {
        return emailaa;
    }

    public void setEmailaa(String emailaa) {
        this.emailaa = emailaa;
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

    public String getCodf() {
        return codf;
    }

    public void setCodf(String codf) {
        this.codf = codf;
    }
}
