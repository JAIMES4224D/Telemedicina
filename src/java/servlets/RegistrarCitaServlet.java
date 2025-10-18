/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import conexion.conexionbd;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "RegistrarCitaServlet", urlPatterns = {"/RegistrarCitaServlet"})
public class RegistrarCitaServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Obtener datos de la sesión
        Object idEspecialidadObj = session.getAttribute("idEspecialidad");
        Object idMedicoObj = session.getAttribute("idMedico");
        Object idHorarioObj = session.getAttribute("idHorario");
        Object idPacienteObj = session.getAttribute("idPaciente");
        Object precioObj = session.getAttribute("precioCita");
        System.out.println("idEspecialidadObj = " + idEspecialidadObj);
        System.out.println("idMedicoObj = " + idMedicoObj);
        System.out.println("idHorarioObj = " + idHorarioObj);
        System.out.println("idPacienteObj = " + idPacienteObj);
        System.out.println("precioObj = " + precioObj);

        // Convertir
        String idEspecialidad = (idEspecialidadObj != null) ? idEspecialidadObj.toString() : null;
        String idMedico = (idMedicoObj != null) ? idMedicoObj.toString() : null;
        String idHorario = (idHorarioObj != null) ? idHorarioObj.toString() : null;
        String idPaciente = (idPacienteObj != null) ? idPacienteObj.toString() : null;
        String precio = (precioObj != null) ? precioObj.toString() : null;

        // Validar
        if (idEspecialidad == null || idMedico == null || idHorario == null ||
            idPaciente == null || precio == null) {
            response.sendRedirect("/telemdicina/users/paciente/reservarCita.jsp?error=Datos incompletos para la reserva");
            return;
        }

        Connection cn = null;
        PreparedStatement pt = null;
        ResultSet rs = null;

        try {
            cn = new conexionbd().getConexion();

            // 1. Obtener datos del horario seleccionado
            String sqlHorario = "SELECT horaInicio, horaFin, enlace FROM horarios WHERE id = ?";
            pt = cn.prepareStatement(sqlHorario);
            pt.setInt(1, Integer.parseInt(idHorario));
            rs = pt.executeQuery();

            if (rs.next()) {
                Timestamp horaInicio = rs.getTimestamp("horaInicio");
                Timestamp horaFin = rs.getTimestamp("horaFin");
                String enlaceMeet = rs.getString("enlace");

                // 2. Insertar en citamedica
                String sql = "INSERT INTO citamedica " +
                             "(idMedico, idPaciente, idEspecialidad, idEnlace, horaInicio, horaFin, estado, precio, enlace) " +
                             "VALUES (?, ?, ?, 1, ?, ?, 'Pendiente', ?, ?)";

                pt = cn.prepareStatement(sql);
                pt.setInt(1, Integer.parseInt(idMedico));
                pt.setInt(2, Integer.parseInt(idPaciente));
                pt.setInt(3, Integer.parseInt(idEspecialidad));
                pt.setTimestamp(4, horaInicio);
                pt.setTimestamp(5, horaFin);
                pt.setDouble(6, Double.parseDouble(precio));
                pt.setString(7, enlaceMeet);

                int filasAfectadas = pt.executeUpdate();

                if (filasAfectadas > 0) {
                    // 3. Actualizar el horario como ocupado
                    String updateHorario = "UPDATE horarios SET estado = 'Ocupado' WHERE id = ?";
                    pt = cn.prepareStatement(updateHorario);
                    pt.setInt(1, Integer.parseInt(idHorario));
                    pt.executeUpdate();

                    // Limpiar atributos de la sesión
                    session.removeAttribute("idEspecialidad");
                    session.removeAttribute("idMedico");
                    session.removeAttribute("idHorario");
                    session.removeAttribute("precio");

                    // Redirigir
                    response.sendRedirect("/telemdicina/users/paciente/exitoCita.jsp");
                } else {
                    response.sendRedirect("/telemdicina/users/paciente/reservarCita.jsp?error=Error al registrar la cita");
                }
            } else {
                response.sendRedirect("/telemdicina/users/paciente/reservarCita.jsp?error=Horario no encontrado");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/telemdicina/users/paciente/reservarCita.jsp?error=Error en el sistema: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pt != null) pt.close(); } catch (Exception e) {}
            try { if (cn != null) cn.close(); } catch (Exception e) {}
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
