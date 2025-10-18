/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import com.mysql.jdbc.PreparedStatement;
import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import conexion.conexionbd;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author JEJALUOS
 */
public class contar {
private conexionbd cbd = new conexionbd();
private Connection cn = null;
private PreparedStatement pt = null;
private ResultSet rs = null;

public int cantidadCitas(int idMedico) {
    int cantidad = 0;
    String sql = "SELECT COUNT(*) AS total FROM citamedica WHERE idMedico = ?";
    
    try (Connection cn = cbd.getConexion();
         PreparedStatement pt = (PreparedStatement) cn.prepareStatement(sql)) {
        
        pt.setInt(1, idMedico);
        
        try (ResultSet rs = pt.executeQuery()) {
            if (rs.next()) {
                cantidad = rs.getInt("total");
            }
        }
    } catch (SQLException e) {
        // Log the exception properly
        e.printStackTrace();
    }
    
    return cantidad;
}

public int cantidadCitasCompletadas(int idMedico) {
    int cantidad = 0;
    String sql = "SELECT COUNT(*) AS total FROM citamedica WHERE estado = \"Completada\" and idMedico = ?";
    
    try (Connection cn = cbd.getConexion();
         PreparedStatement pt = (PreparedStatement) cn.prepareStatement(sql)) {
        
        pt.setInt(1, idMedico);
        
        try (ResultSet rs = pt.executeQuery()) {
            if (rs.next()) {
                cantidad = rs.getInt("total");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return cantidad;
}
 

public int cantidadCitasPendiente(int idMedico) {
    int cantidad = 0;
    String sql = "SELECT COUNT(*) AS total FROM citamedica WHERE estado = \"Pendiente\" and idMedico = ?";
    
    try (Connection cn = cbd.getConexion();
         PreparedStatement pt = (PreparedStatement) cn.prepareStatement(sql)) {
        
        pt.setInt(1, idMedico);
        
        try (ResultSet rs = pt.executeQuery()) {
            if (rs.next()) {
                cantidad = rs.getInt("total");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return cantidad;
}
public String getinicio(int idMedico){
    Timestamp inicio = null;
    String sql = "SELECT MIN(horaInicio) AS inicio FROM citamedica WHERE idMedico = ?;";
    try{
        cn = cbd.getConexion();
        pt = (PreparedStatement) cn.prepareStatement(sql);
        pt.setInt(1, idMedico);
        rs = pt.executeQuery();
        
        if(rs.next()){
            inicio = rs.getTimestamp("inicio");
        }
        
    }catch(Exception e){
        e.printStackTrace();
    }
    
    return String.valueOf(inicio);
}
public String getfinal(int idMedico){
    Timestamp inicio = null;
    String sql = "SELECT MAX(horaFin) AS inicio FROM citamedica WHERE idMedico = ?;";
    try{
        cn = cbd.getConexion();
        pt = (PreparedStatement) cn.prepareStatement(sql);
        pt.setInt(1, idMedico);
        rs = pt.executeQuery();
        
        if(rs.next()){
            inicio = rs.getTimestamp("inicio");
        }
        
    }catch(Exception e){
        e.printStackTrace();
    }
    
    return String.valueOf(inicio);
}
public String getRestaH(int idMedico){
    Timestamp inicio = null;
    String sql = "SELECT MAX(horaFin) AS fin, MIN(horaInicio) AS inicio FROM citamedica WHERE idMedico = ?;";
    try{
        cn = cbd.getConexion();
        pt = (PreparedStatement) cn.prepareStatement(sql);
        pt.setInt(1, idMedico);
        rs = pt.executeQuery();
        
        if(rs.next()){
            inicio = rs.getTimestamp("inicio");
        }
        
    }catch(Exception e){
        e.printStackTrace();
    }
    
    return String.valueOf(inicio);
}
}
