package DAO;
import java.sql.*;
import conexion.conexionbd;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.Part;
import modelo.receta;

/**
 *
 * @author JEJALUOS
 */
public class inserta {
    conexionbd c = new conexionbd();
    Connection cn = c.getConexion();
    PreparedStatement pt = null;
    ResultSet rs = null;
    public int insertarMensaje(String nombre, String email, String telefono, String asunto, String mensaje){
        int retornado = 0;
        String sql = "INSERT INTO comentarios_contacto(nombresCompletos,correoElectronico,telefono,asunto,mensaje) VALUES (?,?,?,?,?)";
        
        try{
            pt = cn.prepareStatement(sql);
            pt.setString(1, nombre);
            pt.setString(2, email);
            pt.setString(3, telefono);
            pt.setString(4, asunto);
            pt.setString(5, mensaje);
            retornado = pt.executeUpdate();
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return retornado;
    }
    
    public int insertarPaciente(
        String nombres, String apellidos, java.sql.Date fechaNacimiento, String genero,
        String tipoDocumento, String numeroDocumento, Part fotografia, String telefono,
        String correo, String direccion, String ciudad, String antecedentes,
        String grupoSanguineo, java.sql.Date fechaRegistro,
        String userName, String passwordDate) {

        int registrado = 0;
        
        // ✅ CONSULTA CORREGIDA - Nombres de columnas exactos como en la BD
        String sql = "INSERT INTO paciente (nombres, apellidos, fechaNacimiento, genero, "
                   + "tipoDocumento, numeroDocumento, fotografia, telefono, correo, "
                   + "direccion, ciudad, antecedentes, grupoSanguineo, fechaRegistro, "
                   + "username, userpassword) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection cn = c.getConexion();
             PreparedStatement pt = cn.prepareStatement(sql)) {

            // Setear parámetros
            pt.setString(1, nombres);
            pt.setString(2, apellidos);
            pt.setDate(3, fechaNacimiento);
            pt.setString(4, genero);
            pt.setString(5, tipoDocumento);
            pt.setString(6, numeroDocumento);

            // Manejo de la fotografía
            if (fotografia != null && fotografia.getSize() > 0) {
                pt.setBlob(7, fotografia.getInputStream());
            } else {
                pt.setNull(7, java.sql.Types.BLOB);
            }

            pt.setString(8, telefono);
            pt.setString(9, correo);
            pt.setString(10, direccion);
            pt.setString(11, ciudad);
            pt.setString(12, antecedentes);
            pt.setString(13, grupoSanguineo);
            pt.setDate(14, fechaRegistro);
            pt.setString(15, userName);
            pt.setString(16, passwordDate);

            // Ejecutar inserción
            registrado = pt.executeUpdate();
            
            if (registrado > 0) {
                System.out.println("✅ Paciente insertado correctamente");
            } else {
                System.out.println("❌ No se pudo insertar el paciente");
            }

        } catch (Exception e) {
            System.out.println("❌ Error al insertar paciente: " + e.getMessage());
            e.printStackTrace();
        }
        
        return registrado;
    }
    
