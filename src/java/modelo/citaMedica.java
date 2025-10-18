/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.*;

/**
 *
 * @author JEJALUOS
 */
public class citaMedica {
    private int id;
    private int idMedico;
    private int idPaciente;
    private int idEspecialidad;
    private int idEnlace;
    private Date horaInicio;
    private Date horaFin;
    private Timestamp horaInicio1;
    private Timestamp horaFin1;
    private String estado;
    private Date fechaRegistro;
    private double precio;
    private String nombreMedico;
    private String nombrePaciente;
    private String nombreEspecialidad;
    private String enlace;

    public citaMedica(int id, int idMedico, int idPaciente, int idEspecialidad, int idEnlace, Date horaInicio, Date horaFin, String estado, Date fechaRegistro, double precio, String nombreMedico, String nombrePaciente, String nombreEspecialidad, String enlace) {
        this.id = id;
        this.idMedico = idMedico;
        this.idPaciente = idPaciente;
        this.idEspecialidad = idEspecialidad;
        this.idEnlace = idEnlace;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.estado = estado;
        this.fechaRegistro = fechaRegistro;
        this.precio = precio;
        this.nombreMedico = nombreMedico;
        this.nombrePaciente = nombrePaciente;
        this.nombreEspecialidad = nombreEspecialidad;
        this.enlace = enlace;
    }

    public Timestamp getHoraInicio1() {
        return horaInicio1;
    }

    public void setHoraInicio1(Timestamp horaInicio1) {
        this.horaInicio1 = horaInicio1;
    }

    public Timestamp getHoraFin1() {
        return horaFin1;
    }

    public void setHoraFin1(Timestamp horaFin1) {
        this.horaFin1 = horaFin1;
    }

    public citaMedica() {
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

    public int getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(int idPaciente) {
        this.idPaciente = idPaciente;
    }

    public int getIdEspecialidad() {
        return idEspecialidad;
    }

    public void setIdEspecialidad(int idEspecialidad) {
        this.idEspecialidad = idEspecialidad;
    }

    public int getIdEnlace() {
        return idEnlace;
    }

    public void setIdEnlace(int idEnlace) {
        this.idEnlace = idEnlace;
    }

    public Date getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(Date horaInicio) {
        this.horaInicio = horaInicio;
    }

    public Date getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(Date horaFin) {
        this.horaFin = horaFin;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getNombreMedico() {
        return nombreMedico;
    }

    public void setNombreMedico(String nombreMedico) {
        this.nombreMedico = nombreMedico;
    }

    public String getNombrePaciente() {
        return nombrePaciente;
    }

    public void setNombrePaciente(String nombrePaciente) {
        this.nombrePaciente = nombrePaciente;
    }

    public String getNombreEspecialidad() {
        return nombreEspecialidad;
    }

    public void setNombreEspecialidad(String nombreEspecialidad) {
        this.nombreEspecialidad = nombreEspecialidad;
    }

    public String getEnlace() {
        return enlace;
    }

    public void setEnlace(String enlace) {
        this.enlace = enlace;
    }
    
    
}
