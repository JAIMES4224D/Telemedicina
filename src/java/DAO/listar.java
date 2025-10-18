/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import conexion.conexionbd;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import modelo.citaMedica;
import modelo.historiaClinica;
import modelo.horario;
import modelo.medico;
import modelo.medicoFoto;
import modelo.mensajesContacto;
import modelo.paciente;
import modelo.pacienteFoto;
import modelo.receta;

/**
 *
 * @author JEJALUOS
 */
public class listar {
    conexionbd cbd = new conexionbd();
    Connection cn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;
    public List<medico> listarMedico(){
        List<medico> listMed = new ArrayList<>();
        String sql = "SELECT m.nombres, m.apellidos, e.nombreEspecialidad, \n" +
                     "       m.numeroColegiatura, m.numeroTelefono, m.correoElectronico\n" +
                     "FROM medico m\n" +
                     "INNER JOIN especialidad e ON m.idEspecialidad = e.id;";
        try{
            cn = cbd.getConexion();
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            while(rs.next()){
                medico m = new medico();
                m.setNombres(rs.getString("nombres"));
                m.setApellidos(rs.getString("apellidos"));
                m.setNombreEspecialidad(rs.getString("nombreEspecialidad"));
                m.setNumeroColegiatura(rs.getString("numeroColegiatura"));
                m.setNumeroTelefono(rs.getString("numeroTelefono"));
                m.setCorreoElectronico(rs.getString("correoElectronico"));
                listMed.add(m);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return listMed;
    } 
    public List<paciente> listarPaciente(){
        List<paciente> listPac = new ArrayList<>();
        String sql = "SELECT nombres, apellidos, genero, tipoDocumento, numeroDocumento, telefono, correo, direccion, ciudad, fechaRegistro\n" +
                    " FROM paciente";
        try{
            cn = cbd.getConexion();
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            while(rs.next()){
                paciente p = new paciente();
                p.setNombres(rs.getString("nombres"));
                p.setApellidos(rs.getString("apellidos"));
                p.setGenero(rs.getString("genero"));
                p.setTipoDocumento(rs.getString("tipoDocumento"));
                p.setNumeroDocumento(rs.getString("numeroDocumento"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setDireccion(rs.getString("direccion"));
                p.setCiudad(rs.getString("ciudad"));
                p.setFechaRegistro(rs.getDate("fechaRegistro"));
                listPac.add(p);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return listPac;
    }
    public List<citaMedica> listarCitas(){
        List<citaMedica> lista = new ArrayList<>();
        String sql = "SELECT m.nombres AS Medico,\n" +
"	p.nombres AS Paciente,\n" +
"    e.nombreEspecialidad AS especialidad,\n" +
"    c.id ,c.horaInicio, c.horaFin, c.estado, c.fechaRegistro, c.precio\n" +
"FROM  citamedica c, paciente p, especialidad e, enlacemeet em, medico m\n" +
"WHERE c.idMedico = m.idMedico AND c.idPaciente = p.idPaciente AND c.idEspecialidad = e.id \n" +
"AND c.idEnlace = em.id";
        
        
        try{
            cn = cbd.getConexion();
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            while(rs.next()){
                citaMedica c = new citaMedica();
                c.setId(rs.getInt("id")); 
                c.setNombreMedico(rs.getString("Medico"));
                c.setNombrePaciente(rs.getString("Paciente"));
                c.setNombreEspecialidad(rs.getString("especialidad"));
                c.setHoraInicio(rs.getDate("horaInicio"));
                c.setHoraFin(rs.getDate("horaFin"));
                c.setEstado(rs.getString("estado"));
                c.setFechaRegistro(rs.getDate("fechaRegistro"));
                c.setPrecio(rs.getDouble("precio"));
                lista.add(c);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    
    public List<citaMedica> listarCitasP(int idPaciente){
    List<citaMedica> lista = new ArrayList<>();
    String sql = "SELECT m.nombres AS Medico, " +
                 "p.nombres AS Paciente, " +
                 "e.nombreEspecialidad AS especialidad, " +
                 "c.horaInicio, c.horaFin, c.estado, c.fechaRegistro, c.precio, c.enlace " +
                 "FROM citamedica c " +
                 "INNER JOIN paciente p ON c.idPaciente = p.idPaciente " +
                 "INNER JOIN medico m ON c.idMedico = m.idMedico " +
                 "INNER JOIN especialidad e ON c.idEspecialidad = e.id " +
                 "LEFT JOIN enlacemeet em ON c.idEnlace = em.id " +
                 "WHERE c.idPaciente = ?";
    
    Connection cn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;
    
    try{
        cn = cbd.getConexion();
        pt = cn.prepareStatement(sql);
        pt.setInt(1, idPaciente);
        rs = pt.executeQuery();
        
        while(rs.next()){
            citaMedica c = new citaMedica();
            c.setNombreMedico(rs.getString("Medico"));
            c.setNombrePaciente(rs.getString("Paciente"));
            c.setNombreEspecialidad(rs.getString("especialidad"));
            c.setHoraInicio1(rs.getTimestamp("horaInicio"));
            c.setHoraFin1(rs.getTimestamp("horaFin"));
            c.setEstado(rs.getString("estado"));
            c.setFechaRegistro(rs.getDate("fechaRegistro"));
            c.setPrecio(rs.getDouble("precio"));
            c.setEnlace(rs.getString("enlace"));
            lista.add(c);
        }
    } catch(Exception e){
        e.printStackTrace();
    } finally {
        // Cerrar recursos
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pt != null) pt.close(); } catch (Exception e) {}
        try { if (cn != null) cn.close(); } catch (Exception e) {}
    }
    return lista;
}
    
    public List<historiaClinica> listarHistoria(){
        List<historiaClinica> lista = new ArrayList<>();
        String sql = "SELECT p.nombres as paciente,h.sintomas,h.diagnostico, h.descripcion, h.fechaRegistro\n" +
"FROM  historiaclinica h, paciente p\n" +
"WHERE h.idPaciente = p.idPaciente";
        
        
        try{
            cn = cbd.getConexion();
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            while(rs.next()){
                historiaClinica c = new historiaClinica();
                c.setNombrePac(rs.getString("paciente"));
                c.setSintomas(rs.getString("sintomas"));
                c.setDiagnostico(rs.getString("diagnostico"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setFechaRegistro(rs.getDate("fechaRegistro"));
                lista.add(c);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    public List<mensajesContacto> listarMensajes(){
        List<mensajesContacto> lista = new ArrayList<>();
        String sql = "SELECT * FROM comentarios_contacto";
        try{
            cn = cbd.getConexion();
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            while(rs.next()){
                mensajesContacto m = new mensajesContacto();
                m.setId(rs.getInt("id"));
                m.setNombresCompletos(rs.getString("nombresCompletos"));
                m.setCorreoElectronico(rs.getString("correoElectronico"));
                m.setTelefono(rs.getString("telefono"));
                m.setAsunto(rs.getString("asunto"));
                m.setMensaje(rs.getString("mensaje"));
                lista.add(m);
                
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    public List<medico> listarMedicoP(int idEspecialidad){
        List<medico> lista = new ArrayList<>();
        String sql = "SELECT * FROM medico WHERE idEspecialidad = ?";
        try{
            cn = cbd.getConexion();
            pt = cn.prepareStatement(sql);
            pt.setInt(1, idEspecialidad);
            rs = pt.executeQuery();
            
            while(rs.next()){
                medico m = new medico();
                m.setIdMedico(rs.getInt("idMedico"));
                m.setNombres(rs.getString("nombres"));
                m.setApellidos(rs.getString("apellidos"));
                lista.add(m);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    
  public List<horario> listarHorarioP(int idMedico) {
    List<horario> lista = new ArrayList<>();
    Connection cn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;
    
    String sql = "SELECT * FROM horarios WHERE idMedico = ?";
    
    try {
        cn = cbd.getConexion();
        pt = cn.prepareStatement(sql);
        pt.setInt(1, idMedico);
        rs = pt.executeQuery();
        
        while(rs.next()) {
            horario h = new horario();
            h.setId(rs.getInt("id"));
            h.setIdMedico(rs.getInt("idMedico"));
            
            // CORRECTO: Usar getTimestamp() para campos DATETIME
            h.setHoraInicio(rs.getTimestamp("horaInicio"));
            h.setHoraFin(rs.getTimestamp("horaFin"));
            
            h.setEnlace(rs.getString("enlace"));
            lista.add(h);
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pt != null) pt.close(); } catch (Exception e) {}
        try { if (cn != null) cn.close(); } catch (Exception e) {}
    }
    return lista;
}
  public List<receta> listarRecetasP(int idPaciente){
      List<receta> lista = new ArrayList<>();
      String sql = "SELECT \n" +
                    "    r.id, \n" +
                    "    r.idCita, \n" +
                    "    r.idMedico, \n" +
                    "    r.idPaciente, \n" +
                    "    r.diagnostico, \n" +
                    "    r.medicamento, \n" +
                    "    r.fecha, \n" +
                    "    m.nombres AS medico, \n" +
                    "    p.nombres AS paciente\n" +
                    "FROM receta r\n" +
                    "INNER JOIN medico m ON r.idMedico = m.idMedico\n" +
                    "INNER JOIN paciente p ON r.idPaciente = p.idPaciente\n" +
                    "WHERE r.idPaciente = ?;";
      
      try{
          cn = cbd.getConexion();
          pt = cn.prepareStatement(sql);
          pt.setInt(1, idPaciente);
          
          rs = pt.executeQuery();
          
          while(rs.next()){
              receta r = new receta();
              r.setId(rs.getInt("id"));
              r.setIdCita(rs.getInt("idCita"));
              r.setIdMedico(rs.getInt("idMedico"));
              r.setIdPaciente(rs.getInt("idPaciente"));
              r.setDiagnostico(rs.getString("diagnostico"));
              r.setMedicamento(rs.getString("medicamento"));
              r.setFecha(rs.getTimestamp("fecha"));
              r.setNombreMedico(rs.getString("medico"));
              r.setNombrePaciente(rs.getString("paciente"));
              lista.add(r);
          }
      }catch(Exception e){
          e.printStackTrace();
      }
      return lista;
  }
  public List<receta> listarReceta(int idReceta){
      List<receta> lista = new ArrayList<>();
      String sql = "SELECT \n" +
                    "    r.id, \n" +
                    "    r.idCita, \n" +
                    "    r.idMedico, \n" +
                    "    r.idPaciente, \n" +
                    "    r.diagnostico, \n" +
                    "    r.medicamento, \n" +
                    "    r.fecha, \n" +
                    "    m.nombres AS medico, \n" +
                    "    p.nombres AS paciente\n" +
                    "FROM receta r\n" +
                    "INNER JOIN medico m ON r.idMedico = m.idMedico\n" +
                    "INNER JOIN paciente p ON r.idPaciente = p.idPaciente\n" +
                    "WHERE r.id = ?;";
      try{
          cn = cbd.getConexion();
          pt = cn.prepareStatement(sql);
          pt.setInt(1, idReceta);
          rs = pt.executeQuery();
          while(rs.next()){
              receta r = new receta();
              r.setId(rs.getInt("id"));
              r.setIdCita(rs.getInt("idCita"));
              r.setIdMedico(rs.getInt("idMedico"));
              r.setIdPaciente(rs.getInt("idPaciente"));
              r.setDiagnostico(rs.getString("diagnostico"));
              r.setMedicamento(rs.getString("medicamento"));
              r.setFecha(rs.getTimestamp("fecha"));
              r.setNombreMedico(rs.getString("medico"));
              r.setNombrePaciente(rs.getString("paciente"));
              lista.add(r);
          }
          
      }catch(Exception e){
          e.printStackTrace();
      }
      return lista;
  }
  public List<historiaClinica>  listarHistoria(int idPaciente){
      List<historiaClinica> lista = new ArrayList<>();
      String sql = "SELECT h.id, h.idPaciente,h.sintomas, h.diagnostico, h.descripcion, h.fechaRegistro, p.nombres as paciente\n" +
                    "FROM historiaclinica h\n" +
                    "INNER JOIN paciente p ON h.idPaciente = p.idPaciente\n"+
                    "WHERE h.idPaciente = ?";
      
      try{
          cn = cbd.getConexion();
          pt = cn.prepareStatement(sql);
          pt.setInt(1, idPaciente);
          rs = pt.executeQuery();
          
          while(rs.next()){
              historiaClinica h = new historiaClinica();
              h.setId(rs.getInt("id"));
              h.setIdPaciente(rs.getInt("idPaciente"));
              h.setSintomas(rs.getString("sintomas"));
              h.setDiagnostico(rs.getString("diagnostico"));
              h.setDescripcion(rs.getString("descripcion"));
              h.setFechaRegistro(rs.getDate("fechaRegistro"));
              h.setNombrePac(rs.getString("paciente"));
              lista.add(h);
          }
          
      }catch(Exception e){
          e.printStackTrace();
      }
      return lista;
  }
  public List<pacienteFoto> listarPacienteFoto(int idPaciente) {
    List<pacienteFoto> lista = new ArrayList<>();
    String sql = "SELECT * FROM paciente WHERE idPaciente = ?";

    try (Connection cn = cbd.getConexion();
         PreparedStatement pt = cn.prepareStatement(sql)) {

        pt.setInt(1, idPaciente);
        try (ResultSet rs = pt.executeQuery()) {
            while (rs.next()) {
                pacienteFoto p = new pacienteFoto();
                p.setIdPaciente(rs.getInt("idPaciente"));
                p.setNombres(rs.getString("nombres"));
                p.setApellidos(rs.getString("apellidos"));
                p.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                p.setGenero(rs.getString("genero"));
                p.setTipoDocumento(rs.getString("tipoDocumento"));
                p.setNumeroDocumento(rs.getString("numeroDocumento"));
                p.setFoto(rs.getBytes("fotografia")); // 👈 asegúrate del nombre real en tu BD
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setDireccion(rs.getString("direccion"));
                p.setCiudad(rs.getString("ciudad"));
                p.setAntecedentes(rs.getString("antecedentes"));
                p.setGrupoSanguineo(rs.getString("grupoSanguineo"));
                p.setFechaRegistro(rs.getDate("fechaRegistro"));
                p.setUsername(rs.getString("username"));
                p.setUserpassword(rs.getString("userpassword"));
                
                lista.add(p);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return lista;
}
  public List<medicoFoto> listarMedicoFoto(int idMedico) {
    List<medicoFoto> lista = new ArrayList<>();
    String sql = "SELECT m.nombres, m.apellidos, m.fotografia, e.nombreEspecialidad, m.numeroColegiatura, m.correoElectronico, m.numeroTelefono\n" +
                "FROM medico m, especialidad e\n" +
                "WHERE e.id =m.idEspecialidad  AND m.idMedico = ?\n" +
                "  ";

    try (Connection cn = cbd.getConexion();
         PreparedStatement pt = cn.prepareStatement(sql)) {

        pt.setInt(1, idMedico);
        try (ResultSet rs = pt.executeQuery()) {
            while (rs.next()) {
                medicoFoto p = new medicoFoto();
                p.setNombres(rs.getString("nombres"));
                p.setApellidos(rs.getString("apellidos"));
                p.setNombreEspecialidad(rs.getString("nombreEspecialidad"));
                p.setNumeroColegiatura(rs.getString("numeroColegiatura"));
                p.setCorreoElectronico(rs.getString("correoElectronico"));
                p.setNumeroTelefono(rs.getString("numeroTelefono"));
                p.setFoto(rs.getBytes("fotografia")); // 👈 asegúrate del nombre real en tu BD
                
                lista.add(p);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return lista;
}
  public List<citaMedica> listarCitasMedicos(int idMedico){
    List<citaMedica> lista = new ArrayList<>();
    // Corrección en la consulta: agregar espacio después de "c.enlace" y antes de "FROM"
    String sql = "SELECT m.nombres AS Medico, " +
               "p.nombres AS Paciente, " +
               "e.nombreEspecialidad AS especialidad, " +
               "c.id, c.horaInicio, c.horaFin, c.estado, c.fechaRegistro, c.precio, c.enlace " + // Espacio agregado después de c.enlace
               "FROM citamedica c " +
               "INNER JOIN paciente p ON c.idPaciente = p.idPaciente " +
               "INNER JOIN medico m ON c.idMedico = m.idMedico " +
               "INNER JOIN especialidad e ON c.idEspecialidad = e.id " +
               "LEFT JOIN enlacemeet em ON c.idEnlace = em.id " +
               "WHERE c.idMedico = ?";
    try{
        cn = cbd.getConexion();
        pt = cn.prepareStatement(sql);
        pt.setInt(1, idMedico);
        rs = pt.executeQuery();
        
        while(rs.next()){
          citaMedica c = new citaMedica();
          c.setId(rs.getInt("id")); 
          c.setNombreMedico(rs.getString("Medico"));
          c.setNombrePaciente(rs.getString("Paciente"));
          c.setNombreEspecialidad(rs.getString("especialidad"));
          c.setHoraInicio1(rs.getTimestamp("horaInicio"));
          c.setHoraFin1(rs.getTimestamp("horaFin"));
          c.setEstado(rs.getString("estado"));
          c.setFechaRegistro(rs.getDate("fechaRegistro"));
          c.setPrecio(rs.getDouble("precio"));
          c.setEnlace(rs.getString("enlace"));
          lista.add(c);
        }
        
    }catch(Exception e){
        e.printStackTrace();
    } finally {
        // Asegúrate de cerrar los recursos (rs, pt, cn) aquí para evitar fugas.
        try {
            if (rs != null) rs.close();
            if (pt != null) pt.close();
            if (cn != null) cn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    return lista;
}
  
  public List<paciente> listarPaciente(int idMedico){
      List<paciente> lista = new ArrayList<>();
      String sql =  "SELECT p.nombres, p.apellidos, p.correo, p.telefono\n" +
                    " FROM citamedica c, paciente p WHERE idMedico = ?";
      try{
          cn = cbd.getConexion();
          pt = cn.prepareStatement(sql);
          pt.setInt(1, idMedico);
          rs = pt.executeQuery();
          
          while(rs.next()){
              paciente p = new paciente();
              p.setNombres(rs.getString("nombres"));
              p.setApellidos(rs.getString("apellidos"));
              p.setCorreo(rs.getString("correo"));
              p.setTelefono(rs.getString("telefono"));
              lista.add(p);
          }
          
      }catch(Exception e){
          e.printStackTrace();
      }
      return lista;
  }
  public List<citaMedica> listarCitaAtencion(int idCita){
      List<citaMedica> lista = new ArrayList<>();
      String sql =  "SELECT \n" +
                    "	c.id, c.idMedico, c.idPaciente, c.idEspecialidad, c.idEnlace, c.horaInicio, c.horaFin, c.estado,\n" +
                    "    c.fechaRegistro, c.precio, c.enlace,\n" +
                    "    m.nombres AS medico, p.nombres AS paciente, e.nombreEspecialidad AS especialidad\n" +
                    "    FROM citamedica c\n" +
                    "    INNER JOIN medico m ON m.idMedico = c.idMedico\n" +
                    "    INNER JOIN paciente p ON p.idPaciente = c.idPaciente\n" +
                    "    INNER JOIN especialidad e ON e.id = c.idEspecialidad\n" +
                    "    WHERE c.id = ?";
      try{
          cn = cbd.getConexion();
          pt = cn.prepareStatement(sql);
          pt.setInt(1, idCita);
          rs = pt.executeQuery();
          
          while(rs.next()){
              citaMedica c = new citaMedica();
              c.setId(rs.getInt("id"));
              c.setIdMedico(rs.getInt("idMedico"));
              c.setIdEspecialidad(rs.getInt("idEspecialidad"));
              c.setIdPaciente(rs.getInt("idPaciente"));
              c.setIdEnlace(rs.getInt("idEnlace"));
              c.setHoraInicio(rs.getDate("horaInicio"));
              c.setHoraFin(rs.getDate("horaFin"));
              c.setEstado(rs.getString("estado"));
              c.setFechaRegistro(rs.getDate("fechaRegistro"));
              c.setPrecio(rs.getDouble("precio"));
              c.setEnlace(rs.getString("enlace"));
              c.setNombreMedico(rs.getString("medico"));
              c.setNombrePaciente(rs.getString("paciente"));
              c.setNombreEspecialidad(rs.getString("especialidad"));
              lista.add(c);
              
          }
          
      }catch(Exception e){
          e.printStackTrace();
      }
      return lista;
  }
}
