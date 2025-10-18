/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

/**
 *
 * @author JEJALUOS
 */
public class horario {
    private int id;
    private int idMedico;
    private Timestamp horaInicio;  // ← debe ser Timestamp
    private Timestamp horaFin;     // ← debe ser Timestamp
    private String enlace;

    public horario() {
    }

    public horario(int id, int idMedico, Timestamp horaInicio, Timestamp horaFin, String enlace) {
        this.id = id;
        this.idMedico = idMedico;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.enlace = enlace;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdMedico() {
        return idMedico;
    }

    public void setIdMedico(int idMedico) {
        this.idMedico = idMedico;
    }

    public Timestamp getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(Timestamp horaInicio) {
        this.horaInicio = horaInicio;
    }

    public Timestamp getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(Timestamp horaFin) {
        this.horaFin = horaFin;
    }

    public String getEnlace() {
        return enlace;
    }

    public void setEnlace(String enlace) {
        this.enlace = enlace;
    }
    
    

}