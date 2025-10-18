/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author JEJALUOS
 */
public class medicoFoto {
        private int idMedico;
    private String nombres;
    private String apellidos;
    private int idEspecialidad;
    private int idSubespecialidad;
    private String numeroColegiatura;
    private String universidad;
    private String correoElectronico;
    private String numeroTelefono;
    private String descripcion;
    private String nombreEspecialidad;
    private byte[] foto;

    public medicoFoto() {
    }

    public medicoFoto(int idMedico, String nombres, String apellidos, int idEspecialidad, int idSubespecialidad, String numeroColegiatura, String universidad, String correoElectronico, String numeroTelefono, String descripcion, String nombreEspecialidad, byte[] foto) {
        this.idMedico = idMedico;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.idEspecialidad = idEspecialidad;
        this.idSubespecialidad = idSubespecialidad;
        this.numeroColegiatura = numeroColegiatura;
        this.universidad = universidad;
        this.correoElectronico = correoElectronico;
        this.numeroTelefono = numeroTelefono;
        this.descripcion = descripcion;
        this.nombreEspecialidad = nombreEspecialidad;
        this.foto = foto;
    }

    public int getIdMedico() {
        return idMedico;
    }

    public void setIdMedico(int idMedico) {
        this.idMedico = idMedico;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public int getIdEspecialidad() {
        return idEspecialidad;
    }

    public void setIdEspecialidad(int idEspecialidad) {
        this.idEspecialidad = idEspecialidad;
    }

    public int getIdSubespecialidad() {
        return idSubespecialidad;
    }

    public void setIdSubespecialidad(int idSubespecialidad) {
        this.idSubespecialidad = idSubespecialidad;
    }

    public String getNumeroColegiatura() {
        return numeroColegiatura;
    }

    public void setNumeroColegiatura(String numeroColegiatura) {
        this.numeroColegiatura = numeroColegiatura;
    }

    public String getUniversidad() {
        return universidad;
    }

    public void setUniversidad(String universidad) {
        this.universidad = universidad;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    public String getNumeroTelefono() {
        return numeroTelefono;
    }

    public void setNumeroTelefono(String numeroTelefono) {
        this.numeroTelefono = numeroTelefono;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getNombreEspecialidad() {
        return nombreEspecialidad;
    }

    public void setNombreEspecialidad(String nombreEspecialidad) {
        this.nombreEspecialidad = nombreEspecialidad;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }
    
}
