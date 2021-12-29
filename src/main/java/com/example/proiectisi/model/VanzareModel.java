package com.example.proiectisi.model;

import java.io.Serializable;

public class VanzareModel implements Serializable {
    private static final long serialVersionUID = 1L;
    private String tipprod, prod, codp, vin, pret, prettva, codc, numec, prenumec, angajat;

    public VanzareModel(String tipprod, String prod, String codp, String vin, String pret, String prettva, String codc, String numec, String prenumec, String angajat) {
        this.tipprod = tipprod;
        this.prod = prod;
        this.codp = codp;
        this.vin = vin;
        this.pret = pret;
        this.prettva = prettva;
        this.codc = codc;
        this.numec = numec;
        this.prenumec = prenumec;
        this.angajat = angajat;
    }

    public VanzareModel() {

    }

    public String getTipprod() {
        return tipprod;
    }

    public void setTipprod(String tipprod) {
        this.tipprod = tipprod;
    }

    public String getProd() {
        return prod;
    }

    public void setProd(String prod) {
        this.prod = prod;
    }

    public String getCodp() {
        return codp;
    }

    public void setCodp(String codp) {
        this.codp = codp;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public String getPret() {
        return pret;
    }

    public void setPret(String pret) {
        this.pret = pret;
    }

    public String getPrettva() {
        return prettva;
    }

    public void setPrettva(String prettva) {
        this.prettva = prettva;
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

    public String getAngajat() {
        return angajat;
    }

    public void setAngajat(String angajat) {
        this.angajat = angajat;
    }
}
