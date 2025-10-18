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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "registrarHorario", urlPatterns = {"/registrarHorario"})
public class registrarHorario extends HttpServlet {

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
        try {
            int idMedico = Integer.parseInt(request.getParameter("idMedico"));
            String horaInicioStr = request.getParameter("horaInicio");
            String horaFinStr = request.getParameter("horaFin");
            String enlace = request.getParameter("enlace");

            // Convertir Strings a LocalDateTime
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime inicio = LocalDateTime.parse(horaInicioStr, formatter);
            LocalDateTime fin = LocalDateTime.parse(horaFinStr, formatter);

            // Conexión
            conexionbd c = new conexionbd();
            Connection cn = c.getConexion();

            String sql = "INSERT INTO horarios (idMedico, horaInicio, horaFin) VALUES (?, ?, ?)";
            PreparedStatement ps = cn.prepareStatement(sql);

            // Insertar en intervalos de 1 hora
            LocalDateTime actual = inicio;
            while (actual.isBefore(fin)) {
                LocalDateTime siguiente = actual.plusHours(1);

                ps.setInt(1, idMedico);
                ps.setTimestamp(2, Timestamp.valueOf(actual));
                ps.setTimestamp(3, Timestamp.valueOf(siguiente));
                ps.executeUpdate();

                actual = siguiente;
            }

            ps.close();
            cn.close();

            response.sendRedirect("users/administrativo/registrarHorarios.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("users/administrativo/registrarHorarios.jsp");
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
