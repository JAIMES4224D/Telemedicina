/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.listar;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.horario;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "cargarHorarios", urlPatterns = {"/cargarHorarios"})
public class cargarHorarios extends HttpServlet {

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
        int idMedico = Integer.parseInt(request.getParameter("idMedico"));
        listar l = new listar();
        // Consultar horarios disponibles del médico
        List<horario> horarios = l.listarHorarioP(idMedico);
        
        // Convertir a JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        out.print("[");
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        for (int i = 0; i < horarios.size(); i++) {
            horario h = horarios.get(i);
            out.print("{");
            out.print("\"id\":" + h.getId() + ",");
            out.print("\"idMedico\":" + h.getIdMedico() + ",");
            out.print("\"horaInicio\":\"" + (h.getHoraInicio() != null ? dateFormat.format(h.getHoraInicio()) : "") + "\",");
            out.print("\"horaFin\":\"" + (h.getHoraFin() != null ? dateFormat.format(h.getHoraFin()) : "") + "\",");
            out.print("\"enlace\":\"" + (h.getEnlace() != null ? h.getEnlace() : "") + "\"");
            out.print("}");
            
            if (i < horarios.size() - 1) {
                out.print(",");
            }
        }
        
        out.print("]");
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
