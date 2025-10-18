/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.inserta;
import conexion.conexionbd;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
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
@WebServlet(name = "registroMeet", urlPatterns = {"/registroMeet"})
public class registroMeet extends HttpServlet {

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
         // Recibir parámetros del formulario
        String enlace = request.getParameter("enlace");
        String idHorarioStr = request.getParameter("idHorario");

        int actualizado = 0;

        try {
            int idHorario = Integer.parseInt(idHorarioStr);

            conexionbd c = new conexionbd();
            Connection conn = c.getConexion();

            String sql = "UPDATE horarios SET enlace = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, enlace);
            ps.setInt(2, idHorario);

            actualizado = ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Respuesta al usuario
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='es'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Resultado</title>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css' rel='stylesheet'>");
            out.println("</head>");
            out.println("<body class='d-flex align-items-center justify-content-center vh-100 bg-light'>");

            out.println("<div class='card shadow-lg text-center p-5' style='max-width: 450px;'>");

            if (actualizado > 0) {
                out.println("<div class='text-success mb-3'><i class='bi bi-check-circle-fill' style='font-size:4rem;'></i></div>");
                out.println("<h3 class='text-success'>¡Enlace agregado correctamente!</h3>");
                out.println("<p class='mt-3'>El enlace de Meet se registró de forma exitosa en el sistema.</p>");
                out.println("<a href='users/administrativo/registrarMeet.jsp' class='btn btn-success mt-3'>Volver al registro</a>");
            } else {
                out.println("<div class='text-danger mb-3'><i class='bi bi-x-circle-fill' style='font-size:4rem;'></i></div>");
                out.println("<h3 class='text-danger'>Error al guardar</h3>");
                out.println("<p class='mt-3'>No se pudo registrar el enlace. Intente nuevamente.</p>");
                out.println("<a href='users/administrativo/registrarMeet.jsp' class='btn btn-danger mt-3'>Reintentar</a>");
            }

            out.println("</div>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js'></script>");
            out.println("</body>");
            out.println("</html>");
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
