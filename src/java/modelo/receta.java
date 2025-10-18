/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Timestamp;

/**
 *
 * @author JEJALUOS
 */
public class receta {
    private int id;
    private int idCita;
    private int idMedico;
    private int idPaciente;
    private String diagnostico;
    private String Medicamento;
    private Timestamp fecha;
    private double total;
    private String nombreMedico;
    private String nombrePaciente;

    public receta() {
    }

    public receta(int id, int idCita, int idMedico, int idPaciente, String diagnostico, String Medicamento, Timestamp fecha, double total, String nombreMedico, String nombrePaciente) {
        this.id = id;
        this.idCita = idCita;
        this.idMedico = idMedico;
        this.idPaciente = idPaciente;
        this.diagnostico = diagnostico;
        this.Medicamento = Medicamento;
        this.fecha = fecha;
        this.total = total;
        this.nombreMedico = nombreMedico;
        this.nombrePaciente = nombrePaciente;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCita() {
        return idCita;
    }

    public void setIdCita(int idCita) {
        this.idCita = idCita;
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

    public String getDiagnostico() {
        return diagnostico;
    }

    public void setDiagnostico(String diagnostico) {
        this.diagnostico = diagnostico;
    }

    public String getMedicamento() {
        return Medicamento;
    }

    public void setMedicamento(String Medicamento) {
        this.Medicamento = Medicamento;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
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
    
}
