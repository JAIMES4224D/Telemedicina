/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.inserta;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "registroServlet", urlPatterns = {"/registroServlet"})
@MultipartConfig(
    maxFileSize = 1024 * 1024 * 5,    // 5 MB
    maxRequestSize = 1024 * 1024 * 10, // 10 MB
    fileSizeThreshold = 1024 * 1024     // 1 MB
)
public class registroServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // Variables para almacenar los datos
        String nombres = null;
        String apellidos = null;
        String fechaNacStr = null;
        String genero = null;
        String tipoDocumento = null;
        String numeroDocumento = null;
        String telefono = null;
        String correo = null;
        String direccion = null;
        String ciudad = null;
        String antecedentes = null;
        String grupoSanguineo = null;
        String userName = null;
        String passwordDate = null;
        Part fotoPart = null;
        
        try {
            // Obtener todas las partes del formulario
            Collection<Part> parts = request.getParts();
            
            // Procesar cada parte
            for (Part part : parts) {
                String fieldName = part.getName();
                
                if (part.getContentType() == null) {
                    // Es un campo de texto normal
                    String fieldValue = getValueFromPart(part);
                    
                    // Asignar a la variable correspondiente
                    switch (fieldName) {
                        case "nombres": nombres = fieldValue; break;
                        case "apellidos": apellidos = fieldValue; break;
                        case "fechaNacimiento": fechaNacStr = fieldValue; break;
                        case "genero": genero = fieldValue; break;
                        case "tipoDocumento": tipoDocumento = fieldValue; break;
                        case "numeroDocumento": numeroDocumento = fieldValue; break;
                        case "telefono": telefono = fieldValue; break;
                        case "correo": correo = fieldValue; break;
                        case "direccion": direccion = fieldValue; break;
                        case "ciudad": ciudad = fieldValue; break;
                        case "antecedentes": antecedentes = fieldValue; break;
                        case "grupoSanguineo": grupoSanguineo = fieldValue; break;
                        case "userName": userName = fieldValue; break;
                        case "passwordDate": passwordDate = fieldValue; break;
                    }
                } else if ("fotografia".equals(fieldName)) {
                    // Es la foto
                    fotoPart = part;
                }
            }
            
            // 📌 Fecha de nacimiento (validada)
            java.sql.Date fechaNacimiento = null;
            if (fechaNacStr != null && !fechaNacStr.isEmpty()) {
                try {
                    fechaNacimiento = java.sql.Date.valueOf(fechaNacStr);
                } catch (IllegalArgumentException e) {
                    System.out.println("⚠️ Error en fechaNacimiento: " + fechaNacStr);
                }
            }

            // 📌 Fecha de registro (se toma la actual del sistema)
            java.sql.Date fechaRegistro = new java.sql.Date(System.currentTimeMillis());

            // Llamar al DAO
            inserta inf = new inserta();
            int registrado = inf.insertarPaciente(
                nombres, apellidos, fechaNacimiento, genero, tipoDocumento,
                numeroDocumento, fotoPart, telefono, correo, direccion,
                ciudad, antecedentes, grupoSanguineo, fechaRegistro, userName, passwordDate
            );

            // Mostrar respuesta
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang='es'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                out.println("<title>Resultado Registro</title>");
                out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("</head>");
                out.println("<body class='d-flex align-items-center justify-content-center vh-100 bg-light'>");

                if (registrado > 0) {
                    out.println("<div class='card text-center p-5 shadow-lg' style='max-width: 400px;'>");
                    out.println("<div class='text-success mb-3'><i class='bi bi-check-circle-fill' style='font-size: 4rem;'></i></div>");
                    out.println("<h3 class='text-success'>Paciente registrado</h3>");
                    out.println("<p>El paciente se ha registrado correctamente.</p>");
                    out.println("<a href='web_principal/index.html' class='btn btn-success mt-3'>Aceptar</a>");
                    out.println("</div>");
                } else {
                    out.println("<div class='card text-center p-5 shadow-lg' style='max-width: 400px;'>");
                    out.println("<div class='text-danger mb-3'><i class='bi bi-x-circle-fill' style='font-size: 4rem;'></i></div>");
                    out.println("<h3 class='text-danger'>No se pudo registrar</h3>");
                    out.println("<p>Inténtelo de nuevo.</p>");
                    out.println("<a href='web_principal/registro.jsp' class='btn btn-danger mt-3'>Reintentar</a>");
                    out.println("</div>");
                }

                out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js'></script>");
                out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css' rel='stylesheet'>");
                out.println("</body>");
                out.println("</html>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error procesando el formulario: " + e.getMessage());
        }
    }

    // Método auxiliar para obtener el valor de un Part
    private String getValueFromPart(Part part) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"));
        StringBuilder value = new StringBuilder();
        char[] buffer = new char[1024];
        int length;
        while ((length = reader.read(buffer)) > 0) {
            value.append(buffer, 0, length);
        }
        return value.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
