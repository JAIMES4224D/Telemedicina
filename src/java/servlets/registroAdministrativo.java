/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.inserta;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
@WebServlet(name = "registroAdministrativo", urlPatterns = {"/registroAdministrativo"})
@MultipartConfig(
    maxFileSize = 1024 * 1024 * 5,    // 5 MB
    maxRequestSize = 1024 * 1024 * 10, // 10 MB
    fileSizeThreshold = 1024 * 1024     // 1 MB
)
public class registroAdministrativo extends HttpServlet {

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
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String cargo = request.getParameter("cargo");
        String area = request.getParameter("area");
        String correoElectronico = request.getParameter("correoElectronico");
        String telefono = request.getParameter("telefono");
        String descripcion = request.getParameter("descripcion");
        String username = request.getParameter("username");
        String userpassword = request.getParameter("userpassword");

        // Fotografía (tipo Part)
        Part fotoPart = request.getPart("foto");
        InputStream fotoInputStream = null;
        if (fotoPart != null && fotoPart.getSize() > 0) {
            fotoInputStream = fotoPart.getInputStream();
        }
        inserta in = new inserta();
        int registrado = in.registrarAdministrativo(nombres, apellidos, fotoPart, cargo, area, correoElectronico, telefono, telefono, descripcion, username, userpassword);
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
                    out.println("<h3 class='text-success'>Administrativo registrado</h3>");
                    out.println("<p>El medico se ha registrado correctamente.</p>");
                    out.println("<a href='users/administrativo/administrativoPrincipal.jsp' class='btn btn-success mt-3'>Aceptar</a>");
                    out.println("</div>");
                } else {
                    out.println("<div class='card text-center p-5 shadow-lg' style='max-width: 400px;'>");
                    out.println("<div class='text-danger mb-3'><i class='bi bi-x-circle-fill' style='font-size: 4rem;'></i></div>");
                    out.println("<h3 class='text-danger'>No se pudo registrar</h3>");
                    out.println("<p>Inténtelo de nuevo.</p>");
                    out.println("<a href='users/administrativo/registrarAdministrativo.jsp' class='btn btn-danger mt-3'>Reintentar</a>");
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
