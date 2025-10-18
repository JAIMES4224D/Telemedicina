/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.inserta;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "registroEspecialidad", urlPatterns = {"/registroEspecialidad"})
public class registroEspecialidad extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String nombre = request.getParameter("nombreEspecialidad");
        String precioStr = request.getParameter("precio");

        double precio = 0.0; // valor por defecto
        if (precioStr != null && !precioStr.trim().isEmpty()) {
            try {
                precio = Double.parseDouble(precioStr);
            } catch (NumberFormatException e) {
                // Si no se pudo convertir, puedes manejarlo mostrando error
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El precio ingresado no es válido.");
                return; // detener ejecución
            }
        } else {
            // Si no vino el parámetro "precio"
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Debe ingresar un precio.");
            return;
        }
        inserta i = new inserta();
        int registrado = i.registrarEspecialidad(nombre, precio);
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
                    out.println("<h3 class='text-success'>Especialidad registrada</h3>");
                    out.println("<p>El medico se ha registrado correctamente.</p>");
                    out.println("<a href='users/administrativo/registrarEspecialidad.jsp' class='btn btn-success mt-3'>Aceptar</a>");
                    out.println("</div>");
                } else {
                    out.println("<div class='card text-center p-5 shadow-lg' style='max-width: 400px;'>");
                    out.println("<div class='text-danger mb-3'><i class='bi bi-x-circle-fill' style='font-size: 4rem;'></i></div>");
                    out.println("<h3 class='text-danger'>No se pudo registrar</h3>");
                    out.println("<p>Inténtelo de nuevo.</p>");
                    out.println("<a href='users/administrativo/registrarEspecialidad.jsp' class='btn btn-danger mt-3'>Reintentar</a>");
                    out.println("</div>");
                }

                out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js'></script>");
                out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css' rel='stylesheet'>");
                out.println("</body>");
                out.println("</html>");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error procesando el formulario: " + e.getMessage());
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
