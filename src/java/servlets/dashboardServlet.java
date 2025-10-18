/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import com.mysql.cj.xdevapi.PreparableStatement;
import conexion.conexionbd;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.*;
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
@WebServlet(name = "dashboardServlet", urlPatterns = {"/dashboardServlet"})
public class dashboardServlet extends HttpServlet {

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
        conexionbd bd = new conexionbd();
        Connection c = bd.getConexion();
        PreparedStatement pt = null;
        ResultSet rs = null;

        String sql = "SELECT " +
            "(SELECT COUNT(*) FROM medico) AS totalM, " +
            "(SELECT COUNT(*) FROM paciente) AS totalP, " +
            "(SELECT COUNT(*) FROM citamedica) AS totalC, " +
            "(SELECT COUNT(*) FROM administrativo) AS totalA;";

        int cantMedicos = 0;
        int cantPacientes = 0;
        int cantCitas = 0;
        int cantAdmi = 0;

        try {
            pt = c.prepareStatement(sql);
            rs = pt.executeQuery();

            if (rs.next()) {
                cantMedicos = rs.getInt("totalM");
                cantPacientes = rs.getInt("totalP");
                cantCitas = rs.getInt("totalC");
                cantAdmi = rs.getInt("totalA");
            }

            // Guardar en la sesión
            HttpSession s = request.getSession();
            s.setAttribute("cantMedicos", cantMedicos);
            s.setAttribute("cantPacientes", cantPacientes);
            s.setAttribute("cantCitas", cantCitas);
            s.setAttribute("cantAdm", cantAdmi);
            
            request.getRequestDispatcher("/users/administrativo/administrativoPrincipal.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (pt != null) pt.close(); } catch (Exception ex) {}
            try { if (c != null) c.close(); } catch (Exception ex) {}
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