    public int registrarMedico(String nombres, String apellidos, Part foto, int idEspecialidad, int subEspecialidad, 
                           String colegiatura, String universidad, String telefono, String correo, 
                           String descripcion, String username, String userpassword) {
    int registrado = 0;
    String sql = "INSERT INTO medico (nombres, apellidos, fotografia, idEspecialidad, idSubEspecialidad, " +
                 "numeroColegiatura, universidad, correoElectronico, numeroTelefono, descripcion, username, userpassword) " +
                 "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
    try {
        Connection cn = c.getConexion();
        PreparedStatement pt = cn.prepareStatement(sql);
        pt.setString(1, nombres);
        pt.setString(2, apellidos);

        if (foto != null && foto.getSize() > 0) {
            pt.setBlob(3, foto.getInputStream());
        } else {
            pt.setNull(3, java.sql.Types.BLOB);
        }

        pt.setInt(4, idEspecialidad);
        pt.setInt(5, subEspecialidad);
        pt.setString(6, colegiatura);
        pt.setString(7, universidad);
        pt.setString(8, correo);      // correoElectronico
        pt.setString(9, telefono);    // numeroTelefono
        pt.setString(10, descripcion); // descripcion (antes pusiste direccion)
        pt.setString(11, username);
        pt.setString(12, userpassword);

        registrado = pt.executeUpdate();

        if (registrado > 0) {
            System.out.println("✅ Médico insertado correctamente");
        } else {
            System.out.println("❌ No se pudo insertar el médico");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return registrado;
}
   public int registrarAdministrativo(String nombres, String apellidos, Part foto, 
                           String cargo, String area, String correoElectronico, String telefono, 
                           String profeison, String descripcion, String username,String userpassword) {
    int registrado = 0;
    String sql = "INSERT INTO administrativo (nombres, apellidos, foto, cargo, area, " +
                 "correoElectronico, telefono,profesion, descripcion, username, userpassword) " +
                 "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
    try {
        Connection cn = c.getConexion();
        PreparedStatement pt = cn.prepareStatement(sql);
        pt.setString(1, nombres);
        pt.setString(2, apellidos);

        if (foto != null && foto.getSize() > 0) {
            pt.setBlob(3, foto.getInputStream());
        } else {
            pt.setNull(3, java.sql.Types.BLOB);
        }

        pt.setString(4, cargo);
        pt.setString(5, area);
        pt.setString(6, correoElectronico);
        pt.setString(7, telefono);
        pt.setString(8, profeison);      // correoElectronico
        pt.setString(9, descripcion); // descripcion (antes pusiste direccion)
        pt.setString(10, username);
        pt.setString(11, userpassword);

        registrado = pt.executeUpdate();

        if (registrado > 0) {
            System.out.println("✅ Médico insertado correctamente");
        } else {
            System.out.println("❌ No se pudo insertar el médico");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return registrado;
}
   public int registrarEspecialidad(String nombreEspecialidad, double precio){
       int registrado = 0;
       String sql = "INSERT INTO especialidad(nombreEspecialidad, precio) VALUES(?, ?)";
       try{
           Connection cn = c.getConexion();
           PreparedStatement pt = cn.prepareStatement(sql);
           pt.setString(1, nombreEspecialidad);
           pt.setDouble(2, precio);
           
           registrado = pt.executeUpdate();
           
           if(registrado > 0){
               System.out.println("Especialidad insertada");
           } else {
               System.out.println("No se pudo insertar");
           }
       }catch(Exception e){
           e.printStackTrace();
       }
       return registrado;
   }
   
  

public int registrarEnlace(Timestamp horaInicio, Timestamp horaFin, String enlace) {
    int registrado = 0;
    Connection conn = null;
    PreparedStatement ps = null;
    conexionbd c = new conexionbd();

    try {
        conn = c.getConexion();

        String sql = "INSERT INTO enlacesmeet (horaInicio, horaFin, enlace) VALUES (?, ?, ?)";
        ps = conn.prepareStatement(sql);

        ps.setTimestamp(1, horaInicio);
        ps.setTimestamp(2, horaFin);
        ps.setString(3, enlace);

        registrado = ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    return registrado;
}

public int insertarHistoriaClinica(int idPaciente, String sintomas, String diagnostico, String descripcion) {
        // Validar parámetros
        if (idPaciente <= 0 || diagnostico == null || diagnostico.trim().isEmpty()) {
            System.err.println("Parámetros inválidos para historia clínica");
            return 0;
        }
        
        int idGenerado = 0;
        String sql = "INSERT INTO historiaclinica(idPaciente, sintomas, diagnostico, descripcion, fechaRegistro) VALUES(?,?,?,?,CURRENT_TIMESTAMP)";
        
        PreparedStatement pt = null;
        ResultSet rs = null;
        
        try {
            cn = c.getConexion();
            pt = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pt.setInt(1, idPaciente);
            pt.setString(2, sintomas != null ? sintomas : "");
            pt.setString(3, diagnostico);
            pt.setString(4, descripcion != null ? descripcion : "");
            
            System.out.println("Ejecutando inserción de historia clínica: " + pt.toString());
            
            int filasAfectadas = pt.executeUpdate();
            
            if (filasAfectadas > 0) {
                rs = pt.getGeneratedKeys();
                if (rs.next()) {
                    idGenerado = rs.getInt(1);
                    System.out.println("Historia clínica insertada con ID: " + idGenerado);
                }
            } else {
                System.err.println("No se insertó ninguna fila en historia clínica");
            }
            
        } catch (SQLException e) {
            System.err.println("Error al insertar historia clínica: " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(null, pt, rs);
        }
        
        return idGenerado;
    }
public int insertarReceta(int idCita, int idMedico, int idPaciente, String diagnostico, String medicamento) {
        // Validar parámetros
        if (idCita <= 0 || idMedico <= 0 || idPaciente <= 0 || 
            diagnostico == null || diagnostico.trim().isEmpty()) {
            System.err.println("Parámetros inválidos para receta");
            return 0;
        }
        
        int resultado = 0;
        String sql = "INSERT INTO receta (idCita, idMedico, idPaciente, diagnostico, medicamento, fecha) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        
        PreparedStatement pt = null;
        
        try {
            cn = c.getConexion();
            pt = cn.prepareStatement(sql);
            pt.setInt(1, idCita);
            pt.setInt(2, idMedico);
            pt.setInt(3, idPaciente);
            pt.setString(4, diagnostico);
            pt.setString(5, medicamento != null ? medicamento : "");
            
            System.out.println("Ejecutando inserción de receta: " + pt.toString());
            
            resultado = pt.executeUpdate();
            
            if (resultado > 0) {
                System.out.println("Receta insertada correctamente");
            } else {
                System.err.println("No se insertó ninguna fila en recetas");
            }
            
        } catch (SQLException e) {
            System.err.println("Error al insertar receta: " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(null, pt, null);
        }
        
        return resultado;
    }
    
    public List<receta> obtenerRecetasPorCita(int idCita) {
        List<receta> recetas = new ArrayList<>();
        String sql = "SELECT * FROM recetas WHERE idCita = ? ORDER BY fecha DESC";
        
        try (Connection cn = c.getConexion();
             PreparedStatement pt = cn.prepareStatement(sql)) {
            
            pt.setInt(1, idCita);
            ResultSet rs = pt.executeQuery();
            
            while (rs.next()) {
                receta receta = new receta();
                receta.setId(rs.getInt("id"));
                receta.setIdCita(rs.getInt("idCita"));
                receta.setIdMedico(rs.getInt("idMedico"));
                receta.setIdPaciente(rs.getInt("idPaciente"));
                receta.setDiagnostico(rs.getString("diagnostico"));
                receta.setMedicamento(rs.getString("medicamento"));
                receta.setFecha(rs.getTimestamp("fecha"));
                
                
                recetas.add(receta);
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener recetas: " + e.getMessage());
            e.printStackTrace();
        }
        
        return recetas;
    }

     
    private void cerrarRecursos(Connection cn, PreparedStatement pt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pt != null) pt.close();
            // No cerramos la conexión aquí para poder reutilizarla en múltiples operaciones
        } catch (SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
    
    public void cerrarConexion() {
        try {
            if (cn != null && !cn.isClosed()) {
                cn.close();
                System.out.println("Conexión cerrada");
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
}
