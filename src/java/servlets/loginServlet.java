/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.contar;
import DAO.loginDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.administrativo;
import modelo.medico;
import modelo.paciente;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "loginServlet", urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

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
        loginDAO ld = new loginDAO();
        contar contar = new contar();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String tipoUsuario = request.getParameter("tipoUsuario");

        // Validar login
        int resultado = ld.comprobarUsuario(username, password, tipoUsuario);

        if (resultado == 1) {
            // Obtener id del usuario
            int idUser = ld.obtenerId(username, password, tipoUsuario);

            if ("administrativo".equalsIgnoreCase(tipoUsuario)) {
                administrativo iadministrativo = ld.obtenerAdministrativo(idUser);
                int cantMedicos = ld.cantidadMedicos() ;
                int cantPacientes = ld.cantidadPacientes() ;
                int cantCitas = ld.cantidadCitas() ;
                int cantAdm = ld.cantAdministrativos() ;
                if (iadministrativo != null) {
                    HttpSession datosAdmi = request.getSession();
                    datosAdmi.setAttribute("idAdministrativo", iadministrativo.getIdAdministrativo());
                    datosAdmi.setAttribute("nombres", iadministrativo.getNombres());
                    datosAdmi.setAttribute("apellidos", iadministrativo.getApellidos());
                    datosAdmi.setAttribute("cargo", iadministrativo.getCargo());
                    datosAdmi.setAttribute("area", iadministrativo.getArea());
                    datosAdmi.setAttribute("correoElectronico", iadministrativo.getCorreoElectronico());
                    datosAdmi.setAttribute("telefono", iadministrativo.getTelefono());
                    datosAdmi.setAttribute("profesion", iadministrativo.getProfesion());
                    datosAdmi.setAttribute("descripcion", iadministrativo.getDescripcion());
                    datosAdmi.setAttribute("username", iadministrativo.getUsername());
                    datosAdmi.setAttribute("userpassword", iadministrativo.getUserpassword());
                    datosAdmi.setAttribute("cantMedicos", cantMedicos);
                    datosAdmi.setAttribute("cantPacientes", cantPacientes);
                    datosAdmi.setAttribute("cantCitas", cantCitas);
                    datosAdmi.setAttribute("cantAdm", cantAdm);

                    request.getRequestDispatcher("users/administrativo/administrativoPrincipal.jsp").forward(request, response);
                } else {
                    response.sendRedirect("index.html");
                }

            } else if ("medico".equalsIgnoreCase(tipoUsuario)) {
                medico imedico = ld.obtenerMedico(idUser);
                int cantCitas = contar.cantidadCitas(idUser);
                int citasComp = contar.cantidadCitasCompletadas(idUser);
                int citasPend = contar.cantidadCitasPendiente(idUser);
                String especialidad;

                if (imedico != null) {
                    HttpSession datosMedico = request.getSession();
                    datosMedico.setAttribute("idMedico", imedico.getIdMedico());
                    datosMedico.setAttribute("nombres", imedico.getNombres());
                    datosMedico.setAttribute("apellidos", imedico.getApellidos());
                    datosMedico.setAttribute("idEspecialidad", imedico.getIdEspecialidad());
                    datosMedico.setAttribute("idSubespecialidad", imedico.getIdSubespecialidad());
                    datosMedico.setAttribute("numeroColegiatura", imedico.getNumeroColegiatura());
                    datosMedico.setAttribute("universidad", imedico.getUniversidad());
                    datosMedico.setAttribute("correoElectronico", imedico.getCorreoElectronico());
                    datosMedico.setAttribute("numeroTelefono", imedico.getNumeroTelefono());
                    datosMedico.setAttribute("descripcion", imedico.getDescripcion());
                    datosMedico.setAttribute("cantCitas", cantCitas);
                    datosMedico.setAttribute("citasComp", citasComp);
                    datosMedico.setAttribute("citasPend", citasPend);

                    request.getRequestDispatcher("users/medico/medicoPrincipal.jsp").forward(request, response);
                } else {
                    response.sendRedirect("index.html");
                }

            } else if ("paciente".equalsIgnoreCase(tipoUsuario)) {
                paciente ipaciente = ld.obtenerPaciente(idUser);

                if (ipaciente != null) {
                    HttpSession datosPaciente = request.getSession();
                    datosPaciente.setAttribute("idPaciente", ipaciente.getIdPaciente());
                    datosPaciente.setAttribute("nombres", ipaciente.getNombres());
                    datosPaciente.setAttribute("apellidos", ipaciente.getApellidos());
                    datosPaciente.setAttribute("fechaNacimiento", ipaciente.getFechaNacimiento());
                    datosPaciente.setAttribute("genero", ipaciente.getGenero());
                    datosPaciente.setAttribute("tipoDocumento", ipaciente.getTipoDocumento());
                    datosPaciente.setAttribute("numeroDocumento", ipaciente.getNumeroDocumento());
                    datosPaciente.setAttribute("telefono", ipaciente.getTelefono());
                    datosPaciente.setAttribute("correo", ipaciente.getCorreo());
                    datosPaciente.setAttribute("direccion", ipaciente.getDireccion());
                    datosPaciente.setAttribute("ciudad", ipaciente.getCiudad());
                    datosPaciente.setAttribute("antecedentes", ipaciente.getAntecedentes());
                    datosPaciente.setAttribute("grupoSanguineo", ipaciente.getGrupoSanguineo());
                    datosPaciente.setAttribute("fechaRegistro", ipaciente.getFechaRegistro());

                    request.getRequestDispatcher("users/paciente/pacientePrincipal.jsp").forward(request, response);
                } else {
                    response.sendRedirect("index.html");
                }
            }

        } else if (resultado == 0 || resultado == 2) {
            // ⚠️ Mostrar error y volver al login
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang='es'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                out.println("<title>Inicio de sesion fallido</title>");
                out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("</head>");
                out.println("<body class='d-flex align-items-center justify-content-center vh-100 bg-light'>");
                out.println("<div class='card text-center p-5 shadow-lg' style='max-width: 400px;'>");
                out.println("<div class='text-danger mb-3'><i class='bi bi-x-circle-fill' style='font-size: 4rem;'></i></div>");
                out.println("<h3 class='text-danger'>No se pudo registrar</h3>");
                out.println("<p>USUARIO O CONTRASEÑA INCORRECTO.</p>");
                out.println("<a href='logeo/iniciarSesion.jsp' class='btn btn-danger mt-3'>Reintentar</a>");
                out.println("</div>");
            }catch(Exception e){
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error procesando el formulario: " + e.getMessage());
                }
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
