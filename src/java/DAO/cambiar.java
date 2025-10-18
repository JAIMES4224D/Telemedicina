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

/**
 *
 * @author JEJALUOS
 */
public class cambiar {
    conexionbd cbd = new conexionbd();
    Connection cn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;
    public int cambiarEstado(int idCita) {
        int cambio = 0;
        String sql = "UPDATE citamedica SET estado = 'Completada' WHERE citamedica.id = ?";

        try {
            cn = cbd.getConexion();
            pt = cn.prepareStatement(sql);
            pt.setInt(1, idCita);
            
            int filasAfectadas = pt.executeUpdate();

            if (filasAfectadas > 0) {
                cambio = 1; // Indicar éxito
                System.out.println("Estado de la cita " + idCita + " cambiado a 'Completada'");
            }

        } catch (SQLException e) {
            System.err.println("Error al cambiar el estado de la cita: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (pt != null) pt.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        return cambio;
    }
}
