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
import java.util.HashMap;
import java.util.Map;
import modelo.administrativo;
import modelo.medico;
import modelo.paciente;

/**
 *
 * @author JEJALUOS
 */
public class loginDAO {
    conexionbd c = new conexionbd();
    Connection cn = c.getConexion();
    PreparedStatement pt = null;
    ResultSet rs = null;
    
    
   public int comprobarUsuario(String userName, String password, String tipoUsuario) {
        int result = 0; // 0 = no encontrado, 1 = encontrado, 2 = error

        try (Connection cn = c.getConexion()) {
            String tabla = "";
            String idField = "";

            switch (tipoUsuario.toLowerCase()) {
                case "administrativo":
                    tabla = "administrativo";
                    idField = "idAdministrativo";
                    break;
                case "medico":
                    tabla = "medico";
                    idField = "idMedico";
                    break;
                case "paciente":
                    tabla = "paciente";
                    idField = "idPaciente";
                    break;
                default:
                    return 0; // tipoUsuario inválido
            }

            String sql = "SELECT * FROM " + tabla + " WHERE username = ? AND userpassword = ?";
            PreparedStatement pt = cn.prepareStatement(sql);
            pt.setString(1, userName);
            pt.setString(2, password);

            ResultSet rs = pt.executeQuery();

            if (rs.next()) {
                result = 1; // usuario encontrado
            }

        } catch (SQLException e) {
            e.printStackTrace();
            result = 2; // error
        }

        return result;
    }
   
    public int obtenerId(String userName, String passwordDate, String tipo) {
        int id = 0;
        String idField = "";
        String tabla = "";

        switch (tipo.toLowerCase()) {
            case "paciente":
                idField = "idPaciente";
                tabla = "paciente";
                break;
            case "administrativo":
                idField = "idAdministrativo";
                tabla = "administrativo";
                break;
            case "medico":
                idField = "idMedico";
                tabla = "medico";
                break;
            default:
                return 0; // tipo inválido
        }

        String sql = "SELECT " + idField + " FROM " + tabla + " WHERE username = ? AND userpassword = ?";

        try {
            pt = cn.prepareStatement(sql);
            pt.setString(1, userName);
            pt.setString(2, passwordDate);

            rs = pt.executeQuery();

            if (rs.next()) {
                id = rs.getInt(idField);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return id;
    }
    
    public paciente obtenerPaciente(int id) {
        paciente ipaciente = null;
        //aca un cambio
        String sql = "SELECT p.nombres, p.apellidos, p.fechaNacimiento, p.genero, " +
                     "p.tipoDocumento, p.numeroDocumento, p.telefono, p.correo, " +
                     "p.direccion, p.ciudad, p.antecedentes, p.grupoSanguineo, p.fechaRegistro " +
                     "FROM paciente p WHERE p.idPaciente = ?";
        try {
            pt = cn.prepareStatement(sql);
            pt.setInt(1, id);

            rs = pt.executeQuery(); // ✅ ejecutar consulta

            if (rs.next()) {
                ipaciente = new paciente();
                ipaciente.setIdPaciente(id);
                ipaciente.setNombres(rs.getString("nombres"));
                ipaciente.setApellidos(rs.getString("apellidos"));
                ipaciente.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                ipaciente.setGenero(rs.getString("genero"));
                ipaciente.setTipoDocumento(rs.getString("tipoDocumento"));
                ipaciente.setNumeroDocumento(rs.getString("numeroDocumento"));
                ipaciente.setTelefono(rs.getString("telefono"));
                ipaciente.setCorreo(rs.getString("correo"));
                ipaciente.setDireccion(rs.getString("direccion"));
                ipaciente.setCiudad(rs.getString("ciudad"));
                ipaciente.setAntecedentes(rs.getString("antecedentes")); // ✅ corregido
                ipaciente.setGrupoSanguineo(rs.getString("grupoSanguineo"));
                ipaciente.setFechaRegistro(rs.getDate("fechaRegistro"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pt != null) pt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return ipaciente;
    }

    public medico obtenerMedico(int id) {
        medico imedico = null;
        String sql = "SELECT idMedico, nombres, apellidos, idEspecialidad, idSubespecialidad, " +
                     "numeroColegiatura, universidad, correoElectronico, numeroTelefono, descripcion " +
                     "FROM medico WHERE idMedico = ?";

        try {
            pt = cn.prepareStatement(sql);
            pt.setInt(1, id);
            rs = pt.executeQuery();

            if (rs.next()) {
                imedico = new medico();
                imedico.setIdMedico(rs.getInt("idMedico"));
                imedico.setNombres(rs.getString("nombres"));
                imedico.setApellidos(rs.getString("apellidos"));
                imedico.setIdEspecialidad(rs.getInt("idEspecialidad"));
                imedico.setIdSubespecialidad(rs.getInt("idSubespecialidad"));
                imedico.setNumeroColegiatura(rs.getString("numeroColegiatura"));
                imedico.setUniversidad(rs.getString("universidad"));
                imedico.setCorreoElectronico(rs.getString("correoElectronico"));
                imedico.setNumeroTelefono(rs.getString("numeroTelefono"));
                imedico.setDescripcion(rs.getString("descripcion"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return imedico;
    }

    public administrativo obtenerAdministrativo(int id) {
        administrativo iadministrativo = null;
        String sql = "SELECT idAdministrativo, nombres, apellidos, cargo, area, " +
                     "correoElectronico, telefono, profesion, descripcion, username, userpassword " +
                     "FROM administrativo WHERE idAdministrativo = ?";

        try {
            pt = cn.prepareStatement(sql);
            pt.setInt(1, id);
            rs = pt.executeQuery();

            if (rs.next()) {
                iadministrativo = new administrativo();
                iadministrativo.setIdAdministrativo(rs.getInt("idAdministrativo"));
                iadministrativo.setNombres(rs.getString("nombres"));
                iadministrativo.setApellidos(rs.getString("apellidos"));
                iadministrativo.setCargo(rs.getString("cargo"));
                iadministrativo.setArea(rs.getString("area"));
                iadministrativo.setCorreoElectronico(rs.getString("correoElectronico"));
                iadministrativo.setTelefono(rs.getString("telefono"));
                iadministrativo.setProfesion(rs.getString("profesion"));
                iadministrativo.setDescripcion(rs.getString("descripcion"));
                iadministrativo.setUsername(rs.getString("username"));
                iadministrativo.setUserpassword(rs.getString("userpassword"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return iadministrativo;
    }
    public int cantidadMedicos(){
        int cantidadMedicosRegistrados = 0;
        String sql = "SELECT COUNT(*) AS total FROM medico;";
        try{
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            if(rs.next()){
                cantidadMedicosRegistrados = rs.getInt("total");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return cantidadMedicosRegistrados;
    }
    public int cantidadPacientes(){
        int cantPacientes = 0;
        String sql = "SELECT COUNT(*) AS total FROM paciente";
        try{
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            if(rs.next()){
                cantPacientes = rs.getInt("total");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return cantPacientes;
    }
    
    public int cantidadCitas(){
        int cantCitas = 0;
        String sql = "SELECT CONUT(*) AS total FROM citamedica";
        try{
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            if(rs.next()){
                cantCitas = rs.getInt("total");
            }
            
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return cantCitas;
    }
    public int cantAdministrativos(){
        int cantAdm = 0;
        String sql = "SELECT COUNT(*) AS total FROM administrativo";
        try{
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            if(rs.next()){
                cantAdm = rs.getInt("total");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return cantAdm;
    }



}
