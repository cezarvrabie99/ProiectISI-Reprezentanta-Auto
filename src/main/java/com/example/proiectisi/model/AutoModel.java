package com.example.proiectisi.model;

import java.io.Serializable;

public class AutoModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private String vin, model, versiune, culoare, jante, interior, autopilot, data_fab, nr_usi, tractiune, baterie,
            preta, pretatva, stoc;

    public AutoModel(String vin, String model, String versiune, String culoare, String jante, String interior, String autopilot, String data_fab, String nr_usi, String tractiune, String baterie, String preta, String pretatva, String stoc) {
        this.vin = vin;
        this.model = model;
        this.versiune = versiune;
        this.culoare = culoare;
        this.jante = jante;
        this.interior = interior;
        this.autopilot = autopilot;
        this.data_fab = data_fab;
        this.nr_usi = nr_usi;
        this.tractiune = tractiune;
        this.baterie = baterie;
        this.preta = preta;
        this.pretatva = pretatva;
        this.stoc = stoc;
    }

    public AutoModel() {

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

    public String getVersiune() {
        return versiune;
    }

    public void setVersiune(String versiune) {
        this.versiune = versiune;
    }

    public String getCuloare() {
        return culoare;
    }

    public void setCuloare(String culoare) {
        this.culoare = culoare;
    }

    public String getJante() {
        return jante;
    }

    public void setJante(String jante) {
        this.jante = jante;
    }

    public String getInterior() {
        return interior;
    }

    public void setInterior(String interior) {
        this.interior = interior;
    }

    public String getAutopilot() {
        return autopilot;
    }

    public void setAutopilot(String autopilot) {
        this.autopilot = autopilot;
    }

    public String getData_fab() {
        return data_fab;
    }

    public void setData_fab(String data_fab) {
        this.data_fab = data_fab;
    }

    public String getNr_usi() {
        return nr_usi;
    }

    public void setNr_usi(String nr_usi) {
        this.nr_usi = nr_usi;
    }

    public String getTractiune() {
        return tractiune;
    }

    public void setTractiune(String tractiune) {
        this.tractiune = tractiune;
    }

    public String getBaterie() {
        return baterie;
    }

    public void setBaterie(String baterie) {
        this.baterie = baterie;
    }

    public String getPreta() {
        return preta;
    }

    public void setPreta(String preta) {
        this.preta = preta;
    }

    public String getPretatva() {
        return pretatva;
    }

    public void setPretatva(String pretatva) {
        this.pretatva = pretatva;
    }

    public String getStoc() {
        return stoc;
    }

    public void setStoc(String stoc) {
        this.stoc = stoc;
    }
}
