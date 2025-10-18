<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Prueba Sesión</title>
</head>
<body>
    <h2>Valores guardados en la sesión</h2>
    <%
        HttpSession ses = request.getSession(false); // false = no crea nueva sesión
        if (ses != null) {
            Integer idMedico = (Integer) ses.getAttribute("idMedico");
            Integer idPaciente = (Integer) ses.getAttribute("idPaciente");
            Integer idEspecialidad = (Integer) ses.getAttribute("idEspecialidad");
            Integer idHorario = (Integer) ses.getAttribute("idHorario");
            Double precio = (Double) ses.getAttribute("precio");
    %>
            <ul>
                <li><strong>ID Médico:</strong> <%= idMedico %></li>
                <li><strong>ID Paciente:</strong> <%= idPaciente %></li>
                <li><strong>ID Especialidad:</strong> <%= idEspecialidad %></li>
                <li><strong>ID Horario:</strong> <%= idHorario %></li>
                <li><strong>Precio:</strong> S/. <%= precio %></li>
            </ul>
    <%
        } else {
    %>
        <p>No existe una sesión activa.</p>
    <%
        }
    %>
</body>
</html>
