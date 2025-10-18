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
@WebServlet(name = "ConfirmarCitaServlet", urlPatterns = {"/ConfirmarCitaServlet"})
public class ConfirmarCitaServlet extends HttpServlet {

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
        // Obtener parámetros del formulario
        String idEspecialidad = request.getParameter("idEspecialidad");
        String idMedico = request.getParameter("idMedico");
        String idHorario = request.getParameter("idHorario");
        String idPaciente = request.getParameter("idPaciente");
        String precio = request.getParameter("precio");
        
        Connection cn = null;
        PreparedStatement pt = null;
        ResultSet rs = null;
        
        try {
            cn = new conexionbd().getConexion();
            
            // Obtener nombre de especialidad
            String nombreEspecialidad = "";
            String sqlEspecialidad = "SELECT nombreEspecialidad FROM especialidad WHERE id = ?";
            pt = cn.prepareStatement(sqlEspecialidad);
            pt.setInt(1, Integer.parseInt(idEspecialidad));
            rs = pt.executeQuery();
            if (rs.next()) {
                nombreEspecialidad = rs.getString("nombreEspecialidad");
            }
            rs.close();
            pt.close();
            
            // Obtener datos del médico
            String nombresMedico = "", apellidosMedico = "";
            String sqlMedico = "SELECT nombres, apellidos FROM medico WHERE idMedico = ?";
            pt = cn.prepareStatement(sqlMedico);
            pt.setInt(1, Integer.parseInt(idMedico));
            rs = pt.executeQuery();
            if (rs.next()) {
                nombresMedico = rs.getString("nombres");
                apellidosMedico = rs.getString("apellidos");
            }
            rs.close();
            pt.close();
            
            // Obtener datos del horario
            String horaInicio = "", horaFin = "", fecha = "";
            String sqlHorario = "SELECT horaInicio, horaFin FROM horarios WHERE id = ?";
            pt = cn.prepareStatement(sqlHorario);
            pt.setInt(1, Integer.parseInt(idHorario));
            rs = pt.executeQuery();
            if (rs.next()) {
                horaInicio = rs.getString("horaInicio");
                horaFin = rs.getString("horaFin");
            }
            HttpSession session = request.getSession();
            // Guardar datos en la sesión para el proceso de confirmación
            session.setAttribute("idEspecialidad", idEspecialidad);
            session.setAttribute("idMedico", idMedico);
            session.setAttribute("idHorario", idHorario);
            session.setAttribute("precioCita", precio);
            session.setAttribute("nombreEspecialidad", nombreEspecialidad);
            session.setAttribute("nombresMedico", nombresMedico);
            session.setAttribute("apellidosMedico", apellidosMedico);
            session.setAttribute("horaInicio", horaInicio);
            session.setAttribute("horaFin", horaFin);
            
            // Redirigir a la página de confirmación
            request.getRequestDispatcher("users/paciente/confirmacionCita.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("users/paciente/reservarCita.jsp?error=Error al procesar la solicitud");
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
