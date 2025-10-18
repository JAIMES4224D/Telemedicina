/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.cambiar;
import DAO.inserta;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "ProcesarAtencionCita", urlPatterns = {"/ProcesarAtencionCita"})
public class ProcesarAtencionCita extends HttpServlet {

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
             try {
                String idCita = request.getParameter("idCita");
                int idCitaI = Integer.parseInt(idCita);
                String idMedico = request.getParameter("idMedico");
                int idMedicoI = Integer.parseInt(idMedico);
                String idPaciente = request.getParameter("idPaciente");
                int idPacienteI = Integer.parseInt(idPaciente);
                 System.out.println("idPacienteI = " + idPacienteI);
                String estado = request.getParameter("estado");
                String sintomas = request.getParameter("sintomas");
                String diagnostico = request.getParameter("diagnostico");
                String observaciones = request.getParameter("observaciones");
                String[] medicamentos = request.getParameterValues("medicamento[]");
                String[] dosis = request.getParameterValues("dosis[]");
                String[] frecuencias = request.getParameterValues("frecuencia[]");

                // Convertir arrays a JSON
                String medicamentosJson = convertirArraysAJson(medicamentos, dosis, frecuencias);

                // Cambiar estado de la cita a Completada
                cambiar cambiar = new cambiar();
                inserta i = new inserta();

                int citaCompletada = cambiar.cambiarEstado(idCitaI);
                int insertaHistoria = i.insertarHistoriaClinica(idPacienteI, sintomas, diagnostico, observaciones);
                int insertaReceta = i.insertarReceta(idCitaI, idMedicoI, idPacienteI, diagnostico, medicamentosJson);

                if(citaCompletada > 0 && insertaHistoria > 0 && insertaReceta > 0){
                    // Redirigir a página de éxito
                    request.setAttribute("mensaje", "Atención de cita completada exitosamente");
                    request.getRequestDispatcher("users/medico/exito.jsp").forward(request, response);
                } else {
                    // Redirigir a página de error con mensaje específico
                    String errorMsg = "Error al procesar la atención. ";
                    if(citaCompletada != 1) errorMsg += "No se pudo cambiar el estado de la cita. ";
                    if(insertaHistoria != 1) errorMsg += "No se pudo insertar en el historial clínico. ";
                    if(insertaReceta != 1) errorMsg += "No se pudo guardar la receta médica. ";

                    request.setAttribute("error", errorMsg);
                    request.getRequestDispatcher("users/medico/atencion.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("users/medico/error", "Error inesperado: " + e.getMessage());
                request.getRequestDispatcher("users/medico/error.jsp").forward(request, response);
            }
        
        
    }
    // Método para convertir arrays a JSON
    private String convertirArraysAJson(String[] medicamentos, String[] dosis, String[] frecuencias) {
    // Usar StringBuilder para construir el JSON manualmente
    StringBuilder jsonBuilder = new StringBuilder();
    jsonBuilder.append("[");
    
    if (medicamentos != null) {
        int maxLength = Math.min(medicamentos.length, 
                                Math.min(dosis != null ? dosis.length : 0, 
                                        frecuencias != null ? frecuencias.length : 0));
        
        for (int i = 0; i < maxLength; i++) {
            if (i > 0) jsonBuilder.append(",");
            jsonBuilder.append("{");
            jsonBuilder.append("\"medicamento\":\"").append(medicamentos[i]).append("\",");
            jsonBuilder.append("\"dosis\":\"").append(dosis != null && i < dosis.length ? dosis[i] : "").append("\",");
            jsonBuilder.append("\"frecuencia\":\"").append(frecuencias != null && i < frecuencias.length ? frecuencias[i] : "").append("\"");
            jsonBuilder.append("}");
        }
    }
    
    jsonBuilder.append("]");
    return jsonBuilder.toString();
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
