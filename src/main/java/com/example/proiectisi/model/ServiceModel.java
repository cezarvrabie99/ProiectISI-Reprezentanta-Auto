package com.example.proiectisi.model;

import java.io.Serializable;

public class ServiceModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private String codc, numec, prenumec, vin, model, codp, denp, angajat, stare, garantie;

    public ServiceModel(String codc, String numec, String prenumec, String vin, String model, String codp, String denp, String angajat, String stare, String garantie) {
        this.codc = codc;
        this.numec = numec;
        this.prenumec = prenumec;
        this.vin = vin;
        this.model = model;
        this.codp = codp;
        this.denp = denp;
        this.angajat = angajat;
        this.stare = stare;
        this.garantie = garantie;
    }

    public ServiceModel() {

    }

    public String getCodc() {
        return codc;
    }

    public void setCodc(String codc) {
        this.codc = codc;
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

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
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

    public String getAngajat() {
        return angajat;
    }

    public void setAngajat(String angajat) {
        this.angajat = angajat;
    }

    public String getStare() {
        return stare;
    }

    public void setStare(String stare) {
        this.stare = stare;
    }

    public String getGarantie() {
        return garantie;
    }

    public void setGarantie(String garantie) {
        this.garantie = garantie;
    }
}
