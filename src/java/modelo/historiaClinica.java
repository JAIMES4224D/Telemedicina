/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Date;

/**
 *
 * @author JEJALUOS
 */
public class historiaClinica {
    private int id;
    private int idPaciente;
    private String sintomas;
    private String diagnostico;
    private String descripcion;
    private Date fechaRegistro;
    private String nombrePac;
    private String nombrePaciente;

    public historiaClinica() {
    }

    public historiaClinica(int id, int idPaciente, String descripcion, Date fechaRegistro, String nombrePac) {
        this.id = id;
        this.idPaciente = idPaciente;
        this.descripcion = descripcion;
        this.fechaRegistro = fechaRegistro;
        this.nombrePac = nombrePac;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSintomas() {
        return sintomas;
    }

    public void setSintomas(String sintomas) {
        this.sintomas = sintomas;
    }

    public String getDiagnostico() {
        return diagnostico;
    }

    public void setDiagnostico(String diagnostico) {
        this.diagnostico = diagnostico;
    }

    public int getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(int idPaciente) {
        this.idPaciente = idPaciente;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public String getNombrePac() {
        return nombrePac;
    }

    public void setNombrePac(String nombrePac) {
        this.nombrePac = nombrePac;
    }

    public String getNombrePaciente() {
        return nombrePaciente;
    }

    public void setNombrePaciente(String nombrePaciente) {
        this.nombrePaciente = nombrePaciente;
    }
    
}
