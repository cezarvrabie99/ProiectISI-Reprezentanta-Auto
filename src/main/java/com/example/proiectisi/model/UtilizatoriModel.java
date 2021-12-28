package com.example.proiectisi.model;

import java.io.Serializable;

public class UtilizatoriModel implements Serializable {
    private static final long serialVersionUID = 1L;
    private String username, password, codf;

    public UtilizatoriModel(String username, String password, String codf) {
        this.username = username;
        this.password = password;
        this.codf = codf;
    }

    public UtilizatoriModel() {

    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCodf() {
        return codf;
    }

    public void setCodf(String codf) {
        this.codf = codf;
    }
}
