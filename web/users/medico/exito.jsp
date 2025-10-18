<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Éxito - Atención de Cita</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .success-container {
            text-align: center;
            padding: 40px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.07);
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-container">
            <i class="bi bi-check-circle-fill" style="font-size: 3rem; color: #28a745;"></i>
            <h2 class="mt-3">¡Atención Completada!</h2>
            <p class="text-muted">${mensaje}</p>
            
            <div class="mt-4">
                <a href="<%= request.getContextPath() %>/controlMedico?acc=dashboard&idMedico=<%= session.getAttribute("idMedico") %>" 
                   class="btn btn-primary">
                    <i class="bi bi-house"></i> Volver al Inicio
                </a>
                <a href="<%= request.getContextPath() %>/controlMedico?acc=misCitas&idMedico=<%= session.getAttribute("idMedico") %>" 
                   class="btn btn-outline-secondary ms-2">
                    <i class="bi bi-calendar-check"></i> Ver Mis Citas
                </a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>