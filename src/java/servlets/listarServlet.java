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
import modelo.medico;
import modelo.mensajesContacto;
import modelo.paciente;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "listarServlet", urlPatterns = {"/listarServlet"})
public class listarServlet extends HttpServlet {

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
        String acc = request.getParameter("acc");
        listar listar = new listar();
        if(acc.equals("lmedico")){
            List<medico> medico = listar.listarMedico();
            request.setAttribute("listaMedicos", medico);
            request.getRequestDispatcher("users/administrativo/listaMedicos.jsp").forward(request, response);
        }

        if (acc.equals("lpaciente")) {
            List<paciente> listaPacientes = listar.listarPaciente();
            request.setAttribute("listaPacientes", listaPacientes);
            request.getRequestDispatcher("/users/administrativo/listaPacientes.jsp").forward(request, response);
        }

        if(acc.equals("lcita")){
            List<citaMedica> listaCita = listar.listarCitas();
            request.setAttribute("listarCitas", listaCita);
            request.getRequestDispatcher("/users/administrativo/listaCitas.jsp").forward(request, response);
        }
        if(acc.equals("lhistorial")){
            List<historiaClinica> listaCita = listar.listarHistoria();
            request.setAttribute("listarHist", listaCita);
            request.getRequestDispatcher("/users/administrativo/listaHistoriales.jsp").forward(request, response);
        }
        if(acc.equals("mensajeWeb")){
            List<mensajesContacto> listaMensaje = listar.listarMensajes() ;
            request.setAttribute("listaMensajes", listaMensaje);
            request.getRequestDispatcher("/users/administrativo/mensajesWeb.jsp").forward(request, response);
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
