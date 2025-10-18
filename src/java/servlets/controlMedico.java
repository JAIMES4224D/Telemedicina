/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.contar;
import DAO.listar;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.citaMedica;
import modelo.medicoFoto;
import modelo.paciente;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "controlMedico", urlPatterns = {"/controlMedico"})
public class controlMedico extends HttpServlet {

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
        listar l = new listar();
        contar contar = new contar();
        if(acc.equals("dashboard")){
            Integer idMedico = (Integer) request.getSession().getAttribute("idMedico");
            if(idMedico != null){
                System.out.println("idMedico = " + idMedico);
                int cantCitas = contar.cantidadCitas(idMedico);
                int cantComp = contar.cantidadCitasCompletadas(idMedico);
                int cantPend = contar.cantidadCitasPendiente(idMedico);
                
                HttpSession s = request.getSession();
                s.setAttribute("cantCitas", cantCitas);
                s.setAttribute("citasComp", cantComp);
                s.setAttribute("citasPend", cantPend);
                
                request.getRequestDispatcher("/users/medico/medicoPrincipal.jsp").forward(request, response);
                
            }else{
                response.sendRedirect("logeo/iniciarSesion.jsp?error=Debe iniciar sesión");
            }
        }
        if(acc.equals("misCitas")){
              Integer idMedico = (Integer) request.getSession().getAttribute("idMedico");
            List<citaMedica> lista = l.listarCitasMedicos(idMedico);
            System.out.println("lista = " + lista.get(0));
            request.setAttribute("listaCitas", lista);
            request.getRequestDispatcher("users/medico/misCitas.jsp").forward(request, response);
        }
        if(acc.equals("pacientes")){
            Integer idMedico = (Integer) request.getSession().getAttribute("idMedico");
            List<paciente> lista = l.listarPaciente(idMedico);
            request.setAttribute("listaCitas", lista);
            request.getRequestDispatcher("users/medico/misPacientes.jsp").forward(request, response);
        }
        if(acc.equals("horarios")){
            Integer idMedico = (Integer) request.getSession().getAttribute("idMedico");
            String inicio = contar.getinicio(idMedico) ;
            System.out.println("inicio = " + inicio);
            String fin = contar.getfinal(idMedico);
            System.out.println("fin = " + fin);
            HttpSession s = request.getSession();
            s.setAttribute("inicio", inicio );
            s.setAttribute("fin", fin );
            request.getRequestDispatcher("users/medico/historias.jsp").forward(request, response);
        }
        if(acc.equals("reportes")){
            response.sendRedirect("users/medico/reportes.jsp");
        }
        if(acc.equals("miPerfil")){
            Integer idMedico = (Integer) request.getSession().getAttribute("idMedico");
            List<medicoFoto> lista = l.listarMedicoFoto(idMedico);
            request.setAttribute("listaPerfil", lista);
            request.getRequestDispatcher("users/medico/miPerfil.jsp").forward(request, response);
        }
        if(acc.equals("atender")){
            Integer idCita = Integer.parseInt(request.getParameter("idCita"));
            System.out.println("idCita = " + idCita);
            List<citaMedica> lista = l.listarCitaAtencion(idCita);
            System.out.println("lista = " + lista);
            citaMedica c = lista.get(0);
            System.out.println(c.getEnlace() + c.getId()+ c.getIdEspecialidad());
            System.out.println("idPaciente: "+ c.getIdPaciente());
            System.out.println(c.getNombreMedico());
            request.setAttribute("listaCitaAtencion", lista);
            request.getRequestDispatcher("users/medico/atencion.jsp").forward(request, response);
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
