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
public class mensajesContacto {
    private int id;
    private String nombresCompletos;
    private String correoElectronico;
    private String telefono;
    private String asunto;
    private String mensaje;

    public mensajesContacto(int id, String nombresCompletos, String correoElectronico, String telefono, String asunto, String mensaje) {
        this.id = id;
        this.nombresCompletos = nombresCompletos;
        this.correoElectronico = correoElectronico;
        this.telefono = telefono;
        this.asunto = asunto;
        this.mensaje = mensaje;
    }

    public mensajesContacto() {
        
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getNombresCompletos() {
        return nombresCompletos;
    }

    public void setNombresCompletos(String nombresCompletos) {
        this.nombresCompletos = nombresCompletos;
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

    public String getAsunto() {
        return asunto;
    }

    public void setAsunto(String asunto) {
        this.asunto = asunto;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
    
}
