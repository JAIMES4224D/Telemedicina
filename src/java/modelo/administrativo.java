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
public class administrativo {
    private int idAdministrativo;
    private String nombres;
    private String apellidos;
    private String cargo;
    private String area;
    private String correoElectronico;
    private String telefono;
    private String profesion;
    private String descripcion;
    private String username;
    private String userpassword;

    public administrativo() {
    }

    public administrativo(int idAdministrativo, String nombres, String apellidos, String cargo, String area, String correoElectronico, String telefono, String profesion, String descripcion, String username, String userpassword) {
        this.idAdministrativo = idAdministrativo;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.cargo = cargo;
        this.area = area;
        this.correoElectronico = correoElectronico;
        this.telefono = telefono;
        this.profesion = profesion;
        this.descripcion = descripcion;
        this.username = username;
        this.userpassword = userpassword;
    }

    public int getIdAdministrativo() {
        return idAdministrativo;
    }

    public void setIdAdministrativo(int idAdministrativo) {
        this.idAdministrativo = idAdministrativo;
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

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getProfesion() {
        return profesion;
    }

    public void setProfesion(String profesion) {
        this.profesion = profesion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUserpassword() {
        return userpassword;
    }

    public void setUserpassword(String userpassword) {
        this.userpassword = userpassword;
    }
    
}
