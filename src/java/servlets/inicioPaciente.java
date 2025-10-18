/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.listar;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.citaMedica;
import modelo.historiaClinica;
import modelo.paciente;
import modelo.pacienteFoto;
import modelo.receta;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "inicioPaciente", urlPatterns = {"/inicioPaciente"})
public class inicioPaciente extends HttpServlet {

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
        listar l = new listar();
        paciente p = new paciente();
        String acc = request.getParameter("acc");
        if(acc.equals("actualizar")){
            response.sendRedirect("users/paciente/pacientePrincipal.jsp");
        }
        if(acc.equals("reservarCita")){
            response.sendRedirect("users/paciente/reservarCita.jsp");
        }
        if(acc.equals("misCitas")){
            // Obtener el idPaciente directamente de la sesión
            Integer idPaciente = (Integer) request.getSession().getAttribute("idPaciente");

            if (idPaciente != null) {
                System.out.println("idPaciente = " + idPaciente);
                List<citaMedica> lista = l.listarCitasP(idPaciente);
                request.setAttribute("listaCitas", lista);
                request.getRequestDispatcher("users/paciente/misCitas.jsp").forward(request, response);
            } else {
                // Redirigir al login o mostrar error
                response.sendRedirect("loginPaciente.jsp?error=Debe iniciar sesión");
            }
        }
        if(acc.equals("historial")){
            Integer idPaciente = (Integer) request.getSession().getAttribute("idPaciente");
            List<historiaClinica> lista = l.listarHistoria(idPaciente);
            request.setAttribute("listaHistorial", lista);
            request.getRequestDispatcher("users/paciente/miHistoria.jsp").forward(request, response);
        }
        if(acc.equals("recetas")){
            Integer idPaciente = (Integer) request.getSession().getAttribute("idPaciente");
            List<receta> lista = l.listarRecetasP(idPaciente);
            request.setAttribute("listaRecetas", lista);
            request.getRequestDispatcher("users/paciente/misRecetas.jsp").forward(request, response);
        }
        if(acc.equals("pagos")){
            
        }
        if(acc.equals("miperfil")){
            Integer idPaciente = (Integer) request.getSession().getAttribute("idPaciente");
            List<pacienteFoto> lista = l.listarPacienteFoto(idPaciente);
            request.setAttribute("listaRecetas", lista);
            request.getRequestDispatcher("users/paciente/miPerfil.jsp").forward(request, response);
            
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
